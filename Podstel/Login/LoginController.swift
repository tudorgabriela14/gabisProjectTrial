//
//  LoginController.swift
//  Podstel
//
//  Created by Gabriela on 17/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse

class LoginController: AppBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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

    @IBAction func connect(_ sender: Any) {
        if(self.validateFields()) {
            PFUser.logInWithUsername(inBackground: self.emailTextField.text!.lowercased(), password: self.passwordTextField.text!, block: { (user, error) in
                if(user != nil) {                    
                    let tabBarVC = self.storyBoard.instantiateViewController(withIdentifier: "TabBarController")
                    self.present(tabBarVC, animated: true, completion: nil)
                }
                else {
                    self.simpleAlert(title: "Attention".localized(), message: "\(error ?? "Login couldn't be finished. Please try again." as! Error)")
                }
            })
        }
    }
    
    func validateFields() -> Bool{
        if(!emailTextField.isValidEmail) {
            self.simpleAlert(title: "Attention".localized(), message: "Please make sure your email address is valid, then try again. Thank you!".localized())
            return false;
        }
        else {
            if((passwordTextField.text?.length)! < 5) {
                self.simpleAlert(title: "Attention".localized(), message: "Please make sure your password has the right format. Thank you!".localized())
                return false;
            }
        }
        return true;
    }
}

extension LoginController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signUpCell") as! SignUpCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension LoginController : SignUpCellDelegate {
    func didPressCreateAccount() {
        print("create account")
    }
}
