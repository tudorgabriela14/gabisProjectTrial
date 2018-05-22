//
//  ArticleCell.swift
//  Podstel
//
//  Created by Gabriela on 22/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nameView.applyShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
