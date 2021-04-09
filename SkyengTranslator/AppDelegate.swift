//
//  AppDelegate.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 07.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import UIKit
import SkyengTranslatorFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let searchService = SearchService()
        let model = SearchModel(service: searchService)
        let rootNavController = UINavigationController(rootViewController: SearchViewController(model: model))
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavController
        window?.makeKeyAndVisible()
        
        return true
    }

}
