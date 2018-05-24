//
//  SignUpController.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class SignUpController: AppBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didTouchSignUp(_ sender: Any) {
    }
    
}

extension SignUpController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "avatarCell") as! SignUpAvatarCell
        switch indexPath.row {
        case 0: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "avatarCell") as! SignUpAvatarCell
            
            return infoCell
            }
        case 1: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! SignUpInfoCell
            infoCell.titleLabel.text = "First name"
            infoCell.infoTextField.placeholder = "First name"
            return infoCell
            }
        case 2: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! SignUpInfoCell
            infoCell.titleLabel.text = "Last name"
            infoCell.infoTextField.placeholder = "Last name"
            return infoCell
            }
        case 3: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! SignUpInfoCell
            infoCell.titleLabel.text = "Country"
            infoCell.infoTextField.placeholder = "Country"
            return infoCell
            }
        case 4: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! SignUpInfoCell
            infoCell.titleLabel.text = "Email"
            infoCell.infoTextField.placeholder = "Email"
            return infoCell
            }
        case 5: do{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! SignUpInfoCell
            infoCell.titleLabel.text = "Password"
            infoCell.infoTextField.placeholder = "password"
            infoCell.infoTextField.isSecureTextEntry = true
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
