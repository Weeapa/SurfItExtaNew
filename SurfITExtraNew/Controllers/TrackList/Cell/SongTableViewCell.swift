//
//  SongTableViewCell.swift
//  SurfITExtraNew
//
//  Created by Калякин Дима  on 02.10.2023.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
