//
//  ViewController.swift
//  Podstel
//
//  Created by Gabriela on 09/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iconImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        iconImage.image = iconImage.image?.withRenderingMode(.alwaysTemplate)
        iconImage.tintColor = UIColor.red
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

