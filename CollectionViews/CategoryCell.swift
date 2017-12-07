//
//  CategoryCell.swift
//  CollectionViews
//
//  Created by Mohsen Qaysi on 12/7/17.
//  Copyright © 2017 Mohsen Qaysi. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    let CellID = "CellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let restaurantCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false // Very important
        view.backgroundColor = .blue
        return view
    }()
    
    let nameLable: UILabel = {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        lable.text = "CategoryCell Name Lable"
        return lable
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white

        
        //MARK: add views the the root view:
        addSubview(restaurantCollectionView)
        addSubview(nameLable)
        
        restaurantCollectionView.dataSource = self
        restaurantCollectionView.delegate = self
        
        // MARK: Register the cell:
        restaurantCollectionView.register(AlergiesCell.self, forCellWithReuseIdentifier: CellID)
        
        // MARK: add constraints to the views:
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": restaurantCollectionView]))
            
         addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": restaurantCollectionView]))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! AlergiesCell
        return collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height)
    }
}

class AlergiesCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .yellow
    }
}
