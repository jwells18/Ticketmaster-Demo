//
//  FavoriteMusicSourceCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit


class FavoriteMusicSourceCell: UICollectionViewCell{
    
    var sourceImage = UIImageView()
    var sourceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup Apple Music Button
        sourceImage.layer.borderWidth = 1
        sourceImage.layer.borderColor = TMColor.faintGray.cgColor
        sourceImage.clipsToBounds = true
        sourceImage.layer.cornerRadius = 5
        sourceImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sourceImage)
        
        //Setup Apple Music Label
        sourceLabel.text = "source".localized()
        sourceLabel.textColor = .darkGray
        sourceLabel.textAlignment = .center
        sourceLabel.numberOfLines = 0
        sourceLabel.font = UIFont.systemFont(ofSize: 12)
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sourceLabel)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["sourceImage": sourceImage, "sourceLabel": sourceLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[sourceLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: sourceImage, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: sourceImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[sourceImage(50)]-2-[sourceLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, image: UIImage){
        sourceImage.image = image
        sourceLabel.text = title
    }
    
    //Button Delegate
    func favoriteButtonPressed(sender: UIButton){
        
    }
}

