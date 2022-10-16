//
//  PizzaListsAssembly.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import UIKit

final class MenuAssembly {
    func buildViewController() -> UIViewController {
        let router = MenuRouter()
        let provider = MenuProvider()
        let presenter = MenuPresenter(router: router, menuProvider: provider)
        let viewController = MenuViewController(presenter: presenter)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
