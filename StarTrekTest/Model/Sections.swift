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
    var crewArea: UIColor!
    var expanded: Bool!
    
    init(crewID: String, crewArea: UIColor, expanded: Bool) {
        self.crewID = crewID
        self.crewArea = crewArea
        self.expanded = expanded
    }
    
}
