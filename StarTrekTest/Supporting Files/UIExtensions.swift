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

extension Array {
    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }
    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        let count = self.count
        indices.lazy.dropLast().forEach {
            swapAt($0, Int(arc4random_uniform(UInt32(count - $0))) + $0)
        }
        return self
    }
    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}

