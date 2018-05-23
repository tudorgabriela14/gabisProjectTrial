//
//  EventDetailsController.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class EventDetailsController: AppBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var currentEvent: Event!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension EventDetailsController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! UITableViewCell
        switch indexPath.row {
        case 0: do {
            let coverCell = tableView.dequeueReusableCell(withIdentifier: "CoverImageCell") as! CoverImageCell
            coverCell.coverImageView.sd_setImage(with: URL(string: (currentEvent.eventCover?.url)!), placeholderImage: UIImage(named: "placeholder.png"))
            return coverCell
        }
        case 1: do {
            cell.detailTextLabel?.text = currentEvent.eventDescription
            return cell
            }
        case 2: do {
            let extraActionCell = tableView.dequeueReusableCell(withIdentifier: "ExtraActionCell") as! ExtraActionCell
            extraActionCell.type = "location"
            extraActionCell.delegate = self

            return extraActionCell
            }
        case 3: do {
            let extraActionCell = tableView.dequeueReusableCell(withIdentifier: "ExtraActionCell") as! ExtraActionCell
            extraActionCell.type = "calendar"
            extraActionCell.delegate = self
            return extraActionCell
            }
        case 4: do {
            let doubleActionsCell = tableView.dequeueReusableCell(withIdentifier: "DoubleActionsCell") as! DoubleActionsCell
            doubleActionsCell.event = self.currentEvent
            doubleActionsCell.delegate = self
            return doubleActionsCell
            }

        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension EventDetailsController: ExtraActionCellDelegate {
    func didPressButton(type: String) {
        if(type == "location") {
            print("show map")
        }
        else {
             print("add to calendar")
        }
    }
}

extension EventDetailsController : DoubleActionsCellDelegate {
    func didPressAttend() {
        print("attend event \(self.currentEvent.title)")
    }
    
    func didPressSeeParticipants() {
        print("see participants for event \(self.currentEvent.title)")
    }
}
