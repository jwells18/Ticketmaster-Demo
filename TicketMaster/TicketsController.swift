//
//  TicketsController.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TicketsController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Title
        self.navigationItem.title = "ticketsTabTitle".localized()
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup Tickets EmptyView
        self.setupEmptyView()
    }
    
    func setupEmptyView(){
        let ticketsEmptyView = TicketsEmptyView()
        ticketsEmptyView.emptyButton.addTarget(self, action: #selector(emptyButtonPressed), for: .touchUpInside)
        self.view = ticketsEmptyView
    }
    
    //Button Delegates
    func emptyButtonPressed(){
        self.tabBarController?.selectedIndex = 1
    }
}
