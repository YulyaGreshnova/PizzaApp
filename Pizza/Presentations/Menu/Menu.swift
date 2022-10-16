//
//  Menu.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import Foundation

struct MenuModel {
    let banners: [Banner]
    let menu: [Menu]
}

struct Banner {
    let name: String
}

struct Menu {
    let id: String
    let name: String
    let positions: [Position]
}

struct Position: Equatable {
    let imagePath: String
    let name: String
    let ingridients: String
    let price: String
}


