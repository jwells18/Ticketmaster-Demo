//
//  TMFilterToolbar.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol FilterToolbarDelegate {
    func didPressQuantityButton()
    func didPressPriceButton()
    func didPressTypeButton()
    func didChangeAccessibleSwitch(bool: Bool)
    func didPressResetButton()
}

class TMFilterToolbar: UIToolbar{
    
    var filterToolbarDelegate: FilterToolbarDelegate!
    var quantityButtonItem = UIBarButtonItem()
    var priceButtonItem = UIBarButtonItem()
    var typeButtonItem = UIBarButtonItem()
    var typeAccessibleView: TMFilterSwitchToolbarItem!
    var accessibleButtonItem = UIBarButtonItem()
    var resetButtonItem = UIBarButtonItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.barTintColor = .white
        
        //Setup Quantity ButtonItem
        self.setupQuantityItem()
        
        //Setup Price ButtonItem
        self.setupPriceItem()
        
        //Setup Type ButtonItem
        self.setupTypeItem()
        
        //Setup AccessibleItem
        self.setupAccessibleItem()
        
        //Setup Reset ButtonItem
        self.setupResetItem()
        
        //Set Toolbar Itmes
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarItems = [flexibleSpace, flexibleSpace, quantityButtonItem, priceButtonItem, typeButtonItem, accessibleButtonItem, resetButtonItem, flexibleSpace, flexibleSpace]
        self.items = toolbarItems
    }
    
    func setupQuantityItem(){
        let quantityCustomView = TMFilterDefaultToolbarItem(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        quantityCustomView.button.setTitle("2", for: .normal)
        quantityCustomView.button.addTarget(self, action: #selector(self.quantityButtonPressed), for: .touchUpInside)
        quantityCustomView.textLabel.text = "qty".localized()
        quantityButtonItem = UIBarButtonItem(customView: quantityCustomView)
    }
    
    func setupPriceItem(){
        let priceCustomView = TMFilterDefaultToolbarItem(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        priceCustomView.button.setTitle("$", for: .normal)
        priceCustomView.button.addTarget(self, action: #selector(self.priceButtonPressed), for: .touchUpInside)
        priceCustomView.textLabel.text = "price".localized()
        priceButtonItem = UIBarButtonItem(customView: priceCustomView)
    }
    
    func setupTypeItem(){
        let typeCustomView = TMFilterDefaultToolbarItem(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        typeCustomView.button.setImage(UIImage(named: "ticket")!.withRenderingMode(.alwaysTemplate), for: .normal)
        typeCustomView.button.addTarget(self, action: #selector(self.typeButtonPressed), for: .touchUpInside)
        typeCustomView.textLabel.text = "type".localized()
        typeButtonItem = UIBarButtonItem(customView: typeCustomView)
    }
    
    func setupAccessibleItem(){
        typeAccessibleView = TMFilterSwitchToolbarItem(frame: CGRect(x: 0, y: 0, width: 70, height: 50))
        typeAccessibleView.switchButton.addTarget(self, action: #selector(accessibleSwitchValueChanged), for: .valueChanged)
        typeAccessibleView.textLabel.text = "accessible".localized()
        accessibleButtonItem = UIBarButtonItem(customView: typeAccessibleView)
    }
    
    func setupResetItem(){
        let resetCustomView = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        resetCustomView.setTitleColor(TMColor.primary, for: .normal)
        resetCustomView.setTitle("reset".localized().uppercased(), for: .normal)
        resetCustomView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        resetCustomView.layer.cornerRadius = 5
        resetCustomView.layer.borderColor = TMColor.primary.cgColor
        resetCustomView.layer.borderWidth = 1
        resetCustomView.addTarget(self, action: #selector(self.resetButtonPressed), for: .touchUpInside)
        resetButtonItem = UIBarButtonItem(customView: resetCustomView)
    }
    
    //Button Delegate
    func quantityButtonPressed(){
        filterToolbarDelegate.didPressQuantityButton()
    }
    
    func priceButtonPressed(){
        filterToolbarDelegate.didPressPriceButton()
    }
    
    func typeButtonPressed(){
        filterToolbarDelegate.didPressTypeButton()
    }
    
    func accessibleSwitchValueChanged(){
        filterToolbarDelegate.didChangeAccessibleSwitch(bool: typeAccessibleView.switchButton.isOn)
    }
    
    func resetButtonPressed(){
        filterToolbarDelegate.didPressResetButton()
    }
}
