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
    @NSManaged var usersGoing: PFFile?
    @NSManaged var paid: Bool
    
    static func parseClassName() -> String {
        return "Event"
    }
}
