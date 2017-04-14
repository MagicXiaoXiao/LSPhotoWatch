//
//  SmallPhotoCell.swift
//  MyPhotoWatch
//
//  Created by 晓晓魔导师 on 2017/4/14.
//  Copyright © 2017年 花落知多少. All rights reserved.
//

import UIKit
import Kingfisher

class SmallPhotoCell: UICollectionViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.kf.indicatorType = .activity
    }

}
