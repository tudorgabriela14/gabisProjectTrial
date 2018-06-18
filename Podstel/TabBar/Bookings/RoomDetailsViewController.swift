//
//  RoomDetailsViewController.swift
//  Podstel
//
//  Created by Gabriela on 18/06/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD_0_8_1

class RoomDetailsViewController: UIViewController {
    var selectedRoom : Room!
    
    @IBOutlet weak var roomCoverImage: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nbNightsLabel: UILabel!
    @IBOutlet weak var nbBedsLeft: UILabel!
    
    var startDate: Date?
    var endDate: Date?
    var nbNights : Int! = 0
    var price:Int! = 0
    
    var bedsForRoom = [Bed]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.roomNameLabel.text = self.selectedRoom.roomName as String
         self.roomCoverImage.sd_setImage(with: URL(string: (self.selectedRoom.photo1.url)!), placeholderImage: UIImage(named: "placeholder.png"))
        
        calculateNbNights()
        calculatePrice()
        if(nbNights == 1) {
            self.nbNightsLabel.text = "\(nbNights!) night"
        }
        else {
            self.nbNightsLabel.text = "\(nbNights!) nights"
        }
        
        self.nbBedsLeft.text = "\(bedsForRoom.count) beds left"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTouchBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookBed(_ sender: Any) {
        
        self.showOneActionAlert(title: "Book bed", description: "Are you sure you want to make this purchase and book this bed? You are going to pay \(self.priceLabel.text!) for this reservation.", actionTitle: "Reserve") { (completion) in
            let newBooking = Booking()
            newBooking.bed = self.bedsForRoom.first!
            newBooking.startDate = self.startDate! as NSDate
            newBooking.endDate = self.endDate! as NSDate
            newBooking.bedId = self.bedsForRoom.first?.objectId! as! NSString
            newBooking.user = PFUser.current() as! User
            newBooking.price = self.price as! NSNumber
            
            SVProgressHUD.show()
            newBooking.saveInBackground { (succedeed, error) in
                SVProgressHUD.dismiss()
                if ((error) != nil) {
                    self.showAlert(title: "Attention", description: "Something happened and the reservation couldn't be completed.")
                }
                else {
                    self.showAlert(title: "Success", description: "Your reservation has been completed. Thank you!")
                }
            }
        }
        
    }
    
    func calculatePrice() {
        let bed = self.bedsForRoom.first
        self.price = Int(exactly: (bed?.price.doubleValue)!/100.0)! * self.nbNights
        
        self.priceLabel.text = "\(price!) \(bed!.currency)"
    }
    
    func calculateNbNights() {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate!, to: endDate!)
        self.nbNights = components.day
    }
    
    func showAlert(title: String, description: String) {
        let alertController = UIAlertController(title: title, message: description , preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showOneActionAlert(title: String, description: String, actionTitle: String, completionHandler: @escaping (UIAlertAction)-> Void) {
        let alertController = UIAlertController(title: title, message: description , preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Cancel", style: .default )
        alertController.addAction(action1)
        
        let action2 = UIAlertAction(title: actionTitle, style: .default, handler: completionHandler)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RoomDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.text = self.selectedRoom.roomDescription as! String
        return cell!
    }
}
