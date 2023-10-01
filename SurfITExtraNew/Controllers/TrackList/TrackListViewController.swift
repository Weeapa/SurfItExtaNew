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
        songs.append(Song(name: "name1",
                          artistName: "artist1",
                          albumName: "album1",
                          trackName: "classic1"))
        songs.append(Song(name: "name2",
                          artistName: " ",
                          albumName: "album2",
                          trackName: "classic2"))
        songs.append(Song(name: "name3",
                          artistName: "artist3",
                          albumName: "album3",
                          trackName: "classic3"))
        songs.append(Song(name: "name4",
                          artistName: "artist4",
                          albumName: "album4",
                          trackName: "classic4"))
                    
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 16)
        
        cell.accessoryType = .disclosureIndicator
        
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


