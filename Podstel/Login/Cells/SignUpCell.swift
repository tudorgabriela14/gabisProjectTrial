//
//  SignUpCell.swift
//  Podstel
//
//  Created by Gabriela on 17/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

protocol SignUpCellDelegate : class {
    func didPressCreateAccount()
}

class SignUpCell: UITableViewCell {
    
    weak var delegate : SignUpCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func createAccount(_ sender: Any) {
        self.delegate?.didPressCreateAccount()
    }
    
}
