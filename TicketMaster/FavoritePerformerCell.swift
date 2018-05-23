//
//  FavoritePerformerCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol FavoritePerformerCellDelegate{
    func relayDidPressFavoritePerformerCell(sender: UIButton)
}

class FavoritePerformerCell: UITableViewCell{
    
    var favoritePerformerCellDelegate: FavoritePerformerCellDelegate!
    private var mainImageView = UIImageView()
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
        mainImageView.clipsToBounds = true
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainImageView)
        
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
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        
        let viewDict = ["mainImageView": mainImageView, "mainLabel": mainLabel, "mainSubLabel": mainSubLabel, "favoriteButton": favoriteButton, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mainImageView(50)]-[mainLabel]-[favoriteButton(25)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item:mainSubLabel, attribute: .width, relatedBy: .equal, toItem: mainLabel, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:mainSubLabel, attribute: .leading, relatedBy: .equal, toItem: mainLabel, attribute: .leading, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:spacerViewTop, attribute: .width, relatedBy: .equal, toItem: mainLabel, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:spacerViewBottom, attribute: .width, relatedBy: .equal, toItem: mainLabel, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:mainImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(>=14)][mainLabel(20)][mainSubLabel(20)][spacerViewBottom(>=14)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: favoriteButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:favoriteButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.addConstraints([NSLayoutConstraint.init(item:spacerViewTop, attribute: .height, relatedBy: .equal, toItem: spacerViewBottom, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item:spacerViewBottom, attribute: .height, relatedBy: .equal, toItem: spacerViewTop, attribute: .height, multiplier: 1, constant: 0)])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
        mainImageView.layer.cornerRadius = mainImageView.frame.width/2
    }
    
    func configure(performer: DBPerformer?){
        //NOTE: Data is filled in manually for demo purposes
        mainImageView.image = UIImage(named: "taylorSwift")
        mainSubLabel.text = "55 Events"
        mainLabel.text = "Taylor Swift"
    }
    
    //Button Delegate
    func favoriteButtonPressed(sender: UIButton){
        favoritePerformerCellDelegate.relayDidPressFavoritePerformerCell(sender: sender)
    }
}
