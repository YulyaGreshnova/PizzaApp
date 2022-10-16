//
//  MenuResponse.swift
//  Pizza
//
//  Created by Yulya Greshnova on 15.10.2022.
//

import Foundation

struct MenuNetworkResponse: Decodable {
    let banners: [BannerResponse]
    let menu: [MenuResponse]
}

struct BannerResponse: Decodable {
    let name: String
}

struct MenuResponse: Decodable {
    let id: String
    let name: String
    let variants: [VariantsResponse]
}

struct VariantsResponse: Decodable {
    let imageUrl: String
    let name: String
    let ingridients: String
    let price: String
}
