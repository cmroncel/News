//
//  NewsDetailTopCell.swift
//  News
//
//  Created by Cemre ÖNCEL on 31.01.2020.
//  Copyright © 2020 Accecare. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class NewsDetailTopCell: UITableViewCell {
    
    let orientationChangedReceiver = Notification.Name(rawValue: orientationChangedKey)

    @IBOutlet weak var imageViewNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    var viewForVideo : UIView!
    var topHeight : CGFloat!
    
    var videoURL : String!
    
    let vc = AVPlayerViewController()
    var player = AVPlayer()
    
    var avPlayerLayer : AVPlayerLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        videoURL = UserDefaults.standard.string(forKey: "videoURL")
        
        if videoURL != "" {
            topHeight = CGFloat(UserDefaults.standard.integer(forKey: "topBarHeight"))
            
            viewForVideo = UIView()
            viewForVideo.layer.masksToBounds = true
            viewForVideo.frame = CGRect(x: 0, y: imageViewNews.frame.minY, width: frame.width, height: imageViewNews.frame.height + 16)
            addSubview(viewForVideo)
            
            guard let url = URL(string: videoURL) else {return}
            
            player = AVPlayer(url: url)
            vc.player = player
            vc.view.frame.size.height = viewForVideo.frame.size.height
            vc.view.frame.size.width = viewForVideo.frame.size.width
            
            viewForVideo.addSubview(vc.view)
            player.play()
            
            createObservers()
        }
        
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged(notification:)), name: orientationChangedReceiver, object: nil)
        
    }
    
    @objc func orientationChanged(notification: NSNotification) {
        
        let orientation : Bool = (notification.userInfo?["landscape"] as? Bool)!
        
        if orientation {
            
            //portrait
            viewForVideo.frame = CGRect(x: 0, y: imageViewNews.frame.minY, width: UIScreen.main.bounds.height, height: imageViewNews.frame.height + 16)
            
            
        } else {
            
            //landscape
            
            viewForVideo.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
            
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}
