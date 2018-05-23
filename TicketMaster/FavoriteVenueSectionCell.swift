//
//  FavoriteVenueSectionCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol FavoriteVenueSectionCellDelegate {
    func didPressVenueCell(indexPath: IndexPath)
    func didPressFavoriteVenue(indexPath: IndexPath)
}

class FavoriteVenueSectionCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate, FavoriteVenueCellDelegate{
    
    var favoriteVenueSectionCellDelegate: FavoriteVenueSectionCellDelegate!
    var tableView: UITableView!
    private let cellIdentifier = "cell"
    var venues = [DBVenue]()
    
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
        
        //Setup CollectionView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        //Setup TableView
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = TMColor.faintGray
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight, 0)
        tableView.register(FavoriteVenueCell.self, forCellReuseIdentifier: cellIdentifier)
        self.addSubview(tableView)
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(venues: [DBVenue]){
        self.venues = venues
        self.tableView.reloadData()
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//venues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoriteVenueCell
        cell.configure(venue: nil)//venues[indexPath.row])
        cell.favoriteVenueCellDelegate = self
        return cell
    }
    
    //UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoriteVenueSectionCellDelegate.didPressVenueCell(indexPath: indexPath)
    }
    
    func relayDidPressFavoriteVenueCell(sender: UIButton) {
        let touchPoint = sender.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: touchPoint)
        favoriteVenueSectionCellDelegate.didPressFavoriteVenue(indexPath: indexPath!)
    }
}
