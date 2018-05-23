//
//  TMFilterSwitchToolbarItem.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TMFilterSwitchToolbarItem: UIView{
    
    var switchButton = UISwitch()
    var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        //Setup Switch Button
        switchButton.tintColor = TMColor.faintGray
        switchButton.onTintColor = TMColor.primary
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(switchButton)
        
        //Setup TextLabel
        textLabel.textColor = .darkGray
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textLabel)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["switchButton": switchButton, "textLabel": textLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: switchButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.addConstraints([NSLayoutConstraint.init(item: switchButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: textLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[switchButton(25)]-2-[textLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}
