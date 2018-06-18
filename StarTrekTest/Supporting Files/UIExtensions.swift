//
//  UIExtensions.swift
//  StarTrekTest
//
//  Created by Nacho González Miró on 17/6/18.
//  Copyright © 2018 Nacho González Miró. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    
    func setTitle(title:String, subtitle:String) {
        
        let customTitle = UILabel()
        customTitle.text = title
        customTitle.font = UIFont.boldSystemFont(ofSize: 17)
        customTitle.textColor = .white
        customTitle.textAlignment = .center
        customTitle.sizeToFit()
        
        let customDescription = UILabel()
        customDescription.text = subtitle
        customDescription.font = UIFont.systemFont(ofSize: 12)
        customDescription.textAlignment = .center
        customDescription.textColor = .white
        customDescription.sizeToFit()
         
        let stackView = UIStackView(arrangedSubviews: [customTitle, customDescription])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        
        let width = max(customTitle.frame.size.width, customDescription.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        customTitle.sizeToFit()
        customDescription.sizeToFit()
        
        self.titleView = stackView
    }
}

extension MutableCollection {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: numericCast(arc4random_uniform(numericCast(diff))))
            swapAt(i, j)
        }
    }
}


extension UIViewController {
    func displayAlertMessage(userTitle: String, userMessage: String) {
        
        let myAlert = UIAlertController(title: userTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            return
        }
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
    }
}
