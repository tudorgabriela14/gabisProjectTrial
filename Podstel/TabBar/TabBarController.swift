//
//  TabBarController.swift
//  Podstel
//
//  Created by Gabriela on 22/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let articlesNavigation = storyBoard.instantiateViewController(withIdentifier: "articlesNavigation") as! UINavigationController
        let eventsNavigation = storyBoard.instantiateViewController(withIdentifier: "eventsNavigation") as! UINavigationController
        let bookingsNavigation = storyBoard.instantiateViewController(withIdentifier: "bookingsNavigation") as! UINavigationController
        let profileNavigation = storyBoard.instantiateViewController(withIdentifier: "profileNavigation") as! UINavigationController
        
    
        
        articlesNavigation.tabBarItem = UITabBarItem(title: "Articles", image: #imageLiteral(resourceName: "articlesIcon").tintImage(fillColor: UIColor.lightGray), selectedImage: #imageLiteral(resourceName: "articlesIcon").tintImage(fillColor: UIColor.white))
        eventsNavigation.tabBarItem = UITabBarItem(title: "Events", image: #imageLiteral(resourceName: "eventsIcon").tintImage(fillColor: UIColor.lightGray), selectedImage: #imageLiteral(resourceName: "eventsIcon").tintImage(fillColor: UIColor.white))
        bookingsNavigation.tabBarItem = UITabBarItem(title: "Bookings", image: #imageLiteral(resourceName: "bookingsIcon").tintImage(fillColor: UIColor.lightGray), selectedImage: #imageLiteral(resourceName: "bookingsIcon").tintImage(fillColor: UIColor.white))
        profileNavigation.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "profilIcon").tintImage(fillColor: UIColor.lightGray), selectedImage: #imageLiteral(resourceName: "profilIcon").tintImage(fillColor: UIColor.white))
        
        let controllers = [articlesNavigation, eventsNavigation, bookingsNavigation, profileNavigation]
        self.viewControllers = controllers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
