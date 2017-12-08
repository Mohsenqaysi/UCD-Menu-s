//
//  MainCollectionViewController.swift
//  CollectionViews
//
//  Created by Mohsen Qaysi on 12/8/17.
//  Copyright © 2017 Mohsen Qaysi. All rights reserved.
//

import UIKit

private let cellID = "Cell"

class MainCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        //        collectionView?.collectionViewLayout.collectionView.h
        // Register cell classes
        self.collectionView!.register(ResturantLogoCell.self, forCellWithReuseIdentifier: cellID)
    }
}

extension MainCollectionViewController {
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ResturantLogoCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 425)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

class ResturantLogoCell: UICollectionViewCell {
    
    let logoImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "1")
        image.translatesAutoresizingMaskIntoConstraints = false // Very important
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    let restaurantNameLable: UILabel = {
        let lable = UILabel(frame: .zero)
        lable.translatesAutoresizingMaskIntoConstraints = false // Very important
        lable.text = "Restaurant Name Lable Restaurant Name Lable"
        lable.textColor = .white
        lable.font = .boldSystemFont(ofSize: 24)
        lable.numberOfLines = 2
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubview(logoImageView)
        addSubview(restaurantNameLable)
        
        // logoImageView
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : logoImageView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : logoImageView]))
        // END
        
        // logoImageView
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-28-[v1]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : restaurantNameLable]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1]-48-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : restaurantNameLable]))
        // END
        
        self.logoImageView.clipsToBounds = true
        self.logoImageView.layer.cornerRadius = 14
    }
}
