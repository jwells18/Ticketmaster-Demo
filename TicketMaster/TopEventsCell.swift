//
//  TopEventsCell.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/23/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol TopEventsCellDelegate{
    func didPressTopEventsCell(indexPath: IndexPath)
    func didPressTopEventsFavorite(indexPath: IndexPath)
}

class TopEventsCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate, EventCellDelegate{
    
    var titleLabel = UILabel()
    var titleLabelSeparator = UIView()
    private let cellIdentifier = "cell"
    var tableView = UITableView()
    var topEventsCellDelegate: TopEventsCellDelegate!
    var events = [Event]()
    
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
        tableView.register(TMEventCell.self, forCellReuseIdentifier: cellIdentifier)
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
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(events: [Event]){
        self.events = events
        self.tableView.reloadData()
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let topEventsTableHeader = TopEventsTableHeader()
        return topEventsTableHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TMEventCell
        cell.eventCellDelegate = self
        cell.configure(event: events[indexPath.row])
        return cell
    }
    
    //UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        topEventsCellDelegate.didPressTopEventsCell(indexPath: indexPath)
    }

    func relayDidPressTopEventsFavorite(sender:UIButton){
        let touchPoint = sender.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: touchPoint)
        topEventsCellDelegate.didPressTopEventsFavorite(indexPath: indexPath!)
    }
}
