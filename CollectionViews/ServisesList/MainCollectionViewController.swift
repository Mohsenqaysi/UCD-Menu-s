//
//  MainCollectionViewController.swift
//  CollectionViews
//
//  Created by Mohsen Qaysi on 12/8/17.
//  Copyright © 2017 Mohsen Qaysi. All rights reserved.
//

import UIKit
import Kingfisher

private let cellID = "Cell"
private let mocky_URL = "http://www.mocky.io/v2/5a2420622e0000510a83bf5a"

class MainCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var newArry = [Services]()
    let reloadIcon = UIImage(named: "reload")
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: reloadIcon, style: UIBarButtonItemStyle.plain, target: self, action: #selector(FromTheServer))

        collectionView?.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView?.contentInset = UIEdgeInsetsMake(8, 0, 0, 0)
        
        setDate()
        setActivityindeicator()
        self.collectionView!.register(ResturantLogoCell.self, forCellWithReuseIdentifier: cellID)
        loadDataFromTheServer()
    }
    
    @objc func FromTheServer() {
         loadDataFromTheServer()
    }
    
    func loadDataFromTheServer() {
        self.loader.startAnimating()
        
        newArry.removeAll()
        guard let url = URL(string: mocky_URL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // check for errors
            if error != nil {
                print(String(describing: error?.localizedDescription))
            } else {
                // check the response
                //                print("response: \(String(describing: response?.url))")
                // Use the data
                guard let data = data else { return }
                do {
                    let broker = try JSONDecoder().decode(Broker.self, from: data)
                    for service in broker.services {
//                        dump(service)
                        self.newArry.append(service)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.collectionView?.reloadData()
                        self.loader.stopAnimating()
                    })
                    
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
            }
            }.resume() // to fire it off
    }
    
    // MARK: Programmtically created Views
    
    let loderStatusLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Loading..."
        lb.textAlignment = .center
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        return lb
    }()
    
    let loader: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.layer.cornerRadius = 14
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.backgroundColor = UIColor.darkGray
        spinner.layer.opacity = 0.9
        return spinner
    }()
    
    func setDate() {
        // MARK Add the date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy" // HH:mm:ss
        let result = formatter.string(from: date)
        
        // Set prompt and Title
        self.navigationItem.prompt = "\(result)"
        self.navigationItem.title = "Today Menu"
        
    }
    
    func setActivityindeicator() {
        // The loader to the root view
        self.view.addSubview(loader)
        // MARK: add loderStatusLabel to the Loder indecator
        loader.insertSubview(loderStatusLabel, aboveSubview: loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // add constraint to loderStatusLabel
        let w = CGFloat().getScreenWidth()
        let h = CGFloat().getScreenHeight()
        
        _ = loader.anchor(top: nil, left: nil, bottom: nil, right: nil, topConstant: h/4, leftConstant: w/4, bottomConstant: h/4, rightConstant: w/4, widthConstant: 150, heightConstant: 100)
        
        _ = loderStatusLabel.anchor(top: nil, left: loader.leftAnchor, bottom: loader.bottomAnchor, right: loader.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 0)
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
        return newArry.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ResturantLogoCell

        // MARK: the data loding is very fast ... add delay to make the UI look nicer
        UIView.animate(withDuration: 0.5, animations: {
            self.loader.stopAnimating()
        }, completion: nil)
        
        let logo = newArry[indexPath.item].logo_URL
        let urlImage = URL(string: logo)!
        print(urlImage)
        cell.logoImageView.kf.setImage(with: urlImage)
        cell.restaurantNameLable.text = newArry[indexPath.item].title
        
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
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : logoImageView]))
        // END
        
        // restaurantNameLable
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-28-[v1]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : restaurantNameLable]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1]-48-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : restaurantNameLable]))
        // END
        
        self.logoImageView.clipsToBounds = true
        self.logoImageView.layer.cornerRadius = 14
    }
}
