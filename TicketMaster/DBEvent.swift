//
//  DBEvent.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/2/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import RealmSwift

class DBEvent: Object{
    dynamic var objectId: String!
    //dynamic var createdAt: NSNumber!
    //dynamic var updatedAt: NSNumber!
    dynamic var name: String!
    dynamic var image: String!
    //dynamic var startDateTime: NSNumber!
    //dynamic var endDateTime: NSNumber!
    //dynamic var latitude: NSNumber!
    //dynamic var longitude: NSNumber!
    dynamic var venue: String!
    //dynamic var ticketsLeft: NSNumber!
    //dynamic var lowestPrice: NSNumber!
    //dynamic var highestPrice: NSNumber!
    
    override static func primaryKey() -> String? {
        return eventPrimaryKey
    }
}
