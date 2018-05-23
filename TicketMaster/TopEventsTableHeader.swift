//
//  TopEventsTableHeader.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TopEventsTableHeader: UIView{
    
    var titleLabel =  UILabel()
    private var separatorLine = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        //Setup Title Label
        titleLabel.text = "topEvents".localized().uppercased()
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        //Setup Separator Line
        separatorLine.backgroundColor = TMColor.faintGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separatorLine)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["titleLabel": titleLabel, "separatorLine": separatorLine]
        //Set Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorLine]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Set Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel][separatorLine(1)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}
