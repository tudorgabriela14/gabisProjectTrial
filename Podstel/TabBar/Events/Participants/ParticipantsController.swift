//
//  ParticipantsController.swift
//  Podstel
//
//  Created by Gabriela on 24/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import SDWebImage

class ParticipantsController: AppBaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var currentEvent : Event!
    var participantsArray = [User]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ParseManager.shared.getParticipantsForEvent(event: self.currentEvent) { (usersArray, error) in
            if(error == nil) {
                self.participantsArray = usersArray
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ParticipantsController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.participantsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let participantCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "participantCell", for: indexPath) as! ParticipantCollectionViewCell
        participantCell.firstNameLabel.text = self.participantsArray[indexPath.item].firstName
        participantCell.avatarImageView.sd_setImage(with: URL(string: (self.participantsArray[indexPath.item].avatar.url)!), placeholderImage: UIImage(named: "placeholder.png"))
        
        return participantCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width - 30
        return CGSize(width: screenWidth/2, height: 150)
    }
}
