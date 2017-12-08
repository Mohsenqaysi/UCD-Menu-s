//
//  ProfileCell.swift
//  CollectionViews
//
//  Created by Mohsen Qaysi on 12/8/17.
//  Copyright © 2017 Mohsen Qaysi. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell{ //, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    let cellID = "CellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
    }
}

extension ProfileCell {
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        return collectionView.d
//    }
}
