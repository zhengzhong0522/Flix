//
//  MovieCell.swift
//  Flix
//
//  Created by zhong zheng on 1/27/21.
//  Copyright © 2021 ZHONG ZHENG. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsis: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    override func
        awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
