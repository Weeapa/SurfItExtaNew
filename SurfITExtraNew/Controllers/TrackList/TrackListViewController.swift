import UIKit

class TrackListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSong()
        
        table.delegate = self
        table.dataSource = self
    }
    
    func configureSong(){
        songs.append(Song(name: "Зима/Лето",
                          artistName: "Вивальди",
                          albumName: "Без альбома",
                          trackName: "classic1"))
        
        songs.append(Song(name: "К Элизе",
                          artistName: "Бетховен",
                          albumName: "Без альбома",
                          trackName: "classic2"))
        
        songs.append(Song(name: "Симфония №5",
                          artistName: "Бетховен",
                          albumName: "Без альбома",
                          trackName: "classic3"))
        
        songs.append(Song(name: "Скрипка и фортепиано",
                          artistName: "Unnowed",
                          albumName: "Без альбома",
                          trackName: "classic4"))
                    
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SongTableViewCell
        let song = songs[indexPath.row]
        
        cell.artistLabel.text = song.artistName
        cell.nameLabel.text = song.name
//        cell.textLabel?.text = song.name
//        cell.detailTextLabel?.text = song.artistName
//
//        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
//        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 16)
//
//        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {return}
        
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
}
