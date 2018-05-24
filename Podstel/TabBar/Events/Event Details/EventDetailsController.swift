//
//  EventDetailsController.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import MapKit
import Parse
import SVProgressHUD_0_8_1
import EventKit

class EventDetailsController: AppBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var currentEvent: Event!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventNameLabel.text = self.currentEvent.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ParticipantsController
        controller.currentEvent = currentEvent
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as! DescriptionCell
        switch indexPath.row {
        case 0: do {
            let coverCell = tableView.dequeueReusableCell(withIdentifier: "CoverImageCell") as! CoverImageCell
            coverCell.coverImageView.sd_setImage(with: URL(string: (currentEvent.eventCover?.url)!), placeholderImage: UIImage(named: "placeholder.png"))
            return coverCell
        }
        case 4: do {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as! DescriptionCell
            cell.descriptionLabel.text = currentEvent.eventDescription
            return cell
            }
        case 2: do {
            let extraActionCell = tableView.dequeueReusableCell(withIdentifier: "ExtraActionCell") as! ExtraActionCell
            extraActionCell.iconImageView.image = #imageLiteral(resourceName: "locationIc")
            extraActionCell.titleLabel.text = self.currentEvent.location
            extraActionCell.actionButton.setTitle("See on map", for: UIControlState.normal)
            extraActionCell.type = "location"
            extraActionCell.delegate = self

            return extraActionCell
            }
        case 3: do {
            let extraActionCell = tableView.dequeueReusableCell(withIdentifier: "ExtraActionCell") as! ExtraActionCell
            extraActionCell.iconImageView.image = #imageLiteral(resourceName: "dateIc")
            extraActionCell.titleLabel.text = self.getDate()
            extraActionCell.actionButton.setTitle("Add to calendar", for: UIControlState.normal)
            extraActionCell.type = "calendar"
            extraActionCell.delegate = self
            return extraActionCell
            }
        case 1: do {
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
            let coords = self.currentEvent.eventLocation
            let url = "http://maps.apple.com/maps?q=\(coords.latitude),\(coords.longitude)"
            UIApplication.shared.open(URL(string:url)!, options: [:], completionHandler: nil)
            
        }
        else {
             print("add to calendar")
            self.addEventToCalendar(title: self.currentEvent.title, description: "", startDate: self.currentEvent.date!, endDate: self.currentEvent.date!)
        }
    }
    
    func getDate() -> (String) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd MMM yyyy HH:mm:ss"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy HH:mm"
        
        return dateFormatter.string(from: self.currentEvent.date!)
    }
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    self.simpleAlert(title: "Attention", message: "The event couldn't be added in the calendar. Please try again.")
                    return
                }
                completion?(true,nil)
                self.simpleAlert(title: "Success", message:"\(self.currentEvent.title) event has been added in the calendar!" )

            } else {
                completion?(false, error as NSError?)
                self.simpleAlert(title: "Attention", message: "The event couldn't be added in the calendar. Please try again.")
            }
        })
    }
}

extension EventDetailsController : DoubleActionsCellDelegate  {
    func didPressAttend() {
        self.canAttend()
    }
    
    func didPressSeeParticipants() {
        print("see participants - handled in storyBoard")
    }
    
    func canAttend() {
        SVProgressHUD.show()
        var participants = [User]()
        ParseManager.shared.getParticipantsForEvent(event: self.currentEvent) { (usersArray, error) in
            if(error == nil) {
                participants = usersArray
                let currentUser = PFUser.current() as! User
                if(participants.contains(currentUser)) {
                    SVProgressHUD.dismiss()
                     self.simpleAlert(title: "Attention".localized(), message: "You already have attended this event!".localized())
                }
                else {
                    [ParseManager.shared.attendEvent(event: self.currentEvent, block: { (success, error) in
                        SVProgressHUD.dismiss()
                        if(success) {
                            self.simpleAlert(title: "Success".localized(), message: "You are registered!".localized())
                        }
                    })];
                }
            }
        }
        
    }
}
