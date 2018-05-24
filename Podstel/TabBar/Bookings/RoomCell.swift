//
//  RoomCell.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class RoomCell: UITableViewCell {
    @IBOutlet weak var roomCoverImageView: UIImageView!
    @IBOutlet weak var superiorRoomLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var floorAndBathroomLabel: UILabel!
    @IBOutlet weak var roomSizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
