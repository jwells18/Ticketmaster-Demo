//
//  SearchController.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import STPopup

class SearchController: UIViewController, UITableViewDataSource, UITableViewDelegate, TMSearchControllerDelegate, SearchFeatureSectionCellDelegate, SearchDefaultSectionCellDelegate, SearchRecentSectionCellDelegate{
    
    private var searchController: TMSearchController!
    private var searchBar = UISearchBar()
    private var filterNavBar = TMFilterNavBar()
    private var bottomNavBarLine = CALayer()
    private var featureEvents = [Event]()
    private var concertEvents = [Event]()
    private var sportsEvents = [Event]()
    private var theaterAndComedyEvents = [Event]()
    private let searchFeatureCellIdentifier = "featureCell"
    private let searchSectionCellIdentifier = "sectionCell"
    private let searchNearbyCellIdentifier = "nearbyCell"
    private let searchRecentCellIdentifier = "recentCell"
    private var downloadingActivityView = UIActivityIndicatorView()
    private var isInitialDownload = true
    private var emptyCollectionView = UIView()
    private var refreshControl = UIRefreshControl()
    private var tableView: UITableView!
    
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
        //Setup Container View
        filterNavBar.configure(dates: "All Dates",location:String(format: "%@, %@", sampleCurrentCity, sampleCurrentStateCode))
        filterNavBar.addTarget(self, action: #selector(self.filterButtonPressed), for: .touchUpInside)
        filterNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(filterNavBar)
        
        //Add navigationBar hairline
        bottomNavBarLine.frame = CGRect(x: 0, y: 35.5, width: w, height: 0.5)
        bottomNavBarLine.backgroundColor = UIColor.lightGray.cgColor
        filterNavBar.layer.addSublayer(bottomNavBarLine)
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup CollectionView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        //Setup TableView
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = TMColor.faintGray
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.alwaysBounceVertical = true
        tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight, 0)
        tableView.register(SearchFeatureSectionCell.self, forCellReuseIdentifier: searchFeatureCellIdentifier)
        tableView.register(SearchNearbySectionCell.self, forCellReuseIdentifier: searchNearbyCellIdentifier)
        tableView.register(SearchDefaultSectionCell.self, forCellReuseIdentifier: searchSectionCellIdentifier)
        tableView.register(SearchRecentSectionCell.self, forCellReuseIdentifier: searchRecentCellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func setupConstraints(){
        let viewDict = ["filterNavBar": filterNavBar, "tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[filterNavBar]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[filterNavBar(35.5)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-36-[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
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
            
            for event in events!{
                if self.featureEvents.count <= 5{
                    self.featureEvents.append(event)
                }
        
                switch event.type!{
                case .concert:
                    self.concertEvents.append(event)
                    break
                case .sports:
                    self.sportsEvents.append(event)
                    break
                case .theaterAndComedy:
                    self.theaterAndComedyEvents.append(event)
                    break
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    func refreshData(){
        self.downloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bottomNavBarLine.frame.size.width = filterNavBar.frame.width
    }
    
    //CollectionView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSectionHeaderTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return tableView.frame.width*0.5
        case 4:
            return tableView.frame.width*0.6
        default:
            return tableView.frame.width*0.6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: searchFeatureCellIdentifier, for: indexPath) as! SearchFeatureSectionCell
            cell.searchFeatureSectionCellDelegate = self
            cell.configure(events: featureEvents, section: searchSectionHeaderTitles[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: searchSectionCellIdentifier, for: indexPath) as! SearchDefaultSectionCell
            cell.searchDefaultSectionCellDelegate = self
            cell.configure(events: concertEvents, section: searchSectionHeaderTitles[indexPath.row])
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: searchNearbyCellIdentifier, for: indexPath) as! SearchNearbySectionCell
            cell.configure(section: searchSectionHeaderTitles[indexPath.row])
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: searchSectionCellIdentifier, for: indexPath) as! SearchDefaultSectionCell
            cell.searchDefaultSectionCellDelegate = self
            cell.configure(events: sportsEvents, section: searchSectionHeaderTitles[indexPath.row])
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: searchRecentCellIdentifier, for: indexPath) as! SearchRecentSectionCell
            cell.searchRecentSectionCellDelegate = self
            cell.configure(events: featureEvents, section: searchSectionHeaderTitles[indexPath.row])
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: searchSectionCellIdentifier, for: indexPath) as! SearchDefaultSectionCell
            cell.searchDefaultSectionCellDelegate = self
            cell.configure(events: theaterAndComedyEvents, section: searchSectionHeaderTitles[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: searchSectionCellIdentifier, for: indexPath) as! SearchDefaultSectionCell
            return cell
        }
    }
    
    //CollectionView Delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    func didPressFavorite(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressViewMore(sender: UIButton){
        let touchPoint = sender.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: touchPoint)
        let row = (indexPath?.row)!
        switch row{
        case _ where row == 1:
            let category = searchSectionHeaderTitles[row]
            let eventCategoryVC = TMEventCategoryController(category: category)
            eventCategoryVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventCategoryVC, animated: true)
            break
        case _ where row == 3:
            let category = searchSectionHeaderTitles[row]
            let eventCategoryVC = TMEventCategoryController(category: category)
            eventCategoryVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventCategoryVC, animated: true)
            break
        case _ where row == 4:
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
            break
        case _ where row > 4:
            let category = searchSectionHeaderTitles[row]
            let eventCategoryVC = TMEventCategoryController(category: category)
            eventCategoryVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventCategoryVC, animated: true)
            break
        default:
            break
        }
    }
    
    func didPressEventCell(cell: UITableViewCell, indexPath: IndexPath) {
        let tableViewCellIndexPath = tableView.indexPath(for: cell)
        let row = (tableViewCellIndexPath?.row)!
        switch row {
        case 0:
            let event = self.featureEvents[indexPath.item]
            let eventVC = TMEventController(event: event)
            eventVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventVC, animated: true)
        case 1:
            let event = self.concertEvents[indexPath.item]
            let eventVC = TMEventController(event: event)
            eventVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventVC, animated: true)
        case 3:
            let event = self.sportsEvents[indexPath.item]
            let eventVC = TMEventController(event: event)
            eventVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventVC, animated: true)
        case 4:
            let event = self.featureEvents[indexPath.item]
            let eventVC = TMEventController(event: event)
            eventVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventVC, animated: true)
        case 5:
            let event = self.theaterAndComedyEvents[indexPath.item]
            let eventVC = TMEventController(event: event)
            eventVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(eventVC, animated: true)
        default:
            break
        }
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
