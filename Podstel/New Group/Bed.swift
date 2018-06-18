//
//  Bed.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse

class Bed: PFObject,PFSubclassing {
    @NSManaged var room: Room
    @NSManaged var price: NSNumber
    @NSManaged var currency: NSString
    @NSManaged var type: NSNumber
    
    
    static func parseClassName() -> String {
        return "Bed"
    }
}

extension PFObject {
    override open func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? PFObject {
            let eql = obj.objectId == objectId
            return eql
        }
        return super.isEqual(object)
    }
    
    open override var hash: Int {
        if let objId = objectId {
            return objId.hashValue
        }
        return super.hash
    }
}
