//
//  TMFilterDefaultToolbarItem.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TMFilterDefaultToolbarItem: UIView{
    
    var button = UIButton()
    var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        //Setup Button
        button.setTitleColor(TMColor.primary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = TMColor.primary
        button.layer.borderColor = TMColor.primary.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 30/2
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        
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
        let viewDict = ["button": button, "textLabel": textLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)])
        self.addConstraints([NSLayoutConstraint.init(item: button, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: textLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[button(30)]-2-[textLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}
