//
//  TMTicketCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TMTicketCell: UITableViewCell{
    
    var sectionLabel = UILabel()
    var descriptionLabel = UILabel()
    var priceLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.selectionStyle = .none
        
        //Setup Section Label
        sectionLabel.textColor = .darkGray
        sectionLabel.font = UIFont.systemFont(ofSize: 14)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sectionLabel)
        
        //Setup Descripticon Label
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 10)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionLabel)
        
        //Setup Price Label
        priceLabel.textColor = TMColor.primary
        priceLabel.textAlignment = .right
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceLabel)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        //Add SpacerViews
        let spacerViewTop = UIView()
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        
        let viewDict = ["sectionLabel": sectionLabel, "descriptionLabel": descriptionLabel, "priceLabel": priceLabel, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[sectionLabel]-[priceLabel(<=150)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: sectionLabel, attribute: .leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: descriptionLabel, attribute: .width, relatedBy: .equal, toItem: sectionLabel, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewTop, attribute: .leading, relatedBy: .equal, toItem: sectionLabel, attribute: .leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewTop, attribute: .width, relatedBy: .equal, toItem: sectionLabel, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewBottom, attribute: .leading, relatedBy: .equal, toItem: sectionLabel, attribute: .leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewBottom, attribute: .width, relatedBy: .equal, toItem: sectionLabel, attribute: .width, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(>=16)][sectionLabel(>=18)]-6-[descriptionLabel(>=14)][spacerViewBottom(>=16)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: priceLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: priceLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewTop, attribute: .height, relatedBy: .equal, toItem: spacerViewBottom, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewBottom, attribute: .height, relatedBy: .equal, toItem: spacerViewTop, attribute: .height, multiplier: 1, constant: 0))
    }
    
    func configure(ticket: Ticket){
        sectionLabel.text = ticket.section
        descriptionLabel.text = "Standard Price Ticket"
        priceLabel.text = "$79.50 ea"
    }
}
