//
//  DataModel.swift
//  UCD Menus
//
//  Created by Mohsen Qaysi on 12/3/17.
//  Copyright © 2017 Mohsen Qaysi. All rights reserved.
//

import Foundation

var mocky_URL = "http://localhost:9000/menus"

// MARK: Cells Idenifiers
struct Idenifiers {
    static let MainViewRootCellID = "Cell"
    static let MainViewNibCellID = "mainViewNibCellID"
    static let SegueID = "SegueID"
    static let TopMenuTableViewCell = "topMenuTableViewCell"
    static let TopMenuTableVieRootwCell = "Cell"
    static let BottomMenuTableViewCell = "bottomMenuTableViewCell"
    static let AlergiesCollectionViewCell = "alergiesCollectionViewCell"
}

// MARK: JSON Structures Models

struct Broker: Decodable {
    let services:[Services]
}
struct Services: Decodable {
    let id: Int
    let title: String
    let type: String
    let logo_URL: String
    let opening_hours: String
    let opening_days: String
    let menu: [Menu]
}
struct Menu: Decodable {
    let name: String
    let servedwith: String
    let cost: Double
    let calories: Int
    let alergies:[String]
}

struct Alergies: Decodable {
    let alergies: [[String: String]]
}
