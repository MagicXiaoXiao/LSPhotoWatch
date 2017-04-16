//
//  BigPhotoViewController.swift
//  MyPhotoWatch
//
//  Created by 晓晓魔导师 on 2017/4/14.
//  Copyright © 2017年 花落知多少. All rights reserved.
//

import UIKit
import Hero

class BigPhotoViewController: UIViewController {

    var testArray: [String]?
    var currentIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.register(UINib(nibName: "BigPhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isPagingEnabled = true
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        isHeroEnabled = true
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.itemSize = collectionView.bounds.size
        }
        collectionView.scrollToItem(at: currentIndexPath, at: .left, animated: false)
        
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        dismiss(animated: true) { 
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BigPhotoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let datas = testArray else { return 0 }
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        if let cell = cell as? BigPhotoCell {
            cell.imageView.heroID = "P\(indexPath.row)"
        }
        return cell
    }
    
}

extension BigPhotoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? BigPhotoCell else { return }
        guard let datas = testArray else { return }
        cell.setData(imgUrl: datas[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? BigPhotoCell else { return }
        cell.imageView.kf.cancelDownloadTask()
    }
    
}






