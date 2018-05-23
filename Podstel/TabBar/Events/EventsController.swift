//
//  EventsController.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class EventsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var eventsArray = [Event]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ParseManager.shared.getEvents { (eventsList, error) in
            if(error != nil) {
                //show alert
            }
            else {
                self.eventsArray = eventsList
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    
    extension EventsController : UITableViewDelegate, UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return eventsArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let eventCell = self.tableView.dequeueReusableCell(withIdentifier: "eventCell") as! ArticleCell
            eventCell.nameLabel.text = eventsArray[indexPath.row].title
            //        articleCell.coverImageView.image =
            eventCell.coverImageView.sd_setImage(with: URL(string: (eventsArray[indexPath.row].eventCover?.url)!), placeholderImage: UIImage(named: "placeholder.png"))
            eventCell.index = indexPath.row
            return eventCell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let controller = segue.destination as! EventDetailsController
            controller.currentEvent = eventsArray[(sender as! ArticleCell).index]
        }
    }
