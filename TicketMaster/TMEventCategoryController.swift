//
//  TMEventCategoryController.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/5/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TMEventCategoryController: UIViewController, UITableViewDataSource, UITableViewDelegate, EventCellDelegate{
    
    var category: String!
    var tableView: UITableView!
    private let cellIdentifier = "cellIdentifier"
    var events = [Event]()
    private var isInitialDownload = true
    private var downloadingActivityView = UIActivityIndicatorView()
    private var emptyTableViewLabel = UILabel()
    
    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
        
        //Download Data
        self.downloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Add Gray Hairline
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    func setupNavigationBar(){
        //Setup Navigation Title
        self.navigationItem.title = self.category.localized()
        
        //Setup Navigation Items
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = TMColor.faintGray
        tableView.separatorInset = .zero
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(TMEventCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        //Setup Empty TableView Label
        emptyTableViewLabel.text = "emptyEventSearch".localized()
        emptyTableViewLabel.textColor = .lightGray
        emptyTableViewLabel.textAlignment = .center
        emptyTableViewLabel.font  = UIFont.boldSystemFont(ofSize: 22)
        emptyTableViewLabel.numberOfLines = 0
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func downloadData(){
        //Start Downloading ActivityView
        if isInitialDownload{
            downloadingActivityView.startAnimating()
        }
        
        //Change Initial Download Bool
        isInitialDownload = false
        
        switch self.category{
        case _ where self.category == "happeningToday":
            let eventManager = EventManager()
            let date = Date()
            eventManager.downloadEvents(startDate: date.startOfDay().timestamp(), endDate: date.endOfDay().timestamp()) { (events) in
                //Stop Downloading ActivityView
                if(self.downloadingActivityView.isAnimating){
                    self.downloadingActivityView.stopAnimating()
                }
                
                self.events = events!
                
                //Show Empty View (if necessary)
                if self.events.count > 0{
                    self.tableView.backgroundView = nil
                }
                else{
                    self.tableView.backgroundView = self.emptyTableViewLabel
                }
                
                self.tableView.reloadData()
            }
            break
        case _ where self.category == "concert" || self.category == "sports" || self.category == "theaterAndComedy":
            let eventManager = EventManager()
            eventManager.downloadEvents(type: self.category) { (events) in
                //Stop Downloading ActivityView
                if(self.downloadingActivityView.isAnimating){
                    self.downloadingActivityView.stopAnimating()
                }
                
                self.events = events!
                
                //Show Empty View (if necessary)
                if self.events.count > 0{
                    self.tableView.backgroundView = nil
                }
                else{
                    self.tableView.backgroundView = self.emptyTableViewLabel
                }
                
                self.tableView.reloadData()
            }
            break
        default:
            //Stop Downloading ActivityView
            if(self.downloadingActivityView.isAnimating){
                self.downloadingActivityView.stopAnimating()
            }
            
            break
        }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TMEventCell
        cell.eventCellDelegate = self
        cell.configure(event: events[indexPath.row])
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        let eventVC = TMEventController(event: event)
        eventVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(eventVC, animated: true)
    }
    
    func relayDidPressTopEventsFavorite(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
