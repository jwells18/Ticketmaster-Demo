//
//  SearchDefaultSectionCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/23/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol SearchDefaultSectionCellDelegate {
    func didPressViewMore(sender: UIButton)
    func didPressFavorite(sender: UIButton)
    func didPressEventCell(cell: UITableViewCell, indexPath: IndexPath)
}

class SearchDefaultSectionCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SearchEventCellDelegate{
    
    var searchDefaultSectionCellDelegate: SearchDefaultSectionCellDelegate!
    var cellIdentifier = "cell"
    var events = [Event]()
    var sectionLabel = UILabel()
    var viewMoreButton = UIButton()
    var separatorLine = UIView()
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.clipsToBounds = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Setup View
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        //Setup SectionLabel
        self.setupSectionLabel()
        
        //Setup View More Button
        self.setupViewMoreButton()
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupSectionLabel(){
        sectionLabel.textColor = .darkGray
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        sectionLabel.numberOfLines = 1
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sectionLabel)
    }
    
    func setupViewMoreButton(){
        viewMoreButton.setTitle("viewMore".localized(), for: .normal)
        viewMoreButton.setTitleColor(.lightGray, for: .normal)
        viewMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        viewMoreButton.addTarget(self, action: #selector(viewMoreButtonPressed), for: .touchUpInside)
        viewMoreButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewMoreButton)
    }
    
    func setupCollectionView(){
        collectionView.register(SearchEventCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
    }
    
    func setupConstraints(){
        //Add SpacerViews
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        
        let viewDict = ["sectionLabel": sectionLabel, "spacerView": spacerView, "viewMoreButton": viewMoreButton, "collectionView": collectionView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[sectionLabel][spacerView][viewMoreButton]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[sectionLabel(40)]-1-[collectionView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: spacerView, attribute: .centerY, relatedBy: .equal, toItem: sectionLabel, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: spacerView, attribute: .height, relatedBy: .equal, toItem: sectionLabel, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: viewMoreButton, attribute: .centerY, relatedBy: .equal, toItem: sectionLabel, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: viewMoreButton, attribute: .height, relatedBy: .equal, toItem: sectionLabel, attribute: .height, multiplier: 1, constant: 0)])
    }
    
    func configure(events: [Event], section: String){
        self.events = events
        self.sectionLabel.text = section.localized()
        self.collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width*0.4, height: collectionView.frame.height-20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SearchEventCell
        cell.searchEventCellDelegate = self
        cell.configure(event: events[indexPath.item])
        return cell
    }
    
    //CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchDefaultSectionCellDelegate.didPressEventCell(cell: self, indexPath: indexPath)
    }
    
    //Button Delegates
    func viewMoreButtonPressed(sender: UIButton){
        searchDefaultSectionCellDelegate.didPressViewMore(sender: sender)
    }
    
    func relayDidPressFavorite(sender: UIButton) {
        searchDefaultSectionCellDelegate.didPressFavorite(sender: sender)
    }
}
