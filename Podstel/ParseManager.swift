//
//  ParseManager.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse

typealias SuccessBlock = (Bool, Error?)-> Void
typealias ArrayBlock<T> = ((Array<T>,Error?)->Void)
typealias ItemBlock<T> = ((T?,Error?)->Void)

class ParseManager {
    static let shared = ParseManager()
    
    func registerObjects(){
        Article.registerSubclass()
        Event.registerSubclass()
        User.registerSubclass()
        Bed.registerSubclass()
        Room.registerSubclass()
        Booking.registerSubclass()
        Participation.registerSubclass()
        
    }


    
    func getArticles(block: @escaping ArrayBlock<Article>) {
        let query = Article.query()
        query?.findObjectsInBackground(block: { (result, error) in
            block(result as! [Article], error)
        })
    }
    
    func getEvents(block: @escaping ArrayBlock<Event>) {
        let query = Event.query()
        query?.findObjectsInBackground(block: { (result, error) in
            block(result as! [Event], error)
        })
    }
    
    func attendEvent(event: Event,block: @escaping SuccessBlock) {
        let relation = event.relation(forKey: "usersGoing")
        relation.add(PFUser.current()!)
        event.saveInBackground(block:block)
        
        let participationObj = Participation()
        participationObj.event = event
        participationObj.participant = PFUser.current() as! User
        participationObj.saveInBackground(block: block)
    }
    
    func getParticipantsForEvent(event: Event, block:  @escaping ArrayBlock<User> ) {
        
        let relation = event.relation(forKey: "usersGoing")
        relation.query().findObjectsInBackground { (result, error) in
            block(result as! [User],error)
        }
    }
    
    func getMyEvents(block:  @escaping ArrayBlock<Event>) {
        let queryEvents = Participation.query()
        queryEvents?.includeKey("participant")
        queryEvents?.includeKey("event")
        queryEvents?.whereKey("participant", equalTo: PFUser.current()!)
        queryEvents?.findObjectsInBackground(block: { (objects, error) in
            var eventsArray = [Event] ()
            for obj in objects! {
                eventsArray.append((obj as! Participation).event)
            }
            block(eventsArray, error)
        })
    }
    
    func getRooms(block:  @escaping ArrayBlock<Room>) {
        let query = Room.query()
        query?.findObjectsInBackground(block: { (result, error) in
            block(result as! [Room], error)
        })
    }
    
    
    func getAvailableBeds(checkInDate:Date, checkOutDate:Date, block: @escaping ArrayBlock<Bed>) {
        let query1 = Booking.query()
        query1?.whereKey("startDate", lessThanOrEqualTo: checkInDate)
        query1?.whereKey("endDate", greaterThan: checkInDate)
        
        let query2 = Booking.query()
        query2?.whereKey("startDate", lessThanOrEqualTo: checkOutDate)
        query2?.whereKey("endDate", greaterThan: checkOutDate)
        
        let query3 = Booking.query()
        query3?.whereKey("startDate", greaterThanOrEqualTo: checkInDate)
        query3?.whereKey("endDate", lessThan: checkOutDate)
        
        let totalQuery = PFQuery.orQuery(withSubqueries: [query1!, query2!, query3!]);
        
        let finalQuery = Bed.query()
        finalQuery?.includeKey("room")
        finalQuery?.whereKey("objectId", doesNotMatchKey: "bedId", in: totalQuery)
        finalQuery?.findObjectsInBackground(block: { (objects, error) in
            if(objects != nil) {
                block(objects as! [Bed], error)
                return
            }
            block([], error)
        })
    }
    
    //get rooms for each bed available
    func getRoomsForBeds(availableBedsArray : [Bed]) -> [Room] {
    
        var availableRoomsArray = [Room]()
        
        for bed in availableBedsArray {
            if(!availableRoomsArray.contains(bed.room)) {
                availableRoomsArray.append(bed.room)
            }
        }
        
        return availableRoomsArray
    }
    
}
