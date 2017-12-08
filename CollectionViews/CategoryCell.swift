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
        view.backgroundColor = .clear
        return view
    }()
    let mealTypeImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "Group")
        image.translatesAutoresizingMaskIntoConstraints = false // Very important
        image.backgroundColor = .clear
        return image
    }()
    
    let alergiesLable: UILabel = {
        let lable = UILabel(frame: .zero)//CGRect(x: 0, y: 0, width: 200, height: 50))
        lable.translatesAutoresizingMaskIntoConstraints = false // Very important
        lable.text = "Allergies:"
        lable.font = .boldSystemFont(ofSize: 24)
        return lable
    }()
    
    let mealNameLable: UILabel = {
        let lable = UILabel(frame: .zero)//CGRect(x: 0, y: 0, width: 200, height: 50))
        lable.translatesAutoresizingMaskIntoConstraints = false // Very important
        lable.text = "Chicken Fillet ala Grecque"
        lable.font = .boldSystemFont(ofSize: 17)
        lable.numberOfLines = 2
        return lable
    }()
    
    let servedWithMealNameLable: UILabel = {
        let lable = UILabel(frame: .zero)//CGRect(x: 0, y: 0, width: 200, height: 50))
        lable.translatesAutoresizingMaskIntoConstraints = false // Very important
        lable.text = "Servedwith: Oregano, Tomato, Olive, Feta Cheese"
        lable.textColor = .darkGray
        lable.numberOfLines = 3
        return lable
    }()
    
    
    let priceBGView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false // Very important
        view.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        view.layer.cornerRadius = 16
        return view
    }()
    
    let priceLable: UILabel = {
        let lable = UILabel(frame: .zero)
        lable.translatesAutoresizingMaskIntoConstraints = false // Very important
        lable.text = "€5.95"
        lable.textColor = .white
        return lable
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false // Very important
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white
        
        //MARK: add views the the root view:
        addSubview(restaurantCollectionView)
        addSubview(mealTypeImage)
        addSubview(mealNameLable)
        addSubview(servedWithMealNameLable)
        addSubview(priceBGView)
        addSubview(priceLable)
        addSubview(alergiesLable)
        addSubview(dividerLine)
        
        // Center the cost lable using autoLayout constraint
        priceLable.centerXAnchor.constraint(equalTo: priceBGView.centerXAnchor).isActive = true
        priceLable.centerYAnchor.constraint(equalTo: priceBGView.centerYAnchor).isActive = true
        
        restaurantCollectionView.dataSource = self
        restaurantCollectionView.delegate = self
        
        // MARK: Register the cell:
        restaurantCollectionView.register(AlergiesCell.self, forCellWithReuseIdentifier: CellID)
        
        // MARK: add  constraints to  the mealNameLable:
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(50)]-16-[v1]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": mealTypeImage,"v1": mealNameLable]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(50)]-16-[v2]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": mealTypeImage,"v2": servedWithMealNameLable]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(50)]-16-[v2]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": mealTypeImage,"v2": servedWithMealNameLable]))
        
        // Cost BG view
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(50)]-16-[v3(73)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": mealTypeImage,"v3": priceBGView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v2]-2-[v3(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v2": servedWithMealNameLable,"v3": priceBGView]))
        // Cost BG view END
        
        // AlergiesLable
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v4]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4": alergiesLable]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-8-[v4(30)]-2-[v6]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": priceBGView,"v4": alergiesLable,"v6": restaurantCollectionView]))
        // alergiesLable END
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": mealTypeImage]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v1]-2-[v2]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": mealNameLable,"v2": servedWithMealNameLable]))
        
        // MARK: add  constraints to  the alergies collection views:
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-48-[v6]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v6": restaurantCollectionView]))
        
        // Divider Line
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-24-[v7]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v7": dividerLine]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v6(50)]-2-[v7(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v6": restaurantCollectionView, "v7": dividerLine]))
        
    }
    
}

extension CategoryCell {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! AlergiesCell
//        cell.alergiesImageView.image =  UIImage(named: "wheat")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}

class AlergiesCell: UICollectionViewCell {
    
    let alergiesImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "wheat")
        image.translatesAutoresizingMaskIntoConstraints = false // Very important
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(alergiesImageView)
        alergiesImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
    }
}
