//
//  HomeController.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import PopupDialog
import STPopup

class HomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, EventCategoriesCellDelegate, TopEventsCellDelegate, ConnectFacebookCellDelegate, EventImageCellDelegate, TMSearchControllerDelegate{
    
    private var searchController: TMSearchController!
    var filterNavBar = TMFilterNavBar()
    private var bottomNavViewLine = CALayer()
    private let eventCellIdentifier = "eventCell"
    private let topEventsCellIdentifier = "topEventsCell"
    private let eventCategoryCellIdentifier = "eventCategoryCell"
    private let connectFacebookCellIdentifier = "connectFacebookCell"
    private var downloadingActivityView = UIActivityIndicatorView()
    private var isInitialDownload = true
    private var emptyCollectionViewLabel = UILabel()
    private var refreshControl = UIRefreshControl()
    private var events = [Event]()
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = TMColor.faintGray
        collectionView.showsVerticalScrollIndicator = true
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()
    
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
        //Remove Gray Hairline
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupNavigationBar(){
        //Setup Navigation TitleView
        searchController = TMSearchController(searchResultsController: self, searchBarFrame: CGRect(x:0, y:0, width:w, height:50))
        searchController.customSearchBar.placeholder = "searchPlaceholder".localized()
        searchController.customDelegate = self
        self.navigationItem.titleView = searchController.customSearchBar
        
        //Setup Bottom NavigationBar
        self.setupBottomNavBar()
    }
    
    func setupBottomNavBar(){
        //Setup Filter Bottom NavigationBar
        filterNavBar.configure(dates: "All Dates",location: String(format: "%@, %@", sampleCurrentCity, sampleCurrentStateCode))
        filterNavBar.addTarget(self, action: #selector(self.filterButtonPressed), for: .touchUpInside)
        filterNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(filterNavBar)
        
        //Add NavigationBar hairline
        bottomNavViewLine.frame = CGRect(x: 0, y: 35.5, width: w, height: 0.5)
        bottomNavViewLine.backgroundColor = UIColor.lightGray.cgColor
        filterNavBar.layer.addSublayer(bottomNavViewLine)
    }
    
    func setupView(){
        //Set Background Color
        self.view.backgroundColor = .white
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupCollectionView(){
        //Register Cell for CollectionView
        collectionView.register(EventImageCell.self, forCellWithReuseIdentifier: eventCellIdentifier)
        collectionView.register(TopEventsCell.self, forCellWithReuseIdentifier: topEventsCellIdentifier)
        collectionView.register(EventCategoriesCell.self, forCellWithReuseIdentifier: eventCategoryCellIdentifier)
        collectionView.register(ConnectFacebookCell.self, forCellWithReuseIdentifier: connectFacebookCellIdentifier)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight+10, 0)
        self.view.addSubview(collectionView)
        
        //Setup Downloading ActivityView
        downloadingActivityView.activityIndicatorViewStyle = .gray
        collectionView.backgroundView = downloadingActivityView
        
        //Setup RefreshControl
        refreshControl.tintColor = .lightGray
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        //Setup EmptyCollectionView
        emptyCollectionViewLabel.text = "emptyEventSearch".localized()
        emptyCollectionViewLabel.textColor = .lightGray
        emptyCollectionViewLabel.textAlignment = .center
        emptyCollectionViewLabel.font  = UIFont.boldSystemFont(ofSize: 22)
        emptyCollectionViewLabel.numberOfLines = 0
    }
    
    func setupConstraints(){
        let viewDict = ["filterNavBar": filterNavBar, "collectionView": collectionView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[filterNavBar]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[filterNavBar(35.5)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-36-[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func downloadData(){
        //Start Downloading ActivityView
        if isInitialDownload{
            downloadingActivityView.startAnimating()
        }
        
        //Change Initial Download Bool
        isInitialDownload = false
        
        let eventManager = EventManager()
        eventManager.downloadEvents(dmaId: "324") { (events) in
            
            //Stop Downloading ActivityView
            if(self.downloadingActivityView.isAnimating){
                self.downloadingActivityView.stopAnimating()
            }
            
            self.events = events!
            
            //Show Empty View (if necessary)
            if self.events.count > 0{
                self.collectionView.backgroundView = nil
            }
            else{
                self.collectionView.backgroundView = self.emptyCollectionViewLabel
            }
            
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    func refreshData(){
        self.downloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        bottomNavViewLine.frame.size.width = filterNavBar.frame.width
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch isInitialDownload{
        case true:
            return 0
        case false:
            let eventCount = events.count
            switch eventCount{
            case _ where eventCount == 0:
                return 0
            case _ where eventCount > 0 && eventCount <= 3:
                return 1
            case _ where eventCount > 3 && eventCount <= 4:
                return 2
            case _ where eventCount > 4 && eventCount <= 6:
                return 2+(eventCount-3)
            case _ where eventCount > 6:
                return 3+(eventCount-3)
            default:
                return 0
            }
        }
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let item = indexPath.item
        switch item{
        case _ where item == 0:
            return CGSize(width: collectionView.frame.width-20, height: 340)
        case _ where item == 2:
            return CGSize(width: collectionView.frame.width-20, height: collectionView.frame.height*0.5)
        case _ where item == 6:
            return CGSize(width: collectionView.frame.width-20, height: eventCategoryTableCellHeight*5)
        default:
            return CGSize(width: collectionView.frame.width-20, height: collectionView.frame.height*0.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = indexPath.item
        switch item{
        case _ where item == 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topEventsCellIdentifier, for: indexPath) as! TopEventsCell
            cell.topEventsCellDelegate = self
            cell.configure(events: Array(events.prefix(3)))
            return cell
        case _ where item == 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellIdentifier, for: indexPath) as! EventImageCell
            cell.configure(event: events[indexPath.item+2])
            cell.eventImageCellDelegate = self
            return cell
        case _ where item == 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: connectFacebookCellIdentifier, for: indexPath) as! ConnectFacebookCell
            cell.connectFacebookCellDelegate = self
            return cell
        case _ where item > 2 && item <= 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellIdentifier, for: indexPath) as! EventImageCell
            cell.configure(event: events[indexPath.item+1])
            cell.eventImageCellDelegate = self
            return cell
        case _ where item == 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCategoryCellIdentifier, for: indexPath) as! EventCategoriesCell
            cell.eventCategoriesCellDelegate = self
            return cell
        case _ where item > 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellIdentifier, for: indexPath) as! EventImageCell
            cell.eventImageCellDelegate = self
            cell.configure(event: events[indexPath.item])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellIdentifier, for: indexPath) as! EventImageCell
            cell.eventImageCellDelegate = self
            return cell
        }
    }
    
    //CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        switch item {
        case _ where item == 1:
            let event = self.events[item+2]
            let eventVC = TMEventController(event: event)
            eventVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventVC, animated: true)
        case _ where item > 2 && item <= 5:
            let event = self.events[item+1]
            let eventVC = TMEventController(event: event)
            eventVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventVC, animated: true)
        case _ where item > 6:
            let event = self.events[item]
            let eventVC = TMEventController(event: event)
            eventVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventVC, animated: true)
        default:
            break
        }
    }
    
    func didPressTopEventsCell(indexPath: IndexPath){
        let event = self.events[indexPath.item]
        let eventVC = TMEventController(event: event)
        eventVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(eventVC, animated: true)
    }
    
    func didPressTopEventsFavorite(indexPath: IndexPath){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressEventCategoriesCell(indexPath: IndexPath) {
        switch indexPath.row{
        case _ where indexPath.row < 4:
            let category = eventNavigationCategories[indexPath.row]
            let eventCategoryVC = TMEventCategoryController(category: category)
            eventCategoryVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventCategoryVC, animated: true)
            break
        default:
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
            break
        }
    }
    
    func didPressConnectFacebook(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressFavorite(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //Button Delegate
    func filterButtonPressed(){
        //Show Filter Popup
        let popupVC = TMFilterPopupController()
        popupVC.contentSizeInPopup = CGSize(width: w-20, height: 330)
        let popupController = STPopupController.init(rootViewController: popupVC)
        popupController.containerView.layer.cornerRadius = 10
        popupController.navigationBarHidden = true
        popupController.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissPopupVC)))
        popupController.present(in: self)
    }
    
    func dismissPopupVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //SearchController Delegates
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func didStartSearching() {
        
    }
    
    func didEndSearching() {
        
    }
    
    func didTapOnSearchButton() {
        
    }
    
    func didTapOnCancelButton() {
        
    }
    
    func didChangeSearchText(searchText: String) {
        
    }
}
