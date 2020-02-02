//
//  NewsDetailsTableViewController.swift
//  News
//
//  Created by Cemre ÖNCEL on 31.01.2020.
//  Copyright © 2020 Accecare. All rights reserved.
//

import UIKit

let orientationChangedKey = "orientation-changed"

class NewsDetailsTableViewController: UITableViewController {
    
    var news : News?
    var body : [Body] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        
        UserDefaults.standard.set(news?.videoUrl, forKey: "videoURL")
        UserDefaults.standard.synchronize()
        
        tableView.isScrollEnabled = true
        
        if news?.videoUrl != "" {
            AppUtility.lockOrientation(.all)
        } else {
            AppUtility.lockOrientation(.portrait)
        }
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIApplication.shared.statusBarOrientation.isLandscape {
            // active landscape changes
            
            let name = Notification.Name(orientationChangedKey)
            NotificationCenter.default.post(name: name, object: nil, userInfo: ["landscape" : true])
            tableView.isScrollEnabled = true
            
            
        } else {
            // active portrait changes
            
            let name = Notification.Name(orientationChangedKey)
            NotificationCenter.default.post(name: name, object: nil, userInfo: ["landscape" : false])
            tableView.isScrollEnabled = false
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return body.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "topCell", for: indexPath) as? NewsDetailTopCell else {fatalError("news error")}
            
            let imageURL = URL(string: news!.imageUrl)!
            cell.imageViewNews.downloaded(from: imageURL, contentMode: .scaleAspectFill)
            cell.lblTitle.text = news?.title
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as? NewsDetailHeaderCell else {fatalError("news error")}
           
            
            if body[indexPath.row - 1].h3 != nil {
                
                cell.lblHeader.font = .boldSystemFont(ofSize: 20)
                cell.lblHeader.text = body[indexPath.row - 1].h3
                
                
            } else {
                
                cell.lblHeader.text = body[indexPath.row - 1].p
                cell.lblHeader.font = .systemFont(ofSize: 17)
                
            }
            return cell
            
        }
        
        
    }
    
}
