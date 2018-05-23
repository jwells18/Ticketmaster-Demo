//
//  TMSearchBar.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TMSearchBar: UISearchBar{
    
    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    var preferredBackgroundColor: UIColor!
    
    override func draw(_ rect: CGRect) {
        // Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubviews() {
            let searchField: UITextField = (subviews[0] ).subviews[index] as! UITextField
            searchField.frame = CGRect(x: 5.0, y: 5.0, width: frame.size.width - 10.0, height: frame.size.height - 10.0)
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            searchField.backgroundColor = preferredBackgroundColor
        }
        
        super.draw(rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Setup SearchBar
        self.frame = frame
        self.searchBarStyle = .minimal
        self.isTranslucent = false
        self.tintColor = TMColor.primary
        self.barTintColor = TMColor.faintGray
        self.backgroundColor = .white
        
        //Set Default Values
        preferredFont = .boldSystemFont(ofSize: searchBarFontSize)
        preferredTextColor = .darkGray
        preferredBackgroundColor = TMColor.faintGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Find Index of SearchBar in Subviews
    func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = subviews[0]
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UITextField.self){
                index = i
                break
            }
        }
        
        return index
    }
}
