//
//  LoginController.swift
//  Podstel
//
//  Created by Gabriela on 17/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connect(_ sender: Any) {
        print("login")
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
