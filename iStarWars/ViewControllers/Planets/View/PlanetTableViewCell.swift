//
//  PlanetTableViewCell.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 17/05/23.
//

import UIKit

/// A cell or row to show Planet data
class PlanetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessibilityIdentifier = "planetTableViewCell"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        nameLabel.text = ""
        populationLabel.text = "Population:"
    }
    
    func configure(name: String?, population: String?) {
        nameLabel.text = name
        populationLabel.text = "Population: \(population ?? "")"
    }
}
