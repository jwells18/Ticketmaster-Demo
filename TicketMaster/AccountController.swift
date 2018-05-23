//
//  AccountController.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class AccountController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Title
        self.navigationItem.title = "accountTabTitle".localized()
    }
    
    func setupView(){
        //Set Background Color
        self.view.backgroundColor = TMColor.faintGray
        
        //Set Hire Me Label
        self.view = createHireMeBackgroundView()
    }
}
