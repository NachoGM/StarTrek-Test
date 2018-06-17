//
//  ExpandableHeaderView.swift
//  StarTrekTest
//
//  Created by Nacho González Miró on 17/6/18.
//  Copyright © 2018 Nacho González Miró. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header:ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {

    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(title: String, number: Int, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.detailTextLabel?.text = String(number)
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textLabel?.textColor = .white
        self.textLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        self.detailTextLabel?.textColor = UIColor.darkGray
    }

}
