

import Foundation

struct Song{
    let name: String
    let artistName: String
    let albumName: String
    let trackName: String
    let durations: String
    var fullName: String {
            return "\(artistName) - \(name)"
        }
}
