//
//  FavoriteSectionCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol FavoritePerformerSectionCellDelegate {
    func didPressPerformerCell(indexPath: IndexPath)
    func didPressFavoritePerformer(indexPath: IndexPath)
    func didPressPerformerHeaderSearchBar()
    func didPressPerformerHeaderCell(indexPath: IndexPath)
}

class FavoritePerformerSectionCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate, FavoritePerformerTableHeaderDelegate, FavoritePerformerCellDelegate{
    
    var favoritePerformerSectionCellDelegate: FavoritePerformerSectionCellDelegate!
    private let cellIdentifier = "cell"
    var tableView: UITableView!
    var tableViewHeader: FavoritePerformerTableHeader!
    var performers = [DBPerformer]()
    
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
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = TMColor.faintGray
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight, 0)
        tableView.register(FavoritePerformerCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        
        //Setup TableView Header
        tableViewHeader = FavoritePerformerTableHeader(frame: .zero)
        tableViewHeader.favoritePerformerTableHeaderDelegate = self
        tableViewHeader.frame.size.height = 260
        self.tableView.tableHeaderView = tableViewHeader
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(performers: [DBPerformer]){
        self.performers = performers
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//performers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoritePerformerCell
        cell.configure(performer: nil)//performers[indexPath.row])
        cell.favoritePerformerCellDelegate = self
        return cell
    }
    
    //UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritePerformerSectionCellDelegate.didPressPerformerCell(indexPath: indexPath)
    }
    
    func relayDidPressFavoritePerformerCell(sender: UIButton) {
        let touchPoint = sender.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: touchPoint)
        favoritePerformerSectionCellDelegate.didPressFavoritePerformer(indexPath: indexPath!)
    }
    
    //Table Header Delegate
    func relayDidPressSearchBar(){
        favoritePerformerSectionCellDelegate.didPressPerformerHeaderSearchBar()
    }
    
    func relayDidPressHeaderCell(indexPath: IndexPath){
        favoritePerformerSectionCellDelegate.didPressPerformerHeaderCell(indexPath: indexPath)
    }
}
