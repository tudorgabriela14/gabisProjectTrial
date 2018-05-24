//
//  CaruselTypeOneCell.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class CaruselTypeOneCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeholderLabel: UILabel!
    var objectsArray = [Event]()
    var bookingsArray = [Booking]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CaruselCollectionCell",   bundle: nil), forCellWithReuseIdentifier: "CaruselCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CaruselTypeOneCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objectsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaruselCollectionCell", for: indexPath) as! CaruselCollectionCell
        cell.eventCoverImageView.sd_setImage(with: URL(string: (objectsArray[indexPath.item].eventCover?.url)!), placeholderImage: UIImage(named: "placeholder.png"))
        cell.eventNameLabel.text = objectsArray[indexPath.item].title
        cell.applyShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width - 70
        return CGSize(width: screenWidth, height: 150)
    }
}
