//
//  TMFilterDoneCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/8/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol FilterDoneCellDelegate {
    func didPressDoneButton()
}

class TMFilterDoneCell: UITableViewCell{
    
    var filterDoneCellDelegate: FilterDoneCellDelegate!
    var doneButton = UIButton()
    
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
        
        //Setup Location Button
        doneButton.setTitle("done".localized(), for: .normal)
        doneButton.layer.cornerRadius = 5
        doneButton.clipsToBounds = true
        doneButton.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
        doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        doneButton.backgroundColor = TMColor.primary
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(doneButton)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["doneButton": doneButton] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[doneButton]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[doneButton(40)]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func doneButtonPressed(){
        filterDoneCellDelegate.didPressDoneButton()
    }
}

