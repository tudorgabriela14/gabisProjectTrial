//
//  Booking.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse

class Booking: PFObject, PFSubclassing {
    @NSManaged var user: User
    @NSManaged var bed: Bed
    @NSManaged var startDate: NSDate
    @NSManaged var endDate: NSDate
    @NSManaged var currency: NSString
    @NSManaged var bedId: NSDate
    @NSManaged var price: NSNumber
    
    static func parseClassName() -> String {
        return "Booking"
    }
}
