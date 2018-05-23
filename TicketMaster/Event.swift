//
//  Event.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class Event: NSObject{
    var objectId: String!
    var createdAt: NSNumber!
    var updatedAt: NSNumber!
    var name: String!
    var image: String!
    var venue: String!
    var dmaId: String! //Designated Marker Area ID
    var type: EventType!
    var city: String!
    var stateCode: String!
    var startDateTime: NSNumber!
    var endDateTime: NSNumber!
    var latitude: NSNumber!
    var longitude: NSNumber!
    var ticketsLeft: NSNumber!
    var lowestPrice: NSNumber!
    var highestPrice: NSNumber!
}

public enum EventType: String{
    case concert = "concert"
    case sports = "sports"
    case theaterAndComedy = "theaterAndComedy"
}
