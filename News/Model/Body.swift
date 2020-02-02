//
//  Body.swift
//  News
//
//  Created by Cemre ÖNCEL on 31.01.2020.
//  Copyright © 2020 Accecare. All rights reserved.
//

import Foundation

class Body : Decodable {
    
    var p : String?
    var h3 : String?
    
    init(p : String, h3 : String) {
        self.p = p
        self.h3 = h3
    }
    
    init() {
        p = ""
        h3 = ""
    }
}
