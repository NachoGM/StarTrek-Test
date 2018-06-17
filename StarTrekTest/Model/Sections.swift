//
//  Sections.swift
//  StarTrekTest
//
//  Created by Nacho González Miró on 17/6/18.
//  Copyright © 2018 Nacho González Miró. All rights reserved.
//

import Foundation
import UIKit

struct Section {
    var crewID: String = ""
    var crewRace: [AnyObject]!
    var crewArea: UIColor!
    var expanded: Bool!
    
    init(crewID: String, crewRace: [AnyObject], crewArea: UIColor, expanded: Bool) {
        self.crewID = crewID
        self.crewRace = crewRace
        self.crewArea = crewArea
        self.expanded = expanded
    }
    
}
