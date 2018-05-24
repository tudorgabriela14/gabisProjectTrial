//
//  DoubleActionsCell.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

protocol DoubleActionsCellDelegate : class {
    func didPressAttend()
    func didPressSeeParticipants()
}

class DoubleActionsCell: UITableViewCell {
    weak var delegate:DoubleActionsCellDelegate?
    var event:Event!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func seeParticipants(_ sender: Any) {
        self.delegate?.didPressSeeParticipants()
    }
    
    @IBAction func attendEvent(_ sender: Any) {
        self.delegate?.didPressAttend()
    }
}
