//
//  ExtraActionCell.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

protocol ExtraActionCellDelegate : class {
    func didPressButton(type : String)
}
class ExtraActionCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    weak var delegate : ExtraActionCellDelegate?
    var type : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func doAction(_ sender: Any) {
        self.delegate?.didPressButton(type: type!)
    }
}
