//
//  searchFeatureEventCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage

protocol SearchFeatureEventCellDelegate {
    func relayDidPressFavorite(sender: UIButton)
}

class searchFeatureEventCell: UICollectionViewCell{
    
    var searchFeatureEventCellDelegate: SearchFeatureEventCellDelegate!
    var imageView = UIImageView()
    private var gradientView = UIView()
    private var gradient = CAGradientLayer()
    var favoriteButton = TMFavoriteButton()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup ImageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = TMColor.faintGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        //Setup Gradient View
        gradientView.frame = CGRect(x: 10, y: 10, width: frame.width-20, height: frame.height-20)
        gradientView.clipsToBounds = true
        gradientView.layer.cornerRadius = 5
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(gradientView)
        
        //Add Gradient to CollectionView
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor(white: 0.2, alpha: 0.8).cgColor]
        gradientView.layer.insertSublayer(gradient, at: 0)
        
        //Setup Favorite Button
        favoriteButton.clipsToBounds = true
        favoriteButton.strokeColor = .white
        favoriteButton.tintColor = UIColor(white: 0.1, alpha: 0.5)
        favoriteButton.addTarget(self, action: #selector(self.favoriteButtonPressed), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.gradientView.addSubview(favoriteButton)
        
        //Setup Title Label
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.gradientView.addSubview(titleLabel)
        
        //Setup SubTitle Label
        subTitleLabel.textColor = .white
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.gradientView.addSubview(subTitleLabel)

        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["imageView": imageView, "gradientView": gradientView, "favoriteButton": favoriteButton, "titleLabel": titleLabel, "subTitleLabel": subTitleLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[imageView]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[gradientView]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.gradientView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[favoriteButton(25)]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.gradientView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.gradientView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[subTitleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[imageView]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[gradientView]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.gradientView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[favoriteButton(25)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.gradientView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleLabel]-1-[subTitleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = gradientView.bounds
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
        self.searchFeatureEventCellDelegate.relayDidPressFavorite(sender: sender)
    }
}
