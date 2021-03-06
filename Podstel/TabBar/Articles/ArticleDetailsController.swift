//
//  ArticleDetailsController.swift
//  Podstel
//
//  Created by Gabriela on 23/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit

class ArticleDetailsController: AppBaseViewController {
    var article:Article!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleBodyLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articleTitleLabel.text = article.title
        self.articleBodyLabel.text = article.articleBody
        self.coverImageView.sd_setImage(with: URL(string: (article.coverImage?.url)!), placeholderImage: UIImage(named: "placeholder.png"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbShare(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: ["Check out this awesome article \"\(article.title)\" on Podstel app!"], applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = controller.view // so that iPads won't crash
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
