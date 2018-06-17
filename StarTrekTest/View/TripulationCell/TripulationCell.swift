//
//  TripulationCell.swift
//  StarTrekTest
//
//  Created by Nacho González Miró on 17/6/18.
//  Copyright © 2018 Nacho González Miró. All rights reserved.
//

import UIKit

class TripulationCell: UITableViewCell {

    
    @IBOutlet weak var crewIdCharacterLabel: UILabel!
    @IBOutlet weak var areaColorView: UIView!
    @IBOutlet weak var crewIdLabel: UILabel!
    @IBOutlet weak var crewRaceLabel: UILabel!
    @IBOutlet weak var raceMultiplierView: UIView!
    @IBOutlet weak var raceMultiplierLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        raceMultiplierView.layer.borderWidth = 2
        raceMultiplierView.layer.cornerRadius = 10
        raceMultiplierView.layer.borderColor = UIColor.lightGray.cgColor
        crewIdCharacterLabel.textColor = .green
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
