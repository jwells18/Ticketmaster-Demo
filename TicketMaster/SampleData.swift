//
//  SampleData.swift
//  TicketMaster
//
//  Created by Justin Wells on 4/25/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

func createSampleUser() -> User{
    let user = User()
    user.objectId = "a1b2c3d4c5"
    user.name = "Sarah"
    
    return user
}

func createSampleEvent() -> Event{
    let sampleEvent = Event()
    sampleEvent.objectId = "aabbccdd"
    //sampleEvent.createdAt = Double()
    //sampleEvent.updatedAt = Double()
    sampleEvent.name = "Arizona Diamondbacks at Los Angeles Dodgers"
    //sampleEvent.startDateTime = "7:10pm"
    sampleEvent.city = "Los Angeles"
    sampleEvent.stateCode = "CA"
    sampleEvent.dmaId = "324" //Designated Markert Area for Los Angeles
    sampleEvent.venue = "Dodger Stadium"
    sampleEvent.ticketsLeft = 8331
    sampleEvent.lowestPrice = 22.0

    return sampleEvent
}

func createSampleEvents() -> [Event]{
    
    var sampleEvents = [Event]()
    
    while sampleEvents.count < 10{
        sampleEvents.append(createSampleEvent())
    }
    
    return sampleEvents
}

func createSampleTicket() -> Ticket{
    let sampleTicket = Ticket()
    sampleTicket.objectId = "aabbccddee"
    //sampleTicket.createdAt: NSNumber!
    //sampleTicket.updatedAt: NSNumber!
    sampleTicket.section = "Sec 429, Row 5"
    sampleTicket.price = 79.50
    sampleTicket.dealScore = 8.5
    
    return sampleTicket
}

func createSampleTickets() -> [Ticket]{
    
    var sampleTickets = [Ticket]()
    
    while sampleTickets.count < 10{
        sampleTickets.append(createSampleTicket())
    }
    
    return sampleTickets
    
}

func uploadSampleEvents(){
    //Event Data Array
    var eventDataArray = [Dictionary<String, Any>]()
    
    //Create Sample Event Data
    let ref = Database.database().reference()
    for i in stride(from: 0, to: sampleEventNames.count-1, by: 1) {
        var eventData = Dictionary<String, Any>()
        eventData["objectId"] = ref.childByAutoId().key
        eventData["createdAt"] = ServerValue.timestamp()
        eventData["updatedAt"] = ServerValue.timestamp()
        eventData["name"] = sampleEventNames[i]
        eventData["city"] = sampleEventCities[i]
        eventData["stateCode"] = "CA"
        eventData["venue"] = sampleEventVenues[i]
        eventData["ticketsLeft"] = sampleEventTicketsLeft[i]
        eventData["lowestPrice"] = sampleEventLowestPrice[i]
        eventData["dmaId"] = "324" //Designated Market Area for Los Angeles
        eventData["type"] = sampleEventTypes[i]
        eventData["startDateTime"] = createDate(string: sampleEventStartDateTimes[i]).timestamp()
        //eventData["endDateTime"] = createDate(string: sampleEventEndDateTimes[i]).timestamp()

        eventDataArray.append(eventData)
    }
    
    //Upload Event to Category Database
    for eventData in eventDataArray{
        ref.child(eventDatabase).child(eventData["objectId"] as! String).setValue(eventData) { (error:Error?, DatabaseReference) in
            if((error) != nil){
                print("Error uploading event")
            }
        }
    }
}

//Sample Event Raw Data
let sampleEventNames = ["Taylor Swift with Camila Cabello and Charli XCX", "Tampa Bay Rays at Los Angeles Angeles (Han Solo Monkey)", "Colorado Rockies at Los Angeles Dodgers", "RuPaul's DragCon Pageant", "Jo Key (21+ Event)", "Visalia Rawhide at Rancho Cucamonga Quakes", "Houston Astroes at Los Angeles Angels", "Her", "Itzhak Perlman and Rohan De Silva (Reschedules from March 14)", "Pedro the Lion", "Franz Ferdinand", "Zoe", "Houston Astros at Los Angeles Angels", "Andrew McMahon", "Hamilton Costa Mesa", "School Of Rock Los Angeles", "U2", "Trouble", "Block Party Los Angeles", "Soft Power Los Angles"]
let sampleEventCities = ["Pasadena", "Anaheim", "Los Angeles", "Los Angeles", "Ontario", "Rancho Cucamonga", "Anaheim", "Los Angeles", "Los Angeles", "Los Angeles", "Los Angeles", "Anaheim", "Anaheim", "Hollywood", "Costa Mesa", "Los Angeles", "Inglewood", "Los Angeles", "Culver City", "Los Angeles"]
let sampleEventVenues = ["Rose Bowl", "Angel Stadium", "Dodger Stadium", "Orpheum Theatre Los Angeles", "Ontario Improv Comedy Club", "Rancho Cucamonga Epicenter", "Angel Stadium", "Moroccan Lounge", "Walt Disney Concert Hall", "Teragram Ballroom", "Wiltern Theatre", "House of Blues Anaheim", "Angel Stadium", "John Anson Ford Theatre", "Segerstrom Center for the Arts Segerstrom Hall", "Pantages Theatre Los Angeles", "The Forum Los Angeles", "Roxy Theatre Los Angeles", "Kirk Douglas Theatre", "Ahmanson Theater"]
let sampleEventTicketsLeft = [4224, 4244, 9939, 6, 7, 6, 5274, 15, 49, 10, 99, 47, 5001, 173, 101, 239, 1112, 22, 11, 75]
let sampleEventLowestPrice = [44, 12, 6, 50, 82, 40, 6, 40, 88, 37, 37, 77, 6, 25, 167, 53, 63, 36, 55, 65]
let sampleEventTypes = ["concert", "sports", "sports", "theaterAndComedy", "theaterAndComedy", "sports", "sports", "concert", "concert", "concert", "concert", "concert", "sports", "concert", "theaterAndComedy", "concert", "concert", "concert", "concert", "theaterAndComedy"]
let sampleEventStartDateTimes = ["2018/05/18 19:00", "2018/05/08 19:07", "2018/05/21 19:10", "2018/05/13 21:00", "2018/05/13 21:30", "2018/05/14 00:59", "2018/05/14 19:07", "2018/05/14 19:30", "2018/05/14 20:00", "2018/05/15 19:00", "2018/05/15 19:00", "2018/05/15 19:07", "2018/05/15 19:30", "2018/05/15 19:30", "2018/05/15 20:00", "2018/05/15 20:00", "2018/05/15 20:00", "2018/05/15 20:00", "2018/05/15 20:30"]





