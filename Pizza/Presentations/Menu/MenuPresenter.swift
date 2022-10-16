//
//  PizzaListsPresenter.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import Foundation

protocol IMenuPresenter: AnyObject {
    func viewLoaded()
    func chooseSection(section: String)
}

final class MenuPresenter: IMenuPresenter {
    weak var viewController: IMenuViewController?
    private let router: IPizzaListsRouter
    private let menuProvider: IMenuProvider
    private var menuModel: MenuModel?

    init(router: IPizzaListsRouter, menuProvider: IMenuProvider) {
        self.router = router
        self.menuProvider = menuProvider
    }
    
    func viewLoaded() {
        if let response = menuProvider.currentMenu {
            menuModel = createMenuModel(response: response)
        }
        guard let model = menuModel else { return }
        let bannerViewModel = model.banners.map{ BannerViewModel(name: $0.name) }
        let menuSectionsViewModel = model.menu.map { MenuSectionsViewModel(name: $0.name) }
        var menuItem = model.menu.flatMap{ $0.positions }.map { createMenuItemViewModel(variant: $0)}
        if var firstItem = menuItem.first {
            firstItem.isFirst = true
            menuItem[0] = firstItem
        }
        let viewModel = MenuViewModel(banners: bannerViewModel,
                                      menuSections: menuSectionsViewModel,
                                      menuItem: menuItem)
        viewController?.showPizzaViewModel(pizzaViewModels: viewModel)
    }
    
    func chooseSection(section: String) {
        if let model = menuModel {
            guard let menuIndex = model.menu.first (where: { $0.name == section } ) else { return }
            guard let firstItemInSection =  menuIndex.positions.first else { return }
            let allMenuItems = model.menu.flatMap{ $0.positions }
            guard let index = allMenuItems.firstIndex(where: { $0 == firstItemInSection }) else { return }
            viewController?.scrollViewTo(index: index)
        }
    }
}

//MARK: - PrivateFunctions
private extension MenuPresenter {
    func createMenuModel(response: MenuNetworkResponse) -> MenuModel {
        let banners = response.banners.map { Banner(name: $0.name)}
        
        let menu = response.menu.map { createMenu(menuResponse: $0)}
        return MenuModel(banners: banners,
                         menu: menu)
    }
    
    func createVariants(responseVariants: VariantsResponse) -> Position {
        return Position(imagePath: responseVariants.imageUrl,
                 name: responseVariants.name,
                 ingridients: responseVariants.ingridients,
                 price: responseVariants.price)
    }
    
    func createMenu(menuResponse: MenuResponse) -> Menu {
        let variants = menuResponse.variants.map { createVariants(responseVariants: $0)}
        return Menu(id: menuResponse.id,
                    name: menuResponse.name,
                    positions: variants)
    }
    
    func createMenuItemViewModel(variant: Position) -> MenuItemViewModel {
        MenuItemViewModel(imageUrl: variant.imagePath,
                          name: variant.name,
                          ingridients: variant.ingridients,
                          price: variant.price)
    }
}
