//
//  AppDelegate.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Setup Firebase
        FirebaseApp.configure()
        
        //Set Current Location by City (current location not implemented for demo)
        UserDefaults.standard.set(sampleCurrentCity, forKey: "currentCity")
        UserDefaults.standard.synchronize()
        
        // User is signed in.
        self.setAppControllers(viewController: self.setupAppControllers())
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setupAppControllers() -> UIViewController{
        //Setup NavigationControllers for each tab
        let homeVC = HomeController()
        homeVC.tabBarItem = UITabBarItem(title: "homeTabTitle".localized(), image: UIImage(named: "home"), selectedImage: UIImage(named: "homeFilled"))
        let navVC1 = NavigationController.init(rootViewController: homeVC)
        
        let searchVC = SearchController()
        searchVC.tabBarItem = UITabBarItem(title: "searchTabTitle".localized(), image: UIImage(named: "search"), selectedImage: UIImage(named: "searchFilled"))
        let navVC2 = NavigationController.init(rootViewController: searchVC)
        
        let ticketsVC = TicketsController()
        ticketsVC.tabBarItem = UITabBarItem(title: "ticketsTabTitle".localized(), image: UIImage(named: "ticket"), selectedImage: UIImage(named: "ticketFilled"))
        let navVC3 = NavigationController.init(rootViewController: ticketsVC)
        
        let favoritesVC = FavoritesController()
        favoritesVC.tabBarItem = UITabBarItem(title: "favoritesTabTitle".localized(), image: UIImage(named: "favorites"), selectedImage: UIImage(named: "favoritesFilled"))
        let navVC4 = NavigationController.init(rootViewController: favoritesVC)
        
        let accountVC = AccountController()
        accountVC.tabBarItem = UITabBarItem(title: "accountTabTitle".localized(), image: UIImage(named: "account"), selectedImage: UIImage(named: "accountFilled"))
        let navVC5 = NavigationController.init(rootViewController: accountVC)
        
        //Setup TabBarController
        let tabVC = TabBarController()
        tabVC.viewControllers = [navVC1, navVC2, navVC3, navVC4, navVC5]
        
        return tabVC
    }
    
    func setAppControllers(viewController: UIViewController){
        //Set TabBarController as Window
        window?.rootViewController = viewController
    }
}

