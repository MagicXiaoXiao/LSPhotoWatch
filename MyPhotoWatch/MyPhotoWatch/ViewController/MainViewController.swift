//
//  MainViewController.swift
//  MyPhotoWatch
//
//  Created by 晓晓魔导师 on 2017/4/14.
//  Copyright © 2017年 花落知多少. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    let identifier = "PhotoItem"
    let screenSize = UIScreen.main.bounds.size
    let scale = UIScreen.main.scale
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing =  scale
            layout.minimumInteritemSpacing = scale
            let width = (screenSize.width - layout.minimumInteritemSpacing)/2
            layout.itemSize = CGSize(width: width, height: width)
        }
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
}



