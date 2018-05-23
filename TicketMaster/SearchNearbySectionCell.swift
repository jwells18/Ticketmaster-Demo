//
//  SearchNearbySectionCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import MapKit

class SearchNearbySectionCell: UITableViewCell{
    
    var sectionLabel = UILabel()
    var mapImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        //Setup Section Label
        self.setupSectionLabel()
        
        //Setup Map ImageView
        self.setupMapImageView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupSectionLabel(){
        sectionLabel.textColor = .darkGray
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        sectionLabel.numberOfLines = 1
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sectionLabel)
    }
    
    func setupMapImageView(){
        //Setup Map ImageView
        mapImageView.layer.cornerRadius = 10
        mapImageView.clipsToBounds = true
        mapImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mapImageView)
    }
    
    func setupConstraints(){
        let viewDict = ["sectionLabel": sectionLabel, "mapImageView": mapImageView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[sectionLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: mapImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.8, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: mapImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[sectionLabel(40)]-16-[mapImageView]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(section: String){
        self.sectionLabel.text = section.localized()
        var mapFrame = CGRect()
        if(mapImageView.frame == .zero){
            mapFrame = CGRect(x: 0, y: 0, width: w-16, height: ((w-8-40-32)*0.6))
        }
        else{
            mapFrame = mapImageView.frame
        }
        
        let mapManager = MapManager()
        mapManager.createMapImageforLocation(location: sampleCurrentLocation, frame: mapFrame, completionHandler: { (image) in
            self.mapImageView.image = image
        })
    }
}
