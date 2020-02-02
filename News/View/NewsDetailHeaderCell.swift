//
//  NewsDetailHeaderCell.swift
//  News
//
//  Created by Cemre ÖNCEL on 31.01.2020.
//  Copyright © 2020 Accecare. All rights reserved.
//

import UIKit

class NewsDetailHeaderCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
