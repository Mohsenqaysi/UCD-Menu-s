//
//  CategoryCell.swift
//  CollectionViews
//
//  Created by Mohsen Qaysi on 12/7/17.
//  Copyright © 2017 Mohsen Qaysi. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .red
    }
}
