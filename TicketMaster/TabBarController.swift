//
//  TabBarController.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        self.delegate = self
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = TMColor.primary
    }
}
