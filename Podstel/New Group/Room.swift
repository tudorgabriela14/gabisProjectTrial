//
//  Room.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse

class Room: PFObject, PFSubclassing {
    @NSManaged var nbBeds: NSNumber
    @NSManaged var privateBathroom: Bool
    @NSManaged var photo1: PFFile
    @NSManaged var photo2: PFFile
    @NSManaged var photo3: PFFile
    @NSManaged var roomName: NSString
    @NSManaged var roomSize: NSNumber
//    @NSManaged var description: NSString
    
    static func parseClassName() -> String {
        return "Room"
    }
    
    override open func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Room {
            if(object.objectId == self.objectId) {
                return true
            }
        }
        return false
    }

}
