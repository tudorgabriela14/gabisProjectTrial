//
//  SignUpAvatarCell.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

protocol SignUpAvatarDelegate : class {
    func uploadPhoto()
}

class SignUpAvatarCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    var delegate:SignUpAvatarDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func uploadAvatar(_ sender: Any) {
        self.delegate.uploadPhoto()
    }
}
