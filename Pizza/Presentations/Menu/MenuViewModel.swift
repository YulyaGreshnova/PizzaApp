//
//  MenuViewModel.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import Foundation

struct MenuViewModel {
    let banners: [BannerViewModel]
    let menuSections: [MenuSectionsViewModel]
    let menuItem: [MenuItemViewModel]
}

struct MenuSectionsViewModel {
    let name: String
}

struct BannerViewModel {
    let name: String
}

struct MenuItemViewModel {
    let imageUrl: String
    let name: String
    let ingridients: String
    let price: String
    var isFirst = false
}
