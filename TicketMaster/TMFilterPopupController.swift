//
//  TMFilterPopupController.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/5/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TMFilterPopupController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterDoneCellDelegate, FilterDateCellDelegate {

    var tableView: UITableView!
    private let filterLocationCellIdentifier = "filterLocationCell"
    private let filterDateCellIdentifier = "filterDateCell"
    private let filterDoneCellIdentifier = "doneCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup View
        self.setupView()
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
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 110
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(TMFilterLocationCell.self, forCellReuseIdentifier: filterLocationCellIdentifier)
        tableView.register(TMFilterDateCell.self, forCellReuseIdentifier: filterDateCellIdentifier)
        tableView.register(TMFilterDoneCell.self, forCellReuseIdentifier: filterDoneCellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: filterLocationCellIdentifier, for: indexPath) as! TMFilterLocationCell
            cell.configure(location: sampleCurrentCity)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: filterDateCellIdentifier, for: indexPath) as! TMFilterDateCell
            cell.filterDateCellDelegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: filterDoneCellIdentifier, for: indexPath) as! TMFilterDoneCell
            cell.filterDoneCellDelegate = self
            return cell
        }
        
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row <= 1){
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
        }
    }
    
    //Button Delegates
    func didPressSetDate() {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressDoneButton() {
        self.popupController?.dismiss()
    }
    
}
