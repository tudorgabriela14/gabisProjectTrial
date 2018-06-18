//
//  CaruselTypeOneCell.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import SVProgressHUD_0_8_1

class CaruselTypeOneCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    var isBooking : Bool = false
    
    var objectsArray = [Event]()
    var bookingsArray = [Booking]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CaruselCollectionCell",   bundle: nil), forCellWithReuseIdentifier: "CaruselCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CaruselTypeOneCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isBooking {
            return self.bookingsArray.count
        }
        return self.objectsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(self.isBooking) {
           return  self.configureBookingCell(indexPath: indexPath)
        }
        else {
            return self.configureEventCell(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width - 70
        return CGSize(width: screenWidth, height: 150)
    }
    
    func configureEventCell(indexPath: IndexPath) -> CaruselCollectionCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaruselCollectionCell", for: indexPath) as! CaruselCollectionCell
        cell.eventCoverImageView.sd_setImage(with: URL(string: (objectsArray[indexPath.item].eventCover?.url)!), placeholderImage: UIImage(named: "placeholder.png"))
        cell.eventNameLabel.text = objectsArray[indexPath.item].title
        cell.applyShadow()
        cell.startDateLabel.isHidden = true
        cell.nightForBookingLabel.isHidden = true
        cell.startingFromLabel.isHidden = true
        cell.checkedImageView.image = UIImage(named:"checkedIcon")
        cell.checkedImageView.backgroundColor = UIColor.clear
        return cell
    }
    
    func configureBookingCell(indexPath: IndexPath) -> CaruselCollectionCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaruselCollectionCell", for: indexPath) as! CaruselCollectionCell
        
        let currentBooking = bookingsArray[indexPath.item] as! Booking
        //set image
        cell.eventCoverImageView.image = UIImage(named: "podstel")!
        //set nb nights
        var nbNights = self.calculateNbNights(booking: currentBooking)
         cell.nightForBookingLabel.text = " \(nbNights) night"
        if(nbNights > 0) {
            cell.nightForBookingLabel.text = " \(nbNights) nights"
        }
        //set date
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day , .month , .year], from: (currentBooking.startDate as Date))
        let month = (currentBooking.startDate as Date).getMonthName()
        let day = components.day
        
        cell.startDateLabel.text = String(format:"%d ",day!) + "\n \(month)"
        //set reservation nb
        cell.eventNameLabel.text = "Reservation nb: \(currentBooking.objectId!)"
     
        cell.applyShadow()
        cell.startDateLabel.isHidden = false
        cell.nightForBookingLabel.isHidden = false
        cell.startingFromLabel.isHidden = false
        cell.checkedImageView.image = UIImage(named:"bookingsIcon")
        cell.checkedImageView.backgroundColor = UIColor(red: 254.00, green: 240.00, blue: 131.00, alpha: 1.00)
        return cell
    }
    
    func getRoom(bedId:String) -> Room {
        SVProgressHUD.show()
        var room : Room?
        ParseManager.shared.getRoomBy(bedId: bedId) { (bed, error) in
            SVProgressHUD.dismiss()
            if (error == nil) {
                room = bed?.room
            }
        }
        return room!
    }
    
    func calculateNbNights(booking:Booking) -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: (booking.startDate  as Date?)!, to: (booking.endDate  as Date?)!)
        return components.day!
    }
}
