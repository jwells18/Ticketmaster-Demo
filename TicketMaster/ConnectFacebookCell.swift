//
//  ConnectFacebookCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol ConnectFacebookCellDelegate {
    func didPressConnectFacebook(sender: UIButton)
}

class ConnectFacebookCell: UICollectionViewCell{
    
    var connectFacebookCellDelegate: ConnectFacebookCellDelegate!
    var imageView = UIImageView()
    var mainLabel = UILabel()
    var facebookButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        //Setup ImageView
        imageView.image = UIImage(named: "concertStock1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        //Setup Main Label
        mainLabel.text = "connectFacebookLabel".localized()
        mainLabel.textColor = .white
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 0
        mainLabel.font = UIFont.boldSystemFont(ofSize: 26)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainLabel)
        
        //Setup Facebook Button
        facebookButton.setTitle("connectFacebook".localized(), for: .normal)
        facebookButton.backgroundColor = TMColor.facebookBlue
        facebookButton.clipsToBounds = true
        facebookButton.layer.cornerRadius = 5
        facebookButton.addTarget(self, action: #selector(self.facebookButtonPressed), for: .touchUpInside)
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(facebookButton)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["imageView": imageView, "mainLabel": mainLabel, "facebookButton": facebookButton] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[facebookButton]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[mainLabel]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[mainLabel]-20-[facebookButton(50)]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //Button Delegates
    func facebookButtonPressed(sender: UIButton){
        connectFacebookCellDelegate.didPressConnectFacebook(sender: sender)
    }
}
