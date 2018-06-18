//
//  SignUpController.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import IQKeyboardManager
import SVProgressHUD_0_8_1
import Parse

class SignUpController: AppBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var imagePicker = UIImagePickerController()
    var selectedImage: UIImage?
    
    var firstName: String?
    var lastName: String?
    var country: String?
    var email: String?
    var password: String?
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTouchSignUp(_ sender: Any) {
        if validateFields() && (self.selectedImage != nil) {
            register()
        }
        else {
            self.showAlert(title: "Attention", description: "You must make sure you chose a profile image before register.")
        }
    }
    
    func register() {
        var newUser = User()
        newUser.username = self.email!.lowercased()
        newUser.firstName = self.firstName!
        newUser.lastName = self.lastName!
        newUser.country = self.country!
        newUser.password = self.password!
        
        SVProgressHUD.show()
        newUser.signUpInBackground { (succeed, error) in
            if((error) != nil) {
                SVProgressHUD.dismiss()
                self.showAlert(title: "Attention", description: "Your account couldn't be created. Please try again.")
            }
            else {
                let file = PFFile(data: UIImageJPEGRepresentation(self.selectedImage!, 1.0)!)
                newUser.avatar = file!
                newUser.saveInBackground(block: { (succeeded, error) in
                    SVProgressHUD.dismiss()
                    if((error) != nil) {
                        self.showAlert(title: "Attention", description: "Your profile picture couldn't be saved.")
                    }
                    else {
                        self.showOneActionAlert(title: "Success", description: "Your account has been successfully created!", actionTitle: "Begin", completionHandler: { (completion) in
                            let tabBarVC = self.storyBoard.instantiateViewController(withIdentifier: "TabBarController")
                            self.present(tabBarVC, animated: true, completion: nil)
                        })
                    }
                })
            }
        }
    }
    
    func validateFields() -> Bool {
        if (self.firstName?.stringByRemovingWhitespaces.count)! == 0 ||
            (self.lastName?.stringByRemovingWhitespaces.count)! == 0 ||
            (self.country?.stringByRemovingWhitespaces.count)! == 0 ||
            (self.email?.stringByRemovingWhitespaces.count)! == 0 ||
            (self.password?.stringByRemovingWhitespaces.count)! < 6 {
            self.showAlert(title: "Attention", description: "You must make sure all the fields are completed and the password has at least 6 characters.")
            return false
        }
        else {
            if(!(self.email?.isValidEmail)!) {
                self.showAlert(title: "Attention", description: "You must make sure the email introduced has the correct format.")
                return false
            }
        }
        return true
    }
    
    func showAlert(title: String, description: String) {
        let alertController = UIAlertController(title: title, message: description , preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showOneActionAlert(title: String, description: String, actionTitle: String, completionHandler: @escaping (UIAlertAction)-> Void) {
        let alertController = UIAlertController(title: title, message: description , preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: actionTitle, style: .default, handler: completionHandler)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension SignUpController : UITableViewDelegate, UITableViewDataSource, SignUpAvatarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func uploadPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.selectedImage = image
        }
        
        picker.dismiss(animated: true, completion: nil);
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "avatarCell") as! SignUpAvatarCell
        switch indexPath.row {
        case 0: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "avatarCell") as! SignUpAvatarCell
            infoCell.delegate = self
            if let chosenImg = self.selectedImage {
                infoCell.avatarImageView.image = chosenImg
            }
            return infoCell
            }
        case 1: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! SignUpInfoCell
            infoCell.titleLabel.text = "First name"
            infoCell.infoTextField.placeholder = "First name"
            infoCell.infoTextField.isSecureTextEntry = false
            infoCell.infoTextField.tag = 1001
            return infoCell
            }
        case 2: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! SignUpInfoCell
            infoCell.titleLabel.text = "Last name"
            infoCell.infoTextField.placeholder = "Last name"
            infoCell.infoTextField.isSecureTextEntry = false
             infoCell.infoTextField.tag = 1002
            return infoCell
            }
        case 3: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! SignUpInfoCell
            infoCell.titleLabel.text = "Country"
            infoCell.infoTextField.placeholder = "Country"
            infoCell.infoTextField.isSecureTextEntry = false
             infoCell.infoTextField.tag = 1003
            return infoCell
            }
        case 4: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! SignUpInfoCell
            infoCell.titleLabel.text = "Email"
            infoCell.infoTextField.placeholder = "Email"
            infoCell.infoTextField.isSecureTextEntry = false
             infoCell.infoTextField.tag = 1004
            return infoCell
            }
        case 5: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! SignUpInfoCell
            infoCell.titleLabel.text = "Password"
            infoCell.infoTextField.placeholder = "password"
            infoCell.infoTextField.isSecureTextEntry = true
             infoCell.infoTextField.tag = 1005
            return infoCell
            }
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SignUpController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1001: do {
            self.firstName = textField.text
            }
            break;
        case 1002: do {
            self.lastName = textField.text
            }
            break;
        case 1003: do {
            self.country = textField.text
            }
            break;
        case 1004: do {
            self.email = textField.text
            }
            break;
        case 1005: do {
            self.password = textField.text
            }
            break;
        default:
            break;
        }
    }
}

extension String {
    var stringByRemovingWhitespaces: String {
        return components(separatedBy: .whitespaces).joined(separator: "")
    }
}

