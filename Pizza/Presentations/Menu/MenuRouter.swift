//
//  PizzaListsRouter.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import UIKit

protocol IPizzaListsRouter: AnyObject {
}

final class MenuRouter: IPizzaListsRouter {
    weak var viewController: UIViewController?
    
    func navigate() {
      // TODO: Add navigation if needed
    }
}
