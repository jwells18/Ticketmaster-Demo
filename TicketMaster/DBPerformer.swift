//
//  DBPerformer.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/2/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import RealmSwift

class DBPerformer: Object{
    var objectId: String!
    //var createdAt: NSNumber!
    //var updatedAt: NSNumber!
    var name: String!
    var image: String!
    //var eventCount: NSNumber!
    //var popularity: NSNumber!
    
    override static func primaryKey() -> String? {
        return performerPrimaryKey
    }
}
