//
//  TMVenueMapView.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TMVenueMapView: UIScrollView{
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        //Setup ScrollView
        self.minimumZoomScale = 0.2
        self.maximumZoomScale = 5.0
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.zoomScale = 1
        
        //Setup ImageView
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
    }
    
    func configure(event: Event){
        imageView.image = UIImage(named: "roseBowlConcertMap")
    }
    
    override func layoutSubviews() {
        self.contentSize = imageView.frame.size
    }
}
