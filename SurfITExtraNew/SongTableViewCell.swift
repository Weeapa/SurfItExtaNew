//
//  SongTableViewCell.swift
//  SurfITExtraNew
//
//  Created by Калякин Дима  on 02.10.2023.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var durattionLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
