//
//  BigPhotoCell.swift
//  MyPhotoWatch
//
//  Created by 晓晓魔导师 on 2017/4/16.
//  Copyright © 2017年 花落知多少. All rights reserved.
//

import UIKit

class BigPhotoCell: UICollectionViewCell {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet {
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.bouncesZoom = true
            scrollView.minimumZoomScale = 1
        }
    }
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        scrollView.delegate = self
        scrollView.addSubview(imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.contentSize = CGSize(width: imageView.bounds.width, height: scrollView.bounds.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func updateImageRect(image: UIImage) -> Void {
        self.layoutIfNeeded()
        imageView.image = image
        let imgSize = image.size
        //判断首先缩放的值
        let scaleX = scrollView.frame.size.width / imgSize.width
        let scaleY = scrollView.frame.size.height / imgSize.height
        
        if scaleX > scaleY {
            //Y方向先到边缘
            let imgViewWidth = imgSize.width * scaleY
            scrollView.maximumZoomScale = scrollView.frame.size.width / imgViewWidth
            imageView.frame = CGRect(origin: CGPoint(x: scrollView.frame.size.width/2 - imgViewWidth/2, y: 0), size: CGSize(width: imgViewWidth, height: scrollView.frame.size.height))
        }else {
            //X先到边缘
            let imgViewHeight = imgSize.height * scaleX
            scrollView.maximumZoomScale = scrollView.frame.size.height / imgViewHeight
            
            imageView.frame = CGRect(origin: CGPoint(x: 0, y: scrollView.frame.size.height/2 - imgViewHeight/2), size: CGSize(width: scrollView.frame.size.width, height: imgViewHeight))
        }
    }
    
    func setData(imgUrl: String) -> Void {
        imageView.kf.setImage(with: URL(string: imgUrl), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            guard let image = image else { return }
            self.updateImageRect(image: image)
        })
    }
    
    
}

extension BigPhotoCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let boundsSize = scrollView.bounds.size
        let imgFrame = imageView.frame
        let contentSize = scrollView.contentSize
        var centerPoint = CGPoint(x: contentSize.width/2, y: contentSize.height/2)
        
        if imgFrame.size.width <= boundsSize.width {
            centerPoint.x = boundsSize.width/2
        }
        
        if imgFrame.size.height <= boundsSize.height {
            centerPoint.y = boundsSize.height/2
        }
        imageView.center = centerPoint
    }
    
}
