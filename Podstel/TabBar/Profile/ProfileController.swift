//
//  ProfileController.swift
//  Podstel
//
//  Created by Gabriela on 22/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import Parse

class ProfileController: AppBaseViewController {
    @IBOutlet weak var tableView: UITableView!
//    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ProfileController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! UITableViewCell
        cell.textLabel?.text = "Sign Out".localized()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            PFUser.logOutInBackground(block: { (error) in
                if(error != nil) {
                   self.simpleAlert(title: "Attention".localized(), message: "An error has occured while trying to log out. Please try again")
                    return
                }
//                let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginController")
//
//                self.window?.rootViewController = initialViewController
//                self.window?.makeKeyAndVisible()
            })
        }
    }
}
