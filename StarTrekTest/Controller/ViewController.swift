//
//  ViewController.swift
//  StarTrekTest
//
//  Created by Nacho González Miró on 17/6/18.
//  Copyright © 2018 Nacho González Miró. All rights reserved.
//

import UIKit


class GlobalVariables {
    var humanTripulation = [AnyObject]()
    var betazoidTripulation = [AnyObject]()
    var vulcanTripulation = [AnyObject]()
    let tripulationNumber = Int(arc4random_uniform(430))
}

class ViewController: UIViewController, ExpandableHeaderViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Declare Variables 
    var humans = [Humans]()
    var betazoid = [Betazoid]()
    var vulcan = [Vulcan]()
    var sections = [Section]()
    var globalVariables = GlobalVariables()

    // MARK: - Declare ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        registerXibCell()
        configTripulation(numberOfTripulants: globalVariables.tripulationNumber)
    }
    
    func registerXibCell() {
        self.tableView.register(UINib(nibName: "TripulationCell", bundle: nil), forCellReuseIdentifier: "tripulationCell")
    }

    func configTripulation(numberOfTripulants: Int) {
        
        // Config NavigationBar
        navigationItem.setTitle(title: "Wellcome to StarTrek Spacecraft", subtitle: "Today we have \(abs(numberOfTripulants)) tripulants, each area has \(abs(numberOfTripulants / 3)) tripulants")

        // Color Areas
        let science = UIColor.blue
        let engineering = UIColor.red
        let command = UIColor.yellow
        
        // Divide in abs
        let div = abs(numberOfTripulants / 3)

        // Create dicts
        let humanTrip : [String: Any] = ["crewID": "Command", "crewRace": "Humans", "crewArea": command]
        let betazoidTrip : [String: Any] = ["crewID": "Engineering", "crewRace": "Betazoid", "crewArea": engineering]
        let vulcanTrip : [String: Any] = ["crewID": "Science", "crewRace": "Vulcan", "crewArea": science]

        // Add dict into arrays
        for _ in 0...div {
            globalVariables.humanTripulation.append(humanTrip as AnyObject)
            globalVariables.betazoidTripulation.append(betazoidTrip as AnyObject)
            globalVariables.vulcanTripulation.append(vulcanTrip as AnyObject)
        }
        
        // Configure Header Sections
        let sections = [Section(crewID: "Command", crewRace: globalVariables.humanTripulation, crewArea: command, expanded: false),
                        Section(crewID: "Enyineering", crewRace: globalVariables.betazoidTripulation, crewArea: engineering, expanded: false),
                        Section(crewID: "Science", crewRace: globalVariables.vulcanTripulation, crewArea: science, expanded: false) ]
        self.sections = sections

    }
    
    // MARK: - Handle Delegate for Expandable Header View
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        tableView.beginUpdates()
        for i in 0..<sections[section].crewID.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].crewID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var race = ["Human","Betazoid","Vulcan"]
        race.shuffle()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripulationCell") as! TripulationCell
        
        let crewID = sections[indexPath.section].crewID
        let crewRace :String = race.first!
        let idCharacter = crewRace.first!.description.uppercased()
        let multiplier = setMultiplier(indexPath: indexPath, crewRace: crewRace)

        switch indexPath.section {
        case 0:
            return configCell(tableView: tableView, crewID: crewID, idCharacter: idCharacter, crewRace: crewRace, multiplier: multiplier, area: .yellow)
        case 1:
            return configCell(tableView: tableView, crewID: crewID, idCharacter: idCharacter, crewRace: crewRace, multiplier: multiplier, area: .red)
        case 2:
            return configCell(tableView: tableView, crewID: crewID, idCharacter: idCharacter, crewRace: crewRace, multiplier: multiplier, area: .blue)
        default:
            print("Error")
        }
        
        return cell
    }
    
    // MARK: Handle Multiplier depending the Section and race
    func setMultiplier(indexPath: IndexPath, crewRace: String) -> String {
        
        var multiplier = String()
        
        if sections[indexPath.section].crewID == "Command" {
            multiplier = checkInCommand(crewRace: crewRace)
            
        } else if sections[indexPath.section].crewID == "Enyineering" {
            multiplier = checkInEnyineering(crewRace: crewRace)
            
        } else if sections[indexPath.section].crewID == "Science" {
            multiplier = checkInScience(crewRace: crewRace)
            
        } else {
            print(" ERROR ")
        }
        return multiplier
    }
    
    enum Race: String {
        case Human = "Human"
        case Betazoid = "Betazoid"
        case Vulcan = "Vulcan"
    }
    
    func checkInCommand(crewRace:String) -> String {
        
        var multiplier = String()

        if crewRace == Race.Human.rawValue {
            multiplier = "x3"
        } else if crewRace == Race.Betazoid.rawValue {
            multiplier = "x2"
        } else if crewRace == Race.Vulcan.rawValue {
            multiplier = "x1"
        }
        return multiplier
    }
    
    func checkInEnyineering(crewRace:String) -> String {
        var multiplier = String()

        if crewRace == Race.Human.rawValue {
            multiplier = "x1"
        } else if crewRace == Race.Betazoid.rawValue {
            multiplier = "x3"
        } else if crewRace == Race.Vulcan.rawValue {
            multiplier = "x2"
        }
        return multiplier
    }
    
    func checkInScience(crewRace:String) -> String {
        var multiplier = String()

        if crewRace == Race.Human.rawValue {
            multiplier = "x1"
        } else if crewRace == Race.Betazoid.rawValue {
            multiplier = "x2"
        } else if crewRace == Race.Vulcan.rawValue {
            multiplier = "x3"
        }
        return multiplier
    }
    
    // MARK: Configure cell in TableView
    func configCell(tableView: UITableView, crewID: String, idCharacter: String, crewRace: String, multiplier: String, area: UIColor) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripulationCell") as! TripulationCell
        cell.areaColorView.backgroundColor = area
        cell.areaColorView.layer.cornerRadius = 10
        cell.crewIdLabel.text = crewID
        cell.crewRaceLabel.text = crewRace
        cell.raceMultiplierLabel.text = multiplier
        cell.crewIdCharacterLabel.text = idCharacter
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.textLabel?.numberOfLines = 0
        header.customInit(title: sections[section].crewID, number: sections[section].crewRace.count, section: section, delegate: self)
        header.layer.backgroundColor = UIColor.purple.cgColor
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2.0
    }

}

