//
//  TMEventController.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/5/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import HMSegmentedControl

class TMEventController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, FilterToolbarDelegate {
    
    private var event: Event!
    private var tableView: UITableView!
    private let cellIdentifier = "cell"
    private var tickets = [Ticket]()
    private var ticketFilterHeader = TMFilterToolbar()
    private var venueView = TMVenueMapView()
    private var ticketSectionHeader = TMTicketSectionHeader()
    
    init(event: Event) {
        self.event = event
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
        //Remove Gray Hairline
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Title
        let titleView = TMTicketTitleView(frame: CGRect(x: 0, y: 0, width: 200, height: 32))
        titleView.configure(event: self.event)
        self.navigationItem.titleView = titleView
        
        //Setup Navigation Items
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup Ticket Filter Header
        self.setupTicketFilterHeader()
        
        //Setup Venue View
        self.setupVenueView()
        
        //Setup Ticket Section Header
        self.setupTicketSectionHeader()
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTicketFilterHeader(){
        ticketFilterHeader.filterToolbarDelegate = self
        ticketFilterHeader.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(ticketFilterHeader)
    }
    
    func setupVenueView(){
        venueView.delegate = self
        venueView.backgroundColor = TMColor.faintGray
        venueView.configure(event: self.event)
        venueView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(venueView)
    }
    
    func setupTicketSectionHeader(){
        ticketSectionHeader.backgroundColor = .white
        ticketSectionHeader = TMTicketSectionHeader(frame: .zero)
        ticketSectionHeader.segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue), for: .valueChanged)
        ticketSectionHeader.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(ticketSectionHeader)
    }
    
    func setupTableView(){
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = TMColor.faintGray
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(TMTicketCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func setupConstraints(){
        let viewDict = ["ticketFilterHeader": ticketFilterHeader, "venueView": venueView, "ticketSectionHeader": ticketSectionHeader, "tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[ticketFilterHeader]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[venueView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[ticketSectionHeader]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints([NSLayoutConstraint.init(item: venueView, attribute: .height, relatedBy: .equal, toItem: self.tableView, attribute: .height, multiplier: 1, constant: 0.3)])
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[ticketFilterHeader(60)][venueView][ticketSectionHeader(44)][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func downloadData(){
        self.tickets = createSampleTickets()
        self.tableView.reloadData()
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TMTicketCell
        cell.configure(ticket: tickets[indexPath.row])
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //SegmentedControl Delegate
    func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        self.tableView.reloadData()
    }
    
    //ScrollView Delegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if scrollView == venueView{
            return venueView.imageView
        }
        
        return nil
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView){
        let imgViewSize:CGSize! = venueView.imageView.frame.size;
        let imageSize:CGSize! = venueView.imageView.image?.size;
        var realImgSize : CGSize;
        if(imageSize.width / imageSize.height > imgViewSize.width / imgViewSize.height) {
            realImgSize = CGSize(width: imgViewSize.width,height: imgViewSize.width / imageSize.width * imageSize.height);
        }
        else {
            realImgSize = CGSize(width: imgViewSize.height / imageSize.height * imageSize.width, height: imgViewSize.height);
        }
        var fr:CGRect = CGRect.zero
        fr.size = realImgSize;
        venueView.imageView.frame = fr;
        
        let scrSize:CGSize = scrollView.frame.size;
        let offx:CGFloat = (scrSize.width > realImgSize.width ? (scrSize.width - realImgSize.width) / 2 : 0);
        let offy:CGFloat = (scrSize.height > realImgSize.height ? (scrSize.height - realImgSize.height) / 2 : 0);
        scrollView.contentInset = UIEdgeInsetsMake(offy, offx, offy, offx);
        
        let scrollViewSize:CGSize = self.scrollViewVisibleSize();
        
        var imageCenter:CGPoint = CGPoint(x: venueView.contentSize.width/2.0, y:
            venueView.contentSize.height/2.0);
        
        let scrollViewCenter:CGPoint = self.scrollViewCenter()
        
        if (venueView.contentSize.width < scrollViewSize.width) {
            imageCenter.x = scrollViewCenter.x;
        }
        
        if (venueView.contentSize.height < scrollViewSize.height) {
            imageCenter.y = scrollViewCenter.y;
        }
        
        venueView.imageView.center = imageCenter;
        
    }
    
    func scrollViewCenter() -> CGPoint {
        let scrollViewSize:CGSize = self.scrollViewVisibleSize()
        return CGPoint(x: scrollViewSize.width/2.0, y: scrollViewSize.height/2.0);
    }
    
    func scrollViewVisibleSize() -> CGSize{
        
        let contentInset:UIEdgeInsets = venueView.contentInset;
        let scrollViewSize:CGSize = venueView.bounds.standardized.size;
        let width:CGFloat = scrollViewSize.width - contentInset.left - contentInset.right;
        let height:CGFloat = scrollViewSize.height - contentInset.top - contentInset.bottom;
        return CGSize(width:width, height:height);
    }
    
    //Toolbar Delegate
    func didPressQuantityButton() {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressPriceButton() {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressTypeButton() {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didChangeAccessibleSwitch(bool: Bool){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressResetButton() {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
