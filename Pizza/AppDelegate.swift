//
//  AppDelegate.swift
//  Pizza
//
//  Created by Yulya Greshnova on 13.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = TabBarViewController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true       
    }
}

