//
//  News.swift
//  News
//
//  Created by Cemre ÖNCEL on 31.01.2020.
//  Copyright © 2020 Accecare. All rights reserved.
//

import Foundation

class News : Decodable {
    
    var title : String
    var imageUrl : String
    var videoUrl : String
    var body : [Body]
    
    init(title : String, imageUrl : String, videoUrl : String, body : [Body]) {
        self.title = title
        self.imageUrl = imageUrl
        self.videoUrl = videoUrl
        self.body = [Body]()
    }
    
    init() {
        title = ""
        imageUrl = ""
        videoUrl = ""
        body = [Body]()
    }
    
}
