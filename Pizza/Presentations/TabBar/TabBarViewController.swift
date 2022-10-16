//
//  TabBar.swift
//  Pizza
//
//  Created by Yulya Greshnova on 15.10.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        createViewControllers()
    }
    
    private func createViewControllers() {
        let menuViewController = MenuAssembly().buildViewController()
        let contactsViewController = OtherViewController()
        let profileViewController = OtherViewController()
        let busketViewController = OtherViewController()
        
        self.viewControllers = [menuViewController,
                                contactsViewController,
                                profileViewController,
                                busketViewController]
        
        self.tabBar.tintColor = .accentRed

        menuViewController.tabBarItem = .init(title: "Меню",
                                              image: UIImage(named: "menu"),
                                              selectedImage: nil)

        contactsViewController.tabBarItem = .init(title: "Контакты",
                                                   image: UIImage(named: "contacts"),
                                                   selectedImage: nil)
        
        profileViewController.tabBarItem = .init(title: "Профиль",
                                                 image: UIImage(systemName: "person"),
                                                 selectedImage: nil)
 
        busketViewController.tabBarItem = .init(title: "Корзина",
                                                image: UIImage(named: "busket"),
                                                selectedImage: nil)
    }
}
