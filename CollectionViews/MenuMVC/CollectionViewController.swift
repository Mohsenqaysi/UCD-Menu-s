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
    
     var passedArray = [Services]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.collectionView?.allowsSelection = false
        navigationController?.navigationBar.prefersLargeTitles = false
        self.collectionView?.reloadData()
        collectionView?.backgroundColor = .white
        collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: cellID_Profile)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID_Menu )
        
    }
}

extension CollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (passedArray.first?.menu.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        if indexPath.item == 0 {
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID_Profile, for: indexPath) as! ProfileCell
            
            let logo = passedArray[indexPath.item].logo_URL
            let urlImage = URL(string: logo)!
            print(urlImage)
            topCell.profileImage.kf.setImage(with: urlImage)
            topCell.restaurantNameLable.text = passedArray[indexPath.item].title
            topCell.restaurantFoodtypeLable.text = passedArray[indexPath.item].type
            let info =
            """
            \(passedArray[indexPath.item].opening_days)
            \(passedArray[indexPath.item].opening_hours)
            """
            topCell.daysANDhoursLable.text = info
            return topCell
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
