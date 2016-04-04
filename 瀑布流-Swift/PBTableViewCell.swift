//
//  PBTableViewCell.swift
//  瀑布流-Swift
//
//  Created by zhuming on 16/3/30.
//  Copyright © 2016年 zhuming. All rights reserved.
//

import UIKit

class PBTableViewCell: UITableViewCell {

    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
