//
//  MainCollectionViewController.swift
//  CollectionViews
//
//  Created by Mohsen Qaysi on 12/8/17.
//  Copyright © 2017 Mohsen Qaysi. All rights reservedvar/

import UIKit
import Kingfisher

private let cellID = "Cell"

class MainCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var newArry = [Services]()
    let reloadIcon = UIImage(named: "reload")
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: reloadIcon, style: UIBarButtonItemStyle.plain, target: self, action: #selector(FromTheServer))
        
        collectionView?.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView?.contentInset = UIEdgeInsetsMake(16, 0, 0, 0)
        
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
                debugPrint(String(describing: error?.localizedDescription))
                self.showAlert()
            } else {
                guard let data = data else { return }
                do {
                    let broker = try JSONDecoder().decode(Broker.self, from: data)
                    
                    for service in broker.services {
                        dump(service)
                        self.newArry.append(service)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.collectionView?.reloadData()
                        self.loader.stopAnimating()
                    })
                } catch let jsonErr {
                    debugPrint("Error serializing json:", jsonErr)
                    self.showAlert()
                }
            }
            }.resume() // to fire it off
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: "URl Error", message: "The Server JSON URL is not Working Please Enter The New One\n and make sure the link start with http://", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            let input: UITextField = (alertController.textFields?[0])!
            
            if (input.text?.hasPrefix("http"))! {
                print("textField %s", input)
                mocky_URL = input.text!
                self.loadDataFromTheServer()
            } else{
                print("I am here 1")
                mocky_URL = ""
                self.showAlert()
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            alert -> Void in
            self.loader.stopAnimating()
        }))
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Enter The URL..."
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Programmtically created Views
    
    let loderStatusLabel: UILabel = {
        let lb = UILabel()
        lb.text = "LOADING"
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
        
        _ = loderStatusLabel.anchor(top: nil, left: loader.leftAnchor, bottom: loader.bottomAnchor, right: loader.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 0)
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showControllerForMenu(indexPath)
    }
    
    func showControllerForMenu(_ index: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        
        let menuViewController = CollectionViewController(collectionViewLayout: layout)
        menuViewController.passedArray = [newArry[index.item]]
        navigationController?.pushViewController(menuViewController, animated: true)
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
