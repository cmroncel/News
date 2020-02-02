//
//  NewsTableViewController.swift
//  News
//
//  Created by Cemre ÖNCEL on 31.01.2020.
//  Copyright © 2020 Accecare. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class NewsTableViewController: UITableViewController {
    
    var news : [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        guard let url = URL(string: "https://app.haberler.com/services/haberlercom/2.11/service.asmx/haberler?category=manset&count=35&offset=0&deviceType=1&userId=61ed99e0c09a8664") else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                
                do {
                    //let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let json = try JSONDecoder().decode(ModelForNews.self, from: data)
                    
                    self.news = json.news
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                        
                    }
                    
                } catch {
                    print(error)
                }
            }
            
        }.resume()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsViewCell else {fatalError("news error")}
        
        let nextNews = news[indexPath.row]
        
        cell.lblTitle.text = nextNews.title
        let imageURL = URL(string: nextNews.imageUrl)!
        cell.imageViewNews.downloaded(from: imageURL, contentMode: .scaleAspectFill)
        cell.selectionStyle = .none
        
        return cell
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let selectedNews = news[indexPath.row]
                let selectedNewsBody = selectedNews.body
                
                guard let navigationController = segue.destination as? UINavigationController,
                    let newsDetailController = navigationController.topViewController as? NewsDetailsTableViewController else {return}
                
                newsDetailController.news = selectedNews
                newsDetailController.body = selectedNewsBody
                
            }
            
            
        }
        
    }

}

public final class ModelForNews: Decodable {
    
    var news : [News]
    
}

struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}
