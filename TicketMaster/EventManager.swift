//
//  EventManager.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/3/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class EventManager: NSObject{
    
    var ref: DatabaseReference!
    
    func downloadEvents(dmaId: String, completionHandler:@escaping ([Event]?) -> Void){
        var events = [Event]()
        ref = Database.database().reference().child(eventDatabase)
        let query: DatabaseQuery = ref.queryOrdered(byChild: "dmaId").queryEqual(toValue: dmaId).queryLimited(toFirst: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(events)
                return
            }
            
            for child in snapshot.children{
                //Create Peformer
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! NSDictionary
                let event = self.createEvent(rawData: rawData)
                events.append(event)
            }
            
            completionHandler(events)
        })
    }
    
    func downloadEvents(type: String, completionHandler:@escaping ([Event]?) -> Void){
        var events = [Event]()
        ref = Database.database().reference().child(eventDatabase)
        let query: DatabaseQuery = ref.queryOrdered(byChild: "type").queryEqual(toValue: type).queryLimited(toFirst: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(events)
                return
            }
            
            for child in snapshot.children{
                //Create Event
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! NSDictionary
                let event = self.createEvent(rawData: rawData)
                events.append(event)
            }
            
            completionHandler(events)
        })
    }
    
    func downloadEvents(startDate: Double?, endDate: Double?, completionHandler:@escaping ([Event]?) -> Void){
        var events = [Event]()
        ref = Database.database().reference().child(eventDatabase)
        let query: DatabaseQuery = ref.queryOrdered(byChild: "startDateTime").queryStarting(atValue: startDate).queryEnding(atValue: endDate).queryLimited(toFirst: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(events)
                return
            }
            
            for child in snapshot.children{
                //Create Event
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! NSDictionary
                let event = self.createEvent(rawData: rawData)
                events.append(event)
            }
            
            completionHandler(events)
        })
    }
    
    func createEvent(rawData: NSDictionary?) -> Event{
        let event = Event()
        event.objectId = rawData?.object(forKey: "objectId") as! String!
        event.createdAt = rawData?.object(forKey: "createdAt") as! NSNumber!
        event.updatedAt = rawData?.object(forKey: "updatedAt") as! NSNumber!
        event.name = rawData?.object(forKey: "name") as! String!
        event.image = rawData?.object(forKey: "image") as! String!
        event.city = rawData?.object(forKey: "city") as! String!
        event.stateCode = rawData?.object(forKey: "stateCode") as! String!
        event.venue = rawData?.object(forKey: "venue") as! String!
        event.ticketsLeft = rawData?.object(forKey: "ticketsLeft") as! NSNumber!
        event.lowestPrice = rawData?.object(forKey: "lowestPrice") as! NSNumber!
        event.startDateTime = rawData?.object(forKey: "startDateTime") as! NSNumber!
        let eventType = rawData?.object(forKey: "type") as! String!
        event.type = EventType(rawValue: eventType!)
        
        return event
    }
}
