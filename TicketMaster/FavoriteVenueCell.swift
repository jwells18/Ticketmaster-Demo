//
//  FavoriteVenueCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol FavoriteVenueCellDelegate{
    func relayDidPressFavoriteVenueCell(sender: UIButton)
}

class FavoriteVenueCell: UITableViewCell{
    
    var favoriteVenueCellDelegate: FavoriteVenueCellDelegate!
    private var mapImageView = UIImageView()
    private var mainLabel = UILabel()
    private var mainSubLabel = UILabel()
    private var favoriteButton = UIButton()
    
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
        
        //Setup Main Image
        self.setupMapImageView()
        
        //Setup Main Label
        mainLabel.textColor = .darkGray
        mainLabel.font = UIFont.boldSystemFont(ofSize: 16)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainLabel)
        
        //Setup Main SubLabel
        mainSubLabel.textColor = .lightGray
        mainSubLabel.font = UIFont.systemFont(ofSize: 16)
        mainSubLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainSubLabel)
        
        //Setup Favorite Button
        favoriteButton.setImage(UIImage(named: "favoritesFilled"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(favoriteButton)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMapImageView(){
        //Setup MapView
        mapImageView.layer.cornerRadius = 10
        mapImageView.clipsToBounds = true
        mapImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mapImageView)
    }
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        
        let viewDict = ["mapImageView": mapImageView, "mainLabel": mainLabel, "mainSubLabel": mainSubLabel, "favoriteButton": favoriteButton, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mapImageView(65)]-[mainLabel]-[favoriteButton(25)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item:mainSubLabel, attribute: .width, relatedBy: .equal, toItem: mainLabel, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:mainSubLabel, attribute: .leading, relatedBy: .equal, toItem: mainLabel, attribute: .leading, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:spacerViewTop, attribute: .width, relatedBy: .equal, toItem: mainLabel, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:spacerViewBottom, attribute: .width, relatedBy: .equal, toItem: mainLabel, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: mapImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:mapImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 65)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(>=20)][mainLabel(20)][mainSubLabel(20)][spacerViewBottom(>=20)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: favoriteButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:favoriteButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.addConstraints([NSLayoutConstraint.init(item:spacerViewTop, attribute: .height, relatedBy: .equal, toItem: spacerViewBottom, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:spacerViewBottom, attribute: .height, relatedBy: .equal, toItem: spacerViewTop, attribute: .height, multiplier: 1, constant: 0)])
    }
    
    func configure(venue: DBVenue?){
        //NOTE: Data is filled in manually for demo purposes
        mainLabel.text = "Rose Bowl"
        mainSubLabel.text = "24 Events"
        
        let mapFrame = CGRect(x: 0, y: 0, width: 65, height: 65)
        let mapManager = MapManager()
        mapManager.createMapImageforLocation(location: sampleCurrentLocation, frame: mapFrame, completionHandler: { (image) in
            self.mapImageView.image = image
        })
    }
    
    //Button Delegate
    func favoriteButtonPressed(sender: UIButton){
        favoriteVenueCellDelegate.relayDidPressFavoriteVenueCell(sender: sender)
    }
}
