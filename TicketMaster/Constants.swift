//
//  Constants.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import MapKit

//View Dimensions
let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let w = screenSize.width
let h = screenSize.height

//UIObject Dimensions
let navigationHeight: CGFloat = 44.0
let statusBarHeight: CGFloat = 20.0
let navigationHeaderAndStatusbarHeight : CGFloat = navigationHeight + statusBarHeight
let tabBarHeight: CGFloat = 49.0
let searchBarFontSize = CGFloat(16)
let eventCategoryTableCellHeight: CGFloat = 65.0

//Custom Colors
struct TMColor{
    static let primary = UIColorFromRGB(0x009CDE)
    static let secondary = UIColorFromRGB(0xD0006F)
    static let tertiary = UIColorFromRGB(0x5856D6)
    static let facebookBlue = UIColorFromRGB(0x3B5998)
    static let faintGray = UIColor(white: 0.95, alpha: 1)
}

public func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//Database
var eventDatabase = "Event"
var eventPrimaryKey = "objectId"
var performerDatabase = "Performer"
var performerPrimaryKey = "objectId"
var venueDatabase = "Venue"
var venuePrimaryKey = "objectId"
var paginationLimit = UInt(30)
var paginationUpperLimit = 150

//Sample Data
let currentUser = createSampleUser()
let sampleCurrentLocation = CLLocation(latitude: 34.053718, longitude: -118.2448473)
let sampleCurrentCity = "Los Angeles"
let sampleCurrentStateCode = "CA"

//Arrays
let eventNavigationCategories = ["happeningToday", "concert", "sports", "theaterAndComedy", "venues"]
let eventNavigationCategoriesIcon = [UIImage(named: "happeningToday"), UIImage(named: "concerts"), UIImage(named: "sports"), UIImage(named: "theater&comedy"), UIImage(named: "venues")]
let favoritesSegmentedTitles = ["performers".localized(), "events".localized(), "venues".localized()]
let searchSectionHeaderTitles = ["", "concert", "nearby", "sports", "recentlyViewed", "theaterAndComedy"]
let musicSourceTitles = ["appleMusic", "spotify", "facebook"]
let musicSourceImages = [UIImage(named: "appleMusic"), UIImage(named: "spotify"), UIImage(named: "facebook")]
let ticketFilterTitles = ["lowestPrice".localized(), "bestSeats".localized()]

//HireMe Label
func createHireMeBackgroundView() -> UIView{
    let hireMeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: h-navigationHeaderAndStatusbarHeight-tabBarHeight))
    hireMeLabel.text = "Hire me to make more cool stuff \u{1F60E}"
    hireMeLabel.textColor = .lightGray
    hireMeLabel.backgroundColor = TMColor.faintGray
    hireMeLabel.textAlignment = .center
    hireMeLabel.font = UIFont.boldSystemFont(ofSize: 30)
    hireMeLabel.numberOfLines = 0
    
    return hireMeLabel
}

//Feature Not Available
public func featureUnavailableAlert() -> UIAlertController{
    //Show Alert that this feature is not available
    let alert = UIAlertController(title: NSLocalizedString("Sorry", comment:""), message: NSLocalizedString("This feature is not available yet.", comment:""), preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alert
}

//Other Functions
public func createDate(string: String) -> Date{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let date = formatter.date(from: string)
    return date!
}

extension NSNumber{
    func dateValue() -> Date {
        let timeInterval: TimeInterval = self.doubleValue
        let date = Date.init(timeIntervalSince1970: timeInterval/1000)
        
        return date
    }
}

extension Date {
    func monthAndDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: self).capitalized
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self).capitalized
    }
    
    func timeLong() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self).capitalized.lowercased()
    }
    
    func startOfDay() -> Date {
        return NSCalendar.current.startOfDay(for: self)
    }
    
    func endOfDay() -> Date {
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        return NSCalendar.current.date(byAdding: components as DateComponents, to: self.startOfDay())!
    }
    
    func timestamp() -> Double{
        let timestamp = self.timeIntervalSince1970*1000
        return Double(timestamp)
    }
}

