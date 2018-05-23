//
//  PerfomerManager.swift
//  TicketMaster
//
//  Created by Justin Wells on 5/2/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import RealmSwift

class FavoritesManager: NSObject{
    
    var ref: DatabaseReference!
    
    func loadFavorites(user: User, completionHandler:@escaping (Results<DBPerformer>?, Results<DBEvent>?, Results<DBVenue>?) -> Void){
        //Load Favorites from Realm
        let realm = try! Realm()
        let dbPerformers = realm.objects(DBPerformer.self)//.sorted(byKeyPath: "updatedAt", ascending: false)
        let dbEvents = realm.objects(DBEvent.self)//.sorted(byKeyPath: "updatedAt", ascending: false)
        let dbVenues = realm.objects(DBVenue.self)//.sorted(byKeyPath: "updatedAt", ascending: false)
        completionHandler(dbPerformers, dbEvents, dbVenues)
    }
    
    func downloadPerformers(completionHandler:@escaping ([Performer]?) -> Void){
        var performers = [Performer]()
        ref = Database.database().reference().child(performerDatabase)
        let query: DatabaseQuery = ref.queryOrdered(byChild: "popularity").queryLimited(toFirst: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(performers)
                return
            }
            
            for child in snapshot.children{
                //Create Peformer
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! NSDictionary
                let performer = self.createPerformer(rawData: rawData)
                performers.append(performer)
            }
            
            completionHandler(performers)
        })
    }
    
    func createPerformer(rawData: NSDictionary?) -> Performer{
        let performer = Performer()
        performer.objectId = rawData?.object(forKey: "objectId") as! String!
        performer.createdAt = rawData?.object(forKey: "createdAt") as! NSNumber!
        performer.updatedAt = rawData?.object(forKey: "updatedAt") as! NSNumber!
        performer.name = rawData?.object(forKey: "name") as! String!
        performer.image = rawData?.object(forKey: "image") as! String!
        performer.eventCount = rawData?.object(forKey: "eventCount") as! NSNumber!
        performer.popularity = rawData?.object(forKey: "popularity") as! NSNumber!
        
        return performer
    }
    
}
