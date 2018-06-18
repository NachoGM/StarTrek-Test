//
//  ViewController.swift
//  StarTrekTest
//
//  Created by Nacho González Miró on 17/6/18.
//  Copyright © 2018 Nacho González Miró. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, ExpandableHeaderViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Declare Variables
    let tripulationNumber = Int(arc4random_uniform(430))
    var sections = [Section]()
    var racesObject = RacesObject()
    var races = Races()
    var area = Area()
    
    // MARK: - Declare ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationText()
        registerXibCell()
        configTripulation(numberOfTripulants: tripulationNumber)
    }
    
    func initNavigationText() {
        navigationItem.setTitle(title: "Wellcome to StarTrek Spacecraft", subtitle: "Today we have \(tripulationNumber) tripulants, each area has \(tripulationNumber / 3) tripulants")
    }
    
    func registerXibCell() {
        self.tableView.register(UINib(nibName: "TripulationCell", bundle: nil), forCellReuseIdentifier: "tripulationCell")
    }

    func configTripulation(numberOfTripulants: Int) {
        let div = abs(numberOfTripulants / 3)
        handleSpaceTrip(div: div, numberOfTripulants: numberOfTripulants)
        configureSections()
    }
    
    func handleSpaceTrip(div: Int, numberOfTripulants: Int) {
        let dictOfRaces = [races.human, races.betazoid, races.vulcan]
        let shuffledArray: [String] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: dictOfRaces) as! [String]
        let humanTripulation = Humans(crewID: "Command", crewRace: shuffledArray[0], crewArea: area.command)
        let betazoidTripulation = Betazoid(crewID: "Engineering", crewRace: shuffledArray[1], crewArea: area.engineering)
        let vulcanTripulation = Vulcan(crewID: "Science", crewRace: shuffledArray[2], crewArea: area.science)
        
        for _ in 0...div {
            racesObject.humans.append(humanTripulation)
            racesObject.betazoid.append(betazoidTripulation)
            racesObject.vulcan.append(vulcanTripulation)
        }
    }
    
    func configureSections() {
        let sections = [Section(crewID: "Command", crewArea: area.command, expanded: false),
                        Section(crewID: "Enyineering", crewArea: area.engineering, expanded: false),
                        Section(crewID: "Science", crewArea: area.science, expanded: false) ]
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

// MARK: - Display TableView DataSource & Delegate Extensions
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripulationNumber / 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripulationCell") as! TripulationCell
        let crewID = sections[indexPath.section].crewID
        let human = racesObject.humans[indexPath.section]
        let vulcan = racesObject.vulcan[indexPath.section]
        let betazoide = racesObject.betazoid[indexPath.section]
        
        switch indexPath.section {
        case 0:
            return configCell(tableView: tableView, crewID: crewID, idCharacter: human.crewRace.first!.description.uppercased(), crewRace: human.crewRace, multiplier: checkInCommand(crewRace: human.crewRace), area: human.crewArea)
        case 1:
            return configCell(tableView: tableView, crewID: crewID, idCharacter: betazoide.crewRace.first!.description.uppercased(), crewRace: betazoide.crewRace, multiplier: checkInEnyineering(crewRace: betazoide.crewRace), area: betazoide.crewArea)
        case 2:
            return configCell(tableView: tableView, crewID: crewID, idCharacter: vulcan.crewRace.first!.description.uppercased(), crewRace: vulcan.crewRace, multiplier: checkInScience(crewRace: vulcan.crewRace), area: vulcan.crewArea)
        default:
            print(" Error in cellForRoww ")
        }
        
        return cell
    }
    
    // MARK: Handle Multiplicators for Cells
    func checkInCommand(crewRace:String) -> String {
        var multiplier = String()
        if crewRace == races.human {
            multiplier = "x3"
        } else if crewRace == races.betazoid {
            multiplier = "x2"
        } else if crewRace == races.vulcan {
            multiplier = "x1"
        }
        return multiplier
    }
     
    func checkInEnyineering(crewRace:String) -> String {
        var multiplier = String()
        if crewRace == races.human {
            multiplier = "x1"
        } else if crewRace == races.betazoid {
            multiplier = "x3"
        } else if crewRace == races.vulcan {
            multiplier = "x2"
        }
        return multiplier
    }
    
    func checkInScience(crewRace:String) -> String {
        var multiplier = String()
        if crewRace == races.human {
            multiplier = "x1"
        } else if crewRace == races.betazoid {
            multiplier = "x2"
        } else if crewRace == races.vulcan {
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
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.textLabel?.numberOfLines = 0
        header.customInit(title: sections[section].crewID, section: section, delegate: self)
        header.layer.backgroundColor = UIColor.purple.cgColor
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        displayAlertMessage(userTitle: "Atención", userMessage: "Para habilitar esta funcionalidad, contacte con el desarrollador")
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

