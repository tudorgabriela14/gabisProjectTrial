//
//  AppBaseViewController.swift
//  Podstel
//
//  Created by Gabriela on 17/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class AppBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTouchBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func simpleAlert(title:String?,message:String?) {
        guard title != nil || message != nil else {
            return
        }
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }
    
    func simpleAlert(title:String?,message:String?, handler: (() -> Swift.Void)? = nil) {
        guard title != nil || message != nil else {
            return
        }
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(vc, animated: true, completion: handler)
    }
    
    func simpleAlert(title:String?,message:String?, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        guard title != nil || message != nil else {
            return
        }
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        present(vc, animated: true, completion: nil)
    }

}
