//
//  BookingsViewController.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD_0_8_1

class BookingsViewController: UIViewController {
    
     @IBOutlet weak var filterRooms: UIButton!
    @IBOutlet weak var startDatetextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var appliedFiltersImage: UIImageView!
    
    
    var hasFilters: Bool = false
    var startDate : Date?
    var endDate : Date?
    
    let datePicker = UIDatePicker()
    var bedsGroupedByRoomDict :Dictionary<Room, [Bed]>?
    
    var roomsArray = [Room]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getAllRooms()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showDatePicker() {
        datePicker.datePickerMode = .date
        
        let toolbarStartDate = UIToolbar();
        toolbarStartDate.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbarStartDate.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        startDatetextField.inputAccessoryView = toolbarStartDate
        startDatetextField.inputView = datePicker
        
        let toolbarEndDate = UIToolbar();
        toolbarEndDate.sizeToFit()
        let doneButton2 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker2));
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton2 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbarEndDate.setItems([doneButton2,spaceButton2,cancelButton2], animated: false)
        endDateTextField.inputAccessoryView = toolbarEndDate
        endDateTextField.inputView = datePicker
    }
    
    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let comparisonResult = endDate?.compare(datePicker.date)
        if(comparisonResult == .orderedAscending) {
            print("start date must be < than end date")
            startDate = endDate
            startDatetextField.text = endDateTextField.text
            self.view.endEditing(true)
            return
        }
        startDate = datePicker.date
        
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day , .month , .year], from: datePicker.date)
        let month = datePicker.date.getMonthName()
        let day = components.day
        let dayOfTheWeek = getDayOfWeek(formatter.string(from: datePicker.date))
        
        startDatetextField.text = dayOfTheWeek! + ", " + String(format:"%d ",day!) + month
        self.view.endEditing(true)
    }
    
    @objc func doneDatePicker2(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let comparisonResult = datePicker.date.compare(startDate!)
        if(comparisonResult == .orderedAscending) {
            print("start date must be > than end date")
            endDate = startDate
            endDateTextField.text = startDatetextField.text
            self.view.endEditing(true)
            return
        }
        endDate = datePicker.date
        
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day , .month , .year], from: datePicker.date)
        let month = datePicker.date.getMonthName()
        let day = components.day
        let dayOfTheWeek = getDayOfWeek(formatter.string(from: datePicker.date))
        
        endDateTextField.text = dayOfTheWeek! + ", " + String(format:"%d ",day!) + month
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func getDayOfWeek(_ today:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        var dayOfWeek = ""
        
        switch weekDay {
        case 1:
            dayOfWeek = "Sun"
        case 2:
            dayOfWeek = "Mon"
        case 3:
            dayOfWeek = "Tue"
        case 4:
            dayOfWeek = "Wed"
        case 5:
            dayOfWeek = "Thu"
        case 6:
            dayOfWeek = "Fri"
        case 7:
            dayOfWeek = "Sat"
        default:
            dayOfWeek = "Mon"
        }
        return dayOfWeek
    }

   
    @IBAction func filterRooms(_ sender: Any) {
        if self.hasFilters {
           self.getAllRooms()
        }
        else {
            if(startDate != nil && endDate != nil && self.calculateNbNights() > 0) {
                self.appliedFiltersImage.isHidden = false
                self.hasFilters = true
                SVProgressHUD.show()
                ParseManager.shared.getAvailableBeds(checkInDate: startDate!, checkOutDate: endDate!) { (availableBedsArray, error) in
                    SVProgressHUD.dismiss()
                    print("get rooms \(availableBedsArray)")
        
                    self.bedsGroupedByRoomDict?.removeAll()
                    self.roomsArray.removeAll()
                    self.bedsGroupedByRoomDict = Dictionary(grouping: availableBedsArray, by: {$0.room})
                    self.roomsArray = ParseManager.shared.getRoomsForBeds(availableBedsArray: availableBedsArray)
                    print(self.roomsArray)
                }
            }
            else {
                self.showAlert(title: "Attention", description: "The minimal period you can book, is one night. Please make sure you selected a valid check-in and check-out interval.")
            }
        }
    }
    
    func getAllRooms() {
        self.appliedFiltersImage.isHidden = true
        self.hasFilters = false
        self.startDate = nil
        self.endDate = nil
        self.startDatetextField.text = ""
        self.endDateTextField.text = ""
        
        SVProgressHUD.show()
        ParseManager.shared.getRooms{ (roomList, error) in
            SVProgressHUD.dismiss()
            if(error != nil) {
                //show alert
            }
            else {
                self.roomsArray = roomList
            }
        }
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
        let roomSize = roomsArray[indexPath.row].roomSize
        cell.roomSizeLabel.text = "Size: " + String(format:"%d",roomSize.intValue)
 
        if(roomSize.intValue < 20) {
            //then it's superior
            cell.superiorRoomLabel.isHidden = true
        }
        else {
            cell.superiorRoomLabel.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRoom = roomsArray[indexPath.row]
        if(self.hasFilters && (self.startDate != nil) && (self.endDate != nil) ) {
            if(self.calculateNbNights() > 0) {
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RoomDetailsViewController") as? RoomDetailsViewController {
                    viewController.selectedRoom = selectedRoom
                    viewController.startDate = self.startDate
                    viewController.endDate = self.endDate
                    viewController.bedsForRoom = self.bedsGroupedByRoomDict![selectedRoom]!
                    if let navigator = navigationController {
                        navigator.pushViewController(viewController, animated: true)
                    }
                }
            }
            else {
               self.showAlert(title: "Attention", description: "The minimal period you can book, is one night. Please make sure you selected a valid check-in and check-out interval.")
            }
        }
        else {
            self.showAlert(title: "Attention", description: "Before you proceed to book a bed, you must filter the rooms for a check-in and check-out interval.")
        }
    }
    
    func calculateNbNights() -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate!, to: endDate!)
        return components.day!
    }
    
    func showAlert(title: String, description: String) {
        let alertController = UIAlertController(title: title, message: description , preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
}
