//
//  Article.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse

class Article: PFObject, PFSubclassing {
    
    @NSManaged var title: String
    @NSManaged var articleBody : String
    @NSManaged var coverImage: PFFile?
    
    static func parseClassName() -> String {
        return "Article"
    }

}
