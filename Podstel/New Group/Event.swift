//
//  Event.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse

class Event: PFObject, PFSubclassing {
    @NSManaged var title: String
    @NSManaged var eventDescription : String
    @NSManaged var eventCover: PFFile?
    @NSManaged var date: Date?
    @NSManaged var paid: Bool
    @NSManaged var usersGoing: PFRelation<User>
    
    @NSManaged var location:String
    @NSManaged var eventLocation:PFGeoPoint
    
    static func parseClassName() -> String {
        return "Event"
    }
}

extension PFGeoPoint {
    
    var location:CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}
