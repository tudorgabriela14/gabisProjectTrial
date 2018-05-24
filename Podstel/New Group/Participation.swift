//
//  Participation.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse

class Participation: PFObject, PFSubclassing {
    @NSManaged var participant: User
    @NSManaged var event: Event

    static func parseClassName() -> String {
        return "Participation"
    }
}
