//
//  MainViewController.swift
//  MyPhotoWatch
//
//  Created by 晓晓魔导师 on 2017/4/14.
//  Copyright © 2017年 花落知多少. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "SmallPhotoCell", bundle: nil), forCellWithReuseIdentifier: identifier)
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumLineSpacing =  scale
                layout.minimumInteritemSpacing = scale
                let width = (screenSize.width - layout.minimumInteritemSpacing)/2
                layout.itemSize = CGSize(width: width, height: width)
            }
        }
    }

    let identifier = "PhotoItem"
    let screenSize = UIScreen.main.bounds.size
    let scale = UIScreen.main.scale
    
    let testArray = ["https://imgsa.baidu.com/forum/w%3D580/sign=9655ab3cf2dcd100cd9cf829428a47be/50b32e1f4134970a9ddc111e9fcad1c8a7865d31.jpg",
                     "https://imgsa.baidu.com/forum/w%3D580/sign=7627b62d262eb938ec6d7afae56085fe/c9cd18ef76094b368e6fae21aacc7cd98f109dda.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492166386471&di=fa57cb02a622bc0a95567927934dcf53&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F6d81800a19d8bc3e0dabc373838ba61ea9d345ec.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492166434108&di=9353f6027982a74d82900f246c7f1ca1&imgtype=0&src=http%3A%2F%2Fimages.17173.com%2F2013%2Fwow%2F2013%2F10%2F13%2Fs20131013191501433.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492166764083&di=9aab9ae34e70b0dfd19c009a982088a7&imgtype=0&src=http%3A%2F%2Fwww.520885.com%2Fpic%2Fjuqingdatu%2F2014-10%2F2014102817175083764.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492167166551&di=ce905c6efd3ccc4403ce8e1cb2f9fb7d&imgtype=0&src=http%3A%2F%2Fi3.hexunimg.cn%2F2016-09-28%2F186224738.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492167200707&di=fffa5fb731fbe265dae9733f2c491528&imgtype=0&src=http%3A%2F%2Fh6.86.cc%2Fwalls%2F20160721%2Fmid_bdaee2a345fd80d.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492167219159&di=e408ea967b2769538ad7e3c6bacf51e6&imgtype=0&src=http%3A%2F%2Fh5.86.cc%2Fwalls%2F20160708%2Fmid_eb33900cc93f31e.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492167255337&di=1ddfdb1dafd69109c41ac3636756fc68&imgtype=0&src=http%3A%2F%2Fv1.qzone.cc%2Fskin%2F201608%2F27%2F09%2F05%2F57c0e747bc465901.png%2521600x600.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492174593180&di=d745fc5ea6ed4ab89f9573437cbaeeff&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2014%2F064%2F81G4I26G152L_1000x500.jpg"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        KingfisherManager.shared.cache.clearDiskCache()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? SmallPhotoCell {
            cell.mainImageView.kf.setImage(
                with: URL(string: testArray[indexPath.row]),
                placeholder: nil,
                options: [.transition(.fade(1))],
                progressBlock: nil,
                completionHandler: { (image, error, cache, url) in
                    
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? SmallPhotoCell else { return }
        cell.mainImageView.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toBigPhoto", sender: nil)
    }
    
}




