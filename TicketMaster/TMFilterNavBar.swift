//
//  TMFilterNavBar.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/23/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TMFilterNavBar: UIButton{
    
    var containerView = UIView()
    var dateFilterLabel = UILabel()
    var locationFilterLabel = UILabel()
    var separatorLabel = UILabel()

    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup Container View
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        //Setup Date Filter Label
        dateFilterLabel.textColor = .lightGray
        dateFilterLabel.font = UIFont.systemFont(ofSize: 14)
        dateFilterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(dateFilterLabel)
        
        //Setup Location Filter Label 
        locationFilterLabel.textColor = .lightGray
        locationFilterLabel.font = UIFont.systemFont(ofSize: 14)
        locationFilterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(locationFilterLabel)
        
        //Setup Separator Label
        separatorLabel.text = " · "
        separatorLabel.textColor = .lightGray
        separatorLabel.font = UIFont.boldSystemFont(ofSize: 16)
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(separatorLabel)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let spacerView = UIView()
        spacerView.isUserInteractionEnabled = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        
        let viewDict = ["containerView": containerView, "dateFilterLabel": dateFilterLabel, "separatorLabel": separatorLabel ,"locationFilterLabel": locationFilterLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dateFilterLabel]-3-[separatorLabel]-3-[locationFilterLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: dateFilterLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: separatorLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: locationFilterLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
    }
    
    func configure(dates: String, location: String){
        dateFilterLabel.text = dates
        locationFilterLabel.text = location
    }
}
