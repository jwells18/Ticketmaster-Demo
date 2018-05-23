//
//  FavoritesController.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import HMSegmentedControl

class FavoritesController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FavoritePerformerSectionCellDelegate, FavoriteEventSectionCellDelegate, FavoriteVenueSectionCellDelegate{

    private var bottomNavBar = UIView()
    private var bottomNavBarLine = CALayer()
    private let performerCellIdentifier = "performerCell"
    private let eventCellIdentifier = "eventCell"
    private let venueCellIdentifier = "venueCell"
    var segmentedControl = HMSegmentedControl()
    var performers = [DBPerformer]()
    var events = [DBEvent]()
    var venues = [DBVenue]()
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = true
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
        //Setup Navigation Title
        self.navigationItem.title = "favoritesTabTitle".localized()
        
        //Setup Bottom NavigationBar
        self.setupBottomNavBar()
    }
    
    func setupBottomNavBar(){
        //Setup Container View
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.backgroundColor = .white
        
        //Setup SegmentedControl
        segmentedControl = HMSegmentedControl(sectionTitles: favoritesSegmentedTitles)
        segmentedControl.frame = CGRect(x: 8, y: 0, width: w-16, height: 35.5)
        segmentedControl.tintColor = .lightGray
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectionIndicatorColor = TMColor.primary
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionIndicatorHeight = 2
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.lightGray]
        segmentedControl.selectedTitleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: TMColor.primary]
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        bottomNavBar.addSubview(segmentedControl)
        
        //Add navigationBar hairline
        bottomNavBarLine.frame = CGRect(x: 0, y: 35.5, width: w, height: 0.5)
        bottomNavBarLine.backgroundColor = UIColor.lightGray.cgColor
        bottomNavBar.layer.addSublayer(bottomNavBarLine)
        self.view.addSubview(bottomNavBar)
    }
    
    func setupView(){
        //Set Background Color
        self.view.backgroundColor = .white
        
        //Setup TableView
        self.setupCollectionView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupCollectionView(){
        //Register Cell for CollectionView
        collectionView.register(FavoritePerformerSectionCell.self, forCellWithReuseIdentifier: performerCellIdentifier)
        collectionView.register(FavoriteEventSectionCell.self, forCellWithReuseIdentifier: eventCellIdentifier)
        collectionView.register(FavoriteVenueSectionCell.self, forCellWithReuseIdentifier: venueCellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
    }
    
    func setupConstraints(){
        let viewDict = ["bottomNavBar": bottomNavBar, "segmentedControl": segmentedControl, "collectionView": collectionView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomNavBar]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.bottomNavBar.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[segmentedControl]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[bottomNavBar(36)][collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.bottomNavBar.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[segmentedControl(35.5)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func downloadData(){
        //Retrieve user's locally stored performers, events, and venues from Realm
        let favoritiesManager = FavoritesManager()
        favoritiesManager.loadFavorites(user: currentUser) { (performers, events, venues) in
            //self.performers = Array(performers)
            //self.events = Array(events)
            //self.venues = Array(venues)
            //NOTE: For demo purposes, sample data is created in the cell
        }
        self.collectionView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        bottomNavBarLine.frame.size.width = bottomNavBar.frame.width
    }

    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: performerCellIdentifier, for: indexPath) as! FavoritePerformerSectionCell
            cell.favoritePerformerSectionCellDelegate = self
            cell.configure(performers: performers)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellIdentifier, for: indexPath) as! FavoriteEventSectionCell
            cell.favoriteEventSectionCellDelegate = self
            cell.configure(events: events)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: venueCellIdentifier, for: indexPath) as! FavoriteVenueSectionCell
            cell.favoriteVenueSectionCellDelegate = self
            cell.configure(venues: venues)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: performerCellIdentifier, for: indexPath) as! FavoritePerformerSectionCell
            return cell
        }
    }
    
    //CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //Segmented Control Delegate
    func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        //Set CollectionView index to SegmentedControl index
        let indexPath = IndexPath(item: segmentedControl.selectedSegmentIndex, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //ScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView == self.collectionView){
            //Change SegmentedControl index to match CollectionView index
            let pageWidth = scrollView.frame.size.width;
            let page = Int(scrollView.contentOffset.x / pageWidth);
            segmentedControl.setSelectedSegmentIndex(UInt(page), animated: true)
        }
    }
    
    //Section Cell Delegate
    func didPressPerformerCell(indexPath: IndexPath){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressFavoritePerformer(indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressPerformerHeaderSearchBar() {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressPerformerHeaderCell(indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressEventCell(indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressFavoriteEvent(indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressVenueCell(indexPath: IndexPath){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressFavoriteVenue(indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
}
