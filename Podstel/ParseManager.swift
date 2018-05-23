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
    }

    func login(username:String,password:String, block : @escaping SuccessBlock) {
        
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
}
