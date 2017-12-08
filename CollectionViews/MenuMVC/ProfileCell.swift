//
//  ProfileCell.swift
//  CollectionViews
//
//  Created by Mohsen Qaysi on 12/8/17.
//  Copyright © 2017 Mohsen Qaysi. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {

    let cellID = "CellID"
    
    let profileImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "Group")
        image.translatesAutoresizingMaskIntoConstraints = false // Very important
        image.backgroundColor = .clear
        image.layer.cornerRadius = 17
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let restaurantNameLable: UILabel = {
        let lable = UILabel(frame: .zero)
        lable.translatesAutoresizingMaskIntoConstraints = false // Very important
        lable.text = "Restaurant Name Lable"
        lable.font = .boldSystemFont(ofSize: 17)
        lable.numberOfLines = 2
        return lable
    }()
    
    let restaurantFoodtypeLable: UILabel = {
        let lable = UILabel(frame: .zero)
        lable.translatesAutoresizingMaskIntoConstraints = false // Very important
        lable.text = "Food and Coffee"
        lable.font = .systemFont(ofSize: 14)
        lable.textColor = .darkGray
        lable.numberOfLines = 2
        return lable
    }()
    
    let clockIconImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "clock")
        image.translatesAutoresizingMaskIntoConstraints = false // Very important
        image.backgroundColor = .clear
//        image.layer.cornerRadius = 17
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let daysANDhoursLable: UILabel = {
        let lable = UILabel(frame: .zero)
        lable.translatesAutoresizingMaskIntoConstraints = false // Very important
        lable.text = "Monday - Friday 12:30 - 5:30"
        lable.contentMode = .center
        lable.font = .systemFont(ofSize: 14)
        lable.textColor = .darkGray
        lable.numberOfLines = 2
        return lable
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false // Very important
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        addSubview(profileImage)
        addSubview(restaurantNameLable)
        addSubview(restaurantFoodtypeLable)
        addSubview(clockIconImage)
        addSubview(daysANDhoursLable)
        addSubview(dividerLine)
        
        // profileImage
        // TODO: look at the left edge constraint
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0(118)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : profileImage]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0(118)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : profileImage]))
        // profileImage END

        // restaurantNameLable
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-12-[v1]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : profileImage, "v1": restaurantNameLable]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : restaurantNameLable]))
        // profileImage END

        // Served with
         addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-12-[v2]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : profileImage, "v2": restaurantFoodtypeLable]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1]-2-[v2]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : restaurantNameLable,"v2": restaurantFoodtypeLable]))
        // END

        // Clock icon
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-12-[v3(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : profileImage, "v3": clockIconImage]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v2]-8-[v3(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v2" : restaurantFoodtypeLable,"v3": clockIconImage]))
        // END
        
        // daysANDhoursLable
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v3]-12-[v4(124)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v3" : clockIconImage, "v4": daysANDhoursLable]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v3]-8-[v4(40)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v3" : restaurantFoodtypeLable,"v4": daysANDhoursLable]))
        // END
        
        // Divider Line 
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-24-[v5]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v5": dividerLine]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v5(0.5)]-2-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v5": dividerLine]))
        // END
        
    }
}
