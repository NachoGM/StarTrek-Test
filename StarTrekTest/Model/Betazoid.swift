//
//  Betazoid.swift
//  StarTrekTest
//
//  Created by Nacho González Miró on 17/6/18.
//  Copyright © 2018 Nacho González Miró. All rights reserved.
//

import Foundation
import UIKit
 
struct Betazoid {
    
    var crewID: String = ""
    var crewRace: String!
    var crewArea: UIColor!
    
    init(crewID: String, crewRace: String, crewArea: UIColor) {
        self.crewID = crewID
        self.crewRace = crewRace
        self.crewArea = crewArea
    }
}
