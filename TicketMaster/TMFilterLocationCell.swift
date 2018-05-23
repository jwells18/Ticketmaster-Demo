//
//  TMFilterLocationCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TMFilterLocationCell: UITableViewCell{
    
    var sectionLabel = UILabel()
    private var containerView = UIView()
    var locationButton = UIButton()
    var locationLabel = UILabel()
    var locationAccessoryView = UIImageView()
    
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
        sectionLabel.text = "location".localized()
        sectionLabel.textColor = .darkGray
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sectionLabel)
        
        //Setup ContainerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        //Setup Location ImageView
        locationButton.setImage(UIImage(named: "marker"), for: .normal)
        locationButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        locationButton.clipsToBounds = true
        locationButton.backgroundColor = TMColor.faintGray
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(locationButton)
        
        //Setup Location Label
        locationLabel.textColor = .darkGray
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(locationLabel)
        
        //Setup Location Accessory ImageView
        locationAccessoryView.image = UIImage(named: "forward")
        locationAccessoryView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(locationAccessoryView)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["sectionLabel": sectionLabel, "containerView": containerView, "locationButton": locationButton, "locationLabel": locationLabel, "locationAccessoryView": locationAccessoryView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[sectionLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[containerView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[locationButton(40)]-16-[locationLabel]-[locationAccessoryView(25)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[sectionLabel(24)]-[containerView(>=40)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints([NSLayoutConstraint.init(item: locationButton, attribute: .centerY, relatedBy: .equal, toItem: self.containerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: locationButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: locationLabel, attribute: .centerY, relatedBy: .equal, toItem: locationButton, attribute: .centerY, multiplier: 1, constant: 0)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: locationLabel, attribute: .height, relatedBy: .equal, toItem: locationButton, attribute: .height, multiplier: 1, constant: 0)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: locationAccessoryView, attribute: .centerY, relatedBy: .equal, toItem: locationButton, attribute: .centerY, multiplier: 1, constant: 0)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: locationAccessoryView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
    }
    
    func configure(location: String){
        locationLabel.text = sampleCurrentCity
    }
    
    override func layoutSubviews() {
        locationButton.layer.cornerRadius = locationButton.frame.width/2
    }
}
