//
//  SearchRecentCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage

protocol SearchRecentCellDelegate {
    func relayDidPressFavorite(sender: UIButton)
}

class SearchRecentCell: UICollectionViewCell{
    
    var searchRecentCellDelegate: SearchRecentCellDelegate!
    var imageView = UIImageView()
    var favoriteButton = TMFavoriteButton()
    var containerView = UIView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup ImageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = TMColor.faintGray
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        //Setup ContainerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        //Setup Title Label
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(titleLabel)
        
        //Setup SubTitle Label
        subTitleLabel.textColor = .lightGray
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(subTitleLabel)
        
        //Setup Favorite Button
        favoriteButton.clipsToBounds = true
        favoriteButton.strokeColor = .white
        favoriteButton.tintColor = UIColor(white: 0.1, alpha: 0.5)
        favoriteButton.addTarget(self, action: #selector(self.favoriteButtonPressed), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.addSubview(favoriteButton)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["imageView": imageView, "favoriteButton": favoriteButton, "containerView": containerView, "titleLabel": titleLabel, "subTitleLabel": subTitleLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[favoriteButton(22.5)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subTitleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]-[containerView(>=50)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]-2-[subTitleLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[favoriteButton(22.5)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(event: Event?){
        //Set ImageView Image
        if (event?.image != nil){
            imageView.sd_setShowActivityIndicatorView(true)
            imageView.sd_setIndicatorStyle(.gray)
            imageView.sd_setImage(with: URL(string: (event?.image!)!), placeholderImage: nil)
            imageView.contentMode = .scaleAspectFill
        }
        else{
            imageView.image = UIImage(named: "ticketMasterLogo")
            imageView.contentMode = .scaleAspectFit
        }
        titleLabel.text = event?.name
        subTitleLabel.text = event?.venue
    }
    
    //Button Delegate
    func favoriteButtonPressed(sender: UIButton){
        searchRecentCellDelegate.relayDidPressFavorite(sender: sender)
    }
}
