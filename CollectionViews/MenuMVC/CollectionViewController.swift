//
//  ViewController.swift
//  CollectionViews
//
//  Created by Mohsen Qaysi on 12/7/17.
//  Copyright © 2017 Mohsen Qaysi. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellID_Profile = "CellProfile"
    let cellID_Menu = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: cellID_Profile)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID_Menu )
        
    }
}

extension CollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID_Profile, for: indexPath) as! ProfileCell
            cell.profileImage.image = UIImage(named: "1")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID_Menu, for: indexPath) as! CategoryCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 160)
        } else {
            return CGSize(width: view.frame.width, height: 200)
        }
    }
}
