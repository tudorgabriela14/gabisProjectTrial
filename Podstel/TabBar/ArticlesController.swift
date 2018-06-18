//
//  ArticlesController.swift
//  Podstel
//
//  Created by Gabriela on 22/05/2018.
//  Copyright © 2018 Gabriela. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD_0_8_1

class ArticlesController: AppBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var articlesArray = [Article]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show()
        ParseManager.shared.getArticles { (articlesList, error) in
            SVProgressHUD.dismiss()
            if(error != nil) {
                //show alert
            }
            else {
                self.articlesArray = articlesList
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ArticlesController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleCell = self.tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
        articleCell.nameLabel.text = articlesArray[indexPath.row].title
//        articleCell.coverImageView.image =
        articleCell.coverImageView.sd_setImage(with: URL(string: (articlesArray[indexPath.row].coverImage?.url)!), placeholderImage: UIImage(named: "placeholder.png"))
        articleCell.index = indexPath.row
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ArticleDetailsController
        controller.article = articlesArray[(sender as! ArticleCell).index]
    }
}
