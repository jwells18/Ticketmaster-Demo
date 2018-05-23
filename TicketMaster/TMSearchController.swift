//
//  TMSearchController.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol TMSearchControllerDelegate {
    func didStartSearching()
    func didEndSearching()
    func didTapOnSearchButton()
    func didTapOnCancelButton()
    func didChangeSearchText(searchText: String)
}

class TMSearchController: UISearchController, UISearchBarDelegate{
    
    var customSearchBar: TMSearchBar!
    var customDelegate: TMSearchControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Setup Search Controller
    init(searchResultsController: UIViewController!, searchBarFrame: CGRect) {
        super.init(searchResultsController: searchResultsController)
        
        //Set SearchController Defaults
        self.dimsBackgroundDuringPresentation = false
        
        //Customize SearchBar
        configureSearchBar(frame: searchBarFrame)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Setup SearchBar
    func configureSearchBar(frame: CGRect) {
        customSearchBar = TMSearchBar(frame: frame)
        customSearchBar.translatesAutoresizingMaskIntoConstraints = false
        customSearchBar.delegate = self
    }
    
    //SearchBar Delegates
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        customDelegate.didStartSearching()
        self.customSearchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        customDelegate.didEndSearching()
        self.customSearchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
        customDelegate.didTapOnSearchButton()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
        customDelegate.didTapOnCancelButton()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        customDelegate.didChangeSearchText(searchText: searchText)
    }
    
}
