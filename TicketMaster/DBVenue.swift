//
//  DBVenue.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/2/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import RealmSwift

class DBVenue: Object{
    var objectId: String!
    var name: String!
    //var latitude: NSNumber!
    //var longitude: NSNumber!
    //var eventCount: NSNumber!
    
    override static func primaryKey() -> String? {
        return venuePrimaryKey
    }
}
