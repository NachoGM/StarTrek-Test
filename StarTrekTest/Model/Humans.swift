//
//  Humans.swift
//  StarTrekTest
//
//  Created by Nacho González Miró on 17/6/18.
//  Copyright © 2018 Nacho González Miró. All rights reserved.
//

import Foundation
import UIKit


struct Humans {
    
    var crewID: String = ""
    var crewRace: String!
    var crewArea: UIColor!
    
    init(with dict: [String: Any]) {
        self.crewID = dict["crewID"] as? String ?? ""
        self.crewRace = dict["crewRace"] as? String ?? ""
        self.crewArea = dict["crewArea"] as? UIColor
    }
    
    init(crewID: String, crewRace: String, crewArea: UIColor) {
        self.crewID = crewID
        self.crewRace = crewRace
        self.crewArea = crewArea
    }
}

