//
//  NewsViewCell.swift
//  News
//
//  Created by Cemre ÖNCEL on 31.01.2020.
//  Copyright © 2020 Accecare. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 10
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
