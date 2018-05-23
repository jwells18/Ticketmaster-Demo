//
//  EventCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage

protocol EventImageCellDelegate {
    func didPressFavorite(sender: UIButton)
}

class EventImageCell: UICollectionViewCell{
    
    var eventImageCellDelegate: EventImageCellDelegate!
    var imageView = UIImageView()
    var containerView = UIView()
    var ticketPriceButton = UIButton()
    var weekDayLabel = UILabel()
    var dateLabel = UILabel()
    var favoriteButton = UIButton()
    var separatorLine = UIView()
    var titleLabel = UILabel()
    var locationLabel = UILabel()
    var ticketsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        //Setup ImageView
        imageView.clipsToBounds = true
        imageView.backgroundColor = TMColor.faintGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        //Setup Ticket Pricing Label
        ticketPriceButton.setTitleColor(.white, for: .normal)
        ticketPriceButton.titleLabel?.textAlignment = .center
        ticketPriceButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        ticketPriceButton.backgroundColor = TMColor.primary
        ticketPriceButton.clipsToBounds = true
        ticketPriceButton.layer.cornerRadius = 5
        ticketPriceButton.translatesAutoresizingMaskIntoConstraints = false
        ticketPriceButton.isUserInteractionEnabled = false
        ticketPriceButton.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
        self.imageView.addSubview(ticketPriceButton)
        
        //Setup ContainerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        //Setup WeekDay Label
        weekDayLabel.textColor = .darkGray
        weekDayLabel.textAlignment = .center
        weekDayLabel.font = UIFont.boldSystemFont(ofSize: 20)
        weekDayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(weekDayLabel)
        
        //Setup Date Label
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(dateLabel)
        
        //Setup Favorite Button
        favoriteButton.setImage(UIImage(named: "favorites"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(favoriteButton)
        
        //SeparatorLine
        separatorLine.backgroundColor = TMColor.faintGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(separatorLine)
        
        //Title Label
        titleLabel.textColor = .darkGray
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(titleLabel)
        
        //Location Label
        locationLabel.textColor = .darkGray
        locationLabel.font = UIFont.systemFont(ofSize: 12)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(locationLabel)
        
        //Location Label
        ticketsLabel.textColor = .darkGray
        ticketsLabel.font = UIFont.systemFont(ofSize: 12)
        ticketsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(ticketsLabel)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        //Add SpacerViews
        let spacerView1 = UIView()
        spacerView1.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(spacerView1)
        let spacerView2 = UIView()
        spacerView2.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(spacerView2)
        
        let viewDict = ["imageView": imageView, "ticketPriceButton": ticketPriceButton, "containerView": containerView, "weekDayLabel": weekDayLabel, "dateLabel": dateLabel, "favoriteButton": favoriteButton, "separatorLine": separatorLine, "titleLabel": titleLabel, "locationLabel": locationLabel, "ticketsLabel": ticketsLabel, "spacerView1": spacerView1, "spacerView2": spacerView2] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[ticketPriceButton(<=100)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[weekDayLabel(60)]-4-[separatorLine(1)]-8-[titleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[dateLabel(60)]-4-[separatorLine(1)]-8-[locationLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraint(NSLayoutConstraint.init(item: favoriteButton, attribute: .centerX, relatedBy: .equal, toItem: dateLabel, attribute: .centerX, multiplier: 1, constant: 0))
        self.containerView.addConstraint(NSLayoutConstraint.init(item: favoriteButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25))
        self.containerView.addConstraint(NSLayoutConstraint.init(item: ticketsLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 0))
        self.containerView.addConstraint(NSLayoutConstraint.init(item: ticketsLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0))
        self.containerView.addConstraint(NSLayoutConstraint.init(item: spacerView1, attribute: .leading, relatedBy: .equal, toItem: dateLabel, attribute: .leading, multiplier: 1, constant: 0))
        self.containerView.addConstraint(NSLayoutConstraint.init(item: spacerView1, attribute: .width, relatedBy: .equal, toItem: dateLabel, attribute: .width, multiplier: 1, constant: 0))
        self.containerView.addConstraint(NSLayoutConstraint.init(item: spacerView2, attribute: .leading, relatedBy: .equal, toItem: dateLabel, attribute: .leading, multiplier: 1, constant: 0))
        self.containerView.addConstraint(NSLayoutConstraint.init(item: spacerView2, attribute: .width, relatedBy: .equal, toItem: dateLabel, attribute: .width, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView][containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[weekDayLabel(24)][dateLabel(20)][spacerView1(>=8)][favoriteButton(25)][spacerView2(>=8)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[ticketPriceButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[separatorLine]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[titleLabel(<=44)]-1-[locationLabel(18)]-1-[ticketsLabel(18)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraint(NSLayoutConstraint.init(item: spacerView1, attribute: .height, relatedBy: .equal, toItem: spacerView2, attribute: .height, multiplier: 1, constant: 0))
    }
    
    func configure(event: Event){
        if (event.image != nil){
            imageView.sd_setShowActivityIndicatorView(true)
            imageView.sd_setIndicatorStyle(.gray)
            imageView.sd_setImage(with: URL(string: event.image!), placeholderImage: nil)
            imageView.contentMode = .scaleAspectFill
        }
        else{
            imageView.image = UIImage(named: "ticketMasterLogo")
            imageView.contentMode = .scaleAspectFit
        }
        ticketPriceButton.setTitle(String(format:"%@ $%@","from".localized(), event.lowestPrice), for: .normal)
        weekDayLabel.text = event.startDateTime.dateValue().dayOfWeek()?.uppercased()
        dateLabel.text = event.startDateTime.dateValue().monthAndDay()
        titleLabel.text = event.name
        locationLabel.text = String(format: "%@ - %@ - %@", event.startDateTime.dateValue().timeLong()!, String(format: "%@, %@", event.city, event.stateCode), event.venue)
        let ticketInfoString = String(format: "%@ %@     %@ $%@" , event.ticketsLeft!.stringValue, "ticketsLeft".localized(),"from".localized(),event.lowestPrice!.stringValue)
        let attributedString = NSMutableAttributedString(string: ticketInfoString)
        let attributeRange = NSRange(location: (event.ticketsLeft!.stringValue.characters.count)+("ticketsLeft".localized().characters.count)+6, length: ("from".localized().characters.count)+1+1+event.lowestPrice!.stringValue.characters.count)
        let attribute = [NSForegroundColorAttributeName: TMColor.primary]
        attributedString.addAttributes(attribute, range: attributeRange)
        ticketsLabel.attributedText = attributedString
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ticketPriceButton.sizeToFit()
    }
    
    //Button Delegates
    func favoriteButtonPressed(sender: UIButton){
        eventImageCellDelegate.didPressFavorite(sender: sender)
    }
}
