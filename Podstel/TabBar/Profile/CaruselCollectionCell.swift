//
//  CaruselCollectionCell.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class CaruselCollectionCell: UICollectionViewCell {

    @IBOutlet weak var eventCoverImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var nightForBookingLabel: UILabel!
    @IBOutlet weak var startingFromLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var checkedImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.eventCoverImageView.applyShadow()
        self.titleView.applyShadow()
    }

}
