//
//  TMEventCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol EventCellDelegate {
    func relayDidPressTopEventsFavorite(sender:UIButton)
}

class TMEventCell: UITableViewCell{
    
    var eventCellDelegate: EventCellDelegate!
    var weekDayLabel = UILabel()
    var dateLabel = UILabel()
    var favoriteButton = UIButton()
    var separatorLine = UIView()
    var titleLabel = UILabel()
    var locationLabel = UILabel()
    var ticketsLabel = UILabel()
    
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
        
        //Setup WeekDay Label
        weekDayLabel.textColor = .darkGray
        weekDayLabel.textAlignment = .center
        weekDayLabel.font = UIFont.boldSystemFont(ofSize: 20)
        weekDayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(weekDayLabel)
        
        //Setup Date Label
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateLabel)
    
        //Setup Favorite Button
        favoriteButton.setImage(UIImage(named: "favorites"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(self.favoriteButtonPressed), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(favoriteButton)
        
        //SeparatorLine
        separatorLine.backgroundColor = TMColor.faintGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separatorLine)
        
        //Setup Title Label
        titleLabel.textColor = .darkGray
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        //Setup Location Label
        locationLabel.textColor = .darkGray
        locationLabel.font = UIFont.systemFont(ofSize: 12)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(locationLabel)
        
        //Setup Tickets Label
        ticketsLabel.textColor = .darkGray
        ticketsLabel.font = UIFont.systemFont(ofSize: 12)
        ticketsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ticketsLabel)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        //Add SpacerViews
        let spacerView1 = UIView()
        spacerView1.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView1)
        let spacerView2 = UIView()
        spacerView2.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView2)
        
        let viewDict = ["weekDayLabel": weekDayLabel, "dateLabel": dateLabel, "favoriteButton": favoriteButton, "separatorLine": separatorLine, "titleLabel": titleLabel, "locationLabel": locationLabel, "ticketsLabel": ticketsLabel, "spacerView1": spacerView1, "spacerView2": spacerView2] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[weekDayLabel(60)]-4-[separatorLine(1)]-8-[titleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[dateLabel(60)]-4-[separatorLine(1)]-8-[locationLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: favoriteButton, attribute: .centerX, relatedBy: .equal, toItem: dateLabel, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: favoriteButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25))
        self.addConstraint(NSLayoutConstraint.init(item: ticketsLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: ticketsLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerView1, attribute: .leading, relatedBy: .equal, toItem: dateLabel, attribute: .leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerView1, attribute: .width, relatedBy: .equal, toItem: dateLabel, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerView2, attribute: .leading, relatedBy: .equal, toItem: dateLabel, attribute: .leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerView2, attribute: .width, relatedBy: .equal, toItem: dateLabel, attribute: .width, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[weekDayLabel(24)][dateLabel(20)][spacerView1][favoriteButton(25)][spacerView2]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[separatorLine]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[titleLabel(<=44)]-1-[locationLabel(18)]-1-[ticketsLabel(18)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Set SpacerViews equal to each other
        self.addConstraint(NSLayoutConstraint.init(item: spacerView1, attribute: .height, relatedBy: .equal, toItem: spacerView2, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerView2, attribute: .height, relatedBy: .equal, toItem: spacerView1, attribute: .height, multiplier: 1, constant: 0))
    }
    
    func configure(event: Event){
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
    
    //Button Delegates
    func favoriteButtonPressed(sender:UIButton){
        eventCellDelegate.relayDidPressTopEventsFavorite(sender: sender)
    }
}
