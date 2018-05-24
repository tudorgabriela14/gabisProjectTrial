//
//  BookingsViewController.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import SDWebImage

class BookingsViewController: UIViewController {
    @IBOutlet weak var startDatetextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var roomsArray = [Room]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ParseManager.shared.getRooms{ (roomList, error) in
            if(error != nil) {
                //show alert
            }
            else {
                self.roomsArray = roomList
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BookingsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell") as! RoomCell
        cell.roomCoverImageView.sd_setImage(with: URL(string: (roomsArray[indexPath.row].photo1.url)!), placeholderImage: UIImage(named: "placeholder.png"))
        cell.roomNameLabel.text = roomsArray[indexPath.row].roomName as String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
