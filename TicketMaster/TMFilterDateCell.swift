//
//  TMFilterDateCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol FilterDateCellDelegate {
    func didPressSetDate()
}

class TMFilterDateCell: UITableViewCell{
    
    var filterDateCellDelegate: FilterDateCellDelegate!
    var sectionLabel = UILabel()
    var containerView = UIView()
    var anyDateButton = UIButton()
    var nextWeekendButton = UIButton()
    var setDateButton = UIButton()
    
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
        
        //Setup SectionLabel Label
        sectionLabel.text = "dates".localized()
        sectionLabel.textColor = .darkGray
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sectionLabel)
        
        //Setup ContainerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        //Setup Any Date Button
        anyDateButton.setTitle("anyDate".localized(), for: .normal)
        anyDateButton.setTitleColor(.darkGray, for: .normal)
        anyDateButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        anyDateButton.layer.borderColor = TMColor.faintGray.cgColor
        anyDateButton.layer.borderWidth = 1
        anyDateButton.layer.cornerRadius = 5
        anyDateButton.clipsToBounds = true
        anyDateButton.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(anyDateButton)
        
        //Setup Any Date Button
        nextWeekendButton.setTitle("nextWeekend".localized(), for: .normal)
        nextWeekendButton.setTitleColor(.darkGray, for: .normal)
        nextWeekendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        nextWeekendButton.layer.borderColor = TMColor.faintGray.cgColor
        nextWeekendButton.layer.borderWidth = 1
        nextWeekendButton.layer.cornerRadius = 5
        nextWeekendButton.clipsToBounds = true
        nextWeekendButton.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(nextWeekendButton)
        
        //Setup Any Date Button
        setDateButton.setTitle("setDates".localized(), for: .normal)
        setDateButton.setTitleColor(.darkGray, for: .normal)
        setDateButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setDateButton.layer.borderColor = TMColor.faintGray.cgColor
        setDateButton.layer.borderWidth = 2
        setDateButton.layer.cornerRadius = 5
        setDateButton.clipsToBounds = true
        setDateButton.addTarget(self, action: #selector(setDateButtonPressed), for: .touchUpInside)
        setDateButton.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(setDateButton)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["sectionLabel": sectionLabel, "containerView": containerView, "anyDateButton": anyDateButton, "nextWeekendButton": nextWeekendButton, "setDateButton": setDateButton] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[sectionLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[containerView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[anyDateButton(==nextWeekendButton)]-16-[nextWeekendButton(==anyDateButton)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[setDateButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[sectionLabel(24)]-[containerView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[anyDateButton(35)]-[setDateButton(40)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints([NSLayoutConstraint.init(item: nextWeekendButton, attribute: .centerY, relatedBy: .equal, toItem: anyDateButton, attribute: .centerY, multiplier: 1, constant: 0)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: nextWeekendButton, attribute: .height, relatedBy: .equal, toItem: anyDateButton, attribute: .height, multiplier: 1, constant: 0)])
    }
    
    //Button Delegate
    func setDateButtonPressed(){
        filterDateCellDelegate.didPressSetDate()
    }
}
