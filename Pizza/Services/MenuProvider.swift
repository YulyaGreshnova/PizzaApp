//
//  MenuProvider.swift
//  Pizza
//
//  Created by Yulya Greshnova on 15.10.2022.
//

import Foundation

protocol IMenuProvider: AnyObject {
    var currentMenu: MenuNetworkResponse? { get }
}

final class MenuProvider: IMenuProvider {
    var currentMenu: MenuNetworkResponse?
    
    init() {
        fetchMenu()
    }

    private func fetchMenu() {
        guard let url = Bundle.main.url(forResource: "menu", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decode = JSONDecoder()
            currentMenu = try decode.decode(MenuNetworkResponse.self, from: data)
        } catch {
            print("MenuProvider fetch all response error: \(error.localizedDescription)")
        }
    }
}
