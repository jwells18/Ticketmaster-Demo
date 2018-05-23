//
//  TicketsEmptyView.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TicketsEmptyView: UIView{
    
    var emptyImageView = UIImageView()
    var emptyLabel = UILabel()
    var emptySubLabel = UILabel()
    var emptyButton = UIButton()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup Empty ImageView
        emptyImageView.image = UIImage(named: "ticketHands")
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emptyImageView)
        
        //Setup Empty Label
        self.emptyLabel.text = "emptyViewTitle".localized()
        self.emptyLabel.textColor = .darkGray
        self.emptyLabel.textAlignment = .center
        self.emptyLabel.numberOfLines = 0
        self.emptyLabel.font = UIFont.boldSystemFont(ofSize: 26)
        self.emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emptyLabel)
        
        //Setup Empty SubLabel
        self.emptySubLabel.text = "emptyViewSubTitle".localized()
        self.emptySubLabel.textColor = .gray
        self.emptySubLabel.textAlignment = .center
        self.emptySubLabel.numberOfLines = 0
        self.emptySubLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.emptySubLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emptySubLabel)
        
        //Setup Empty Button
        self.emptyButton.setTitle("emptyViewButtonTitle".localized(), for: .normal)
        self.emptyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.emptyButton.layer.cornerRadius = 5
        self.emptyButton.clipsToBounds = true
        self.emptyButton.backgroundColor = TMColor.primary
        self.emptyButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.emptyButton)
        
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
        
        let viewDict = ["emptyImageView": emptyImageView, "emptyLabel": emptyLabel, "emptySubLabel": emptySubLabel, "emptyButton": emptyButton, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: emptyImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: emptyImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)])
        self.addConstraints([NSLayoutConstraint.init(item: emptyLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: emptyLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.7, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: emptySubLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: emptySubLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.7, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: emptyButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: emptyButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.4, constant: 0)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewTop]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][emptyImageView(100)]-40-[emptyLabel]-4-[emptySubLabel]-35-[emptyButton(40)]-50-[spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}
