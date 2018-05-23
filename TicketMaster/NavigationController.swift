//
//  NavigationController.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController{
    
    override func viewDidLoad() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .white
        self.navigationBar.tintColor = TMColor.primary
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.darkGray]
        self.navigationBar.backgroundColor = .white
    }
}
