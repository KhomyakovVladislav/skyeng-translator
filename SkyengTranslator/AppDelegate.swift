//
//  AppDelegate.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 07.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootNavController = UINavigationController(rootViewController: UIViewController())
        window?.rootViewController = rootNavController
        window?.makeKeyAndVisible()
        
        return true
    }

}
