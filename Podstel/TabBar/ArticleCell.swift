//
//  ArticleCell.swift
//  Podstel
//
//  Created by Gabriela on 22/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    var index: Int = 0
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var shadowCoverView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shadowCoverView.applyShadow()
        nameView.applyShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
