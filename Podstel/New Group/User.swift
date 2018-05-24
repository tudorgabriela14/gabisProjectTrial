//
//  User.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse

class User: PFUser {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var avatar: PFFile
    @NSManaged var country: String
    
    override var parseClassName: String {
        return super.parseClassName
    }

}
