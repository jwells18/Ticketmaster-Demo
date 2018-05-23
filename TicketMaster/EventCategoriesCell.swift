//
//  EventCategoriesCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol EventCategoriesCellDelegate{
    func didPressEventCategoriesCell(indexPath: IndexPath)
}

class EventCategoriesCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate{
    
    private let cellIdentifier = "cell"
    var tableView = UITableView()
    var eventCategoriesCellDelegate: EventCategoriesCellDelegate!
    
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
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = TMColor.faintGray
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventNavigationCategories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return eventCategoryTableCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = eventNavigationCategories[indexPath.row].localized()
        cell.textLabel?.textColor = .darkGray
        cell.imageView?.image = eventNavigationCategoriesIcon[indexPath.row]!.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = TMColor.primary
        return cell
    }
    
    //UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventCategoriesCellDelegate.didPressEventCategoriesCell(indexPath: indexPath)
    }
}
