//
//  PlanetTableViewCell.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 17/05/23.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {

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
