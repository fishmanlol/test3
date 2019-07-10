//
//  AppDelegate.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/3/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let navController = UINavigationController(rootViewController: ViewController())
        let rootViewController = navController
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
     
        return true
    }
    
    func getVisbleViewController() -> UIViewController? {
        guard let rootVC = window?.rootViewController else { return nil }
        
        guard let presented = rootVC.presentedViewController else {
            return rootVC
        }
        
        if let navController = presented as? UINavigationController,
            let topController = navController.topViewController {
            return topController
        }
        
        if let tabController = presented as? UITabBarController,
            let selectedController = tabController.selectedViewController {
            return selectedController
        }
        
        return nil
    }
}

