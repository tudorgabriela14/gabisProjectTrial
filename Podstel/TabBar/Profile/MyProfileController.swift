//
//  MyProfileController.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse
import SDWebImage
import SVProgressHUD_0_8_1

class MyProfileController: AppBaseViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var myEvents = [Event]()
    var myBookings = [Booking]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.avatarImageView.sd_setImage(with: URL(string: ((PFUser.current() as! User).avatar.url)!), placeholderImage: UIImage(named: "avatarPlaceholder"))
        self.nameLabel.text = (PFUser.current() as! User).firstName + " \((PFUser.current() as! User).lastName.first!)."

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.register(UINib(nibName: "CaruselTypeOneCell",   bundle: nil), forCellReuseIdentifier: "CaruselTypeOneCell")
        SVProgressHUD.show()
        ParseManager.shared.getMyEvents { (eventsArray, error) in
            if(error == nil) {
                self.myEvents = eventsArray
                self.tableView.reloadData()
                ParseManager.shared.getMyReservations(block: { (bookingsArray, error) in
                    SVProgressHUD.dismiss()
                    if(error == nil) {
                        self.myBookings = bookingsArray
                        self.tableView.reloadData()
                    }
                })
            }
            else {
                SVProgressHUD.dismiss()
            }
        }
    }

    @IBAction func didTouchSettings(_ sender: Any) {
    }
}

extension MyProfileController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let caruselCell = tableView.dequeueReusableCell(withIdentifier: "CaruselTypeOneCell") as! CaruselTypeOneCell
            caruselCell.titleLabel.text = "My Events (\(self.myEvents.count))"
            caruselCell.objectsArray = myEvents
            caruselCell.isBooking = false
            
            if(myEvents.count == 0) {
                caruselCell.placeholderLabel.text = "No events to be displayed yet."
                caruselCell.placeholderLabel.backgroundColor = UIColor.white
                caruselCell.placeholderLabel.isHidden = false
            }
            else {
                caruselCell.placeholderLabel.isHidden = true
            }
            caruselCell.collectionView.reloadData()
            return caruselCell
        }
        else {
            let caruselCell = tableView.dequeueReusableCell(withIdentifier: "CaruselTypeOneCell") as! CaruselTypeOneCell
            caruselCell.titleLabel.text = "My Bookings (\(self.myBookings.count))"
                caruselCell.isBooking = true
            caruselCell.bookingsArray = myBookings
        
            if(myBookings.count == 0) {
                caruselCell.placeholderLabel.text = "No booking to be displayed yet."
                caruselCell.placeholderLabel.backgroundColor = UIColor.white
                caruselCell.placeholderLabel.isHidden = false
            }
            else {
                caruselCell.placeholderLabel.isHidden = true
            }
            caruselCell.collectionView.reloadData()
            return caruselCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

