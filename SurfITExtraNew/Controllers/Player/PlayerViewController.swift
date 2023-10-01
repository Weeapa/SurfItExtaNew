
import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    // MARK: - Properties
    
    
    
    public var position: Int = 0
    public var songs:[Song] = []
    var player: AVAudioPlayer?
    
    
    // MARK: - Subviews
    
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(timeActionSlieder), for: .touchUpInside)
        return slider
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Close", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.addTarget(self, action: #selector(closePlayerController), for: .touchUpInside)
        return button
    }()
    
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 33)
        let symbolImage = UIImage(systemName: "pause.fill", withConfiguration: symbolConfiguration)
        button.setImage(symbolImage, for: .normal)
        button.addTarget(self, action: #selector(playPauseButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
        let symbolImage = UIImage(systemName: "backward.end.fill", withConfiguration: symbolConfiguration)
        button.setImage(symbolImage, for: .normal)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
        let symbolImage = UIImage(systemName: "forward.end.fill", withConfiguration: symbolConfiguration)
        button.setImage(symbolImage, for: .normal)
        button.addTarget(self, action: #selector(forwardButtonAction(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
    @IBOutlet var holder: UIView!
    
    
    
    
    // MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0{
            
            configure()
            
        }
    }
    
    // MARK: - Private methods
    
    private func changeImagePlayPause(){
        if player?.isPlaying == true{
            player?.pause()
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 33)
            let symbolImage = UIImage(systemName: "play.fill", withConfiguration: symbolConfiguration)
            playPauseButton.setImage(symbolImage, for: .normal)
            
        }
        else{
            player?.play()
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 33)
            let symbolImage = UIImage(systemName: "pause.fill", withConfiguration: symbolConfiguration)
            playPauseButton.setImage(symbolImage, for: .normal)
        }
    }
    
    
    private func configure(){
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            
            guard let player = player else {
                return
            }
            
            changeImagePlayPause()
            
             player.play()

        } catch {
            print("configure error")
        }
        
        songNameLabel.text = song.name
        artistNameLabel.text = song.artistName
        albumNameLabel.text = song.albumName
        
        holder.addSubview(songNameLabel)
        holder.addSubview(artistNameLabel)
        holder.addSubview(albumNameLabel)
        
        holder.addSubview(playPauseButton)
        holder.addSubview(backButton)
        holder.addSubview(forwardButton)
        
        holder.addSubview(closeButton)
        holder.addSubview(slider)
        
        setupConstraints()
      
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            songNameLabel.centerXAnchor.constraint(equalTo: holder.centerXAnchor),
            songNameLabel.centerYAnchor.constraint(equalTo: holder.centerYAnchor),
            songNameLabel.heightAnchor.constraint(equalToConstant: 70),
            songNameLabel.widthAnchor.constraint(equalToConstant: 300),
            
            artistNameLabel.centerXAnchor.constraint(equalTo: holder.centerXAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: -30),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 70),
            artistNameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            albumNameLabel.centerXAnchor.constraint(equalTo: holder.centerXAnchor),
            albumNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: -30),
            albumNameLabel.heightAnchor.constraint(equalToConstant: 70),
            albumNameLabel.widthAnchor.constraint(equalToConstant: 200),
            
            playPauseButton.centerXAnchor.constraint(equalTo: holder.centerXAnchor),
            playPauseButton.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 80),
            
            
            forwardButton.topAnchor.constraint(equalTo: playPauseButton.topAnchor, constant: 2),
            forwardButton.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 40),
            
            backButton.topAnchor.constraint(equalTo: playPauseButton.topAnchor, constant: 3),
            backButton.trailingAnchor.constraint(equalTo: playPauseButton.leadingAnchor, constant: -40),
            
            
            closeButton.topAnchor.constraint(equalTo: holder.topAnchor, constant: 5),
            closeButton.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 5),
            closeButton.heightAnchor.constraint(equalToConstant: 100),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            
            slider.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 20),
            slider.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 20),
            slider.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant: -20),
            
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.stop()
        
    }
    
    
    
    // MARK: - Actions
    
    @objc private func playPauseButtonAction(){
        changeImagePlayPause()
        slider.maximumValue = Float(player!.duration)
        
    }
    
    @objc private func backButtonAction(){
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }else{
            player?.stop()
            
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    
    @objc private func forwardButtonAction(_ sender: UIButton){
        
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            
            configure()
        } else {
            position = position - (songs.count - 1)
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc private func closePlayerController(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func updateSlider (_ sender: UISlider){
        slider.value = Float(player?.currentTime ?? 0)
    }
    
    @objc private func timeActionSlieder(){
        player?.stop()
        player?.currentTime = TimeInterval(slider.value)
        player?.prepareToPlay()
        player?.play()
    }
    
}



extension PlayerViewController: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        forwardButtonAction(forwardButton)
    }
}
