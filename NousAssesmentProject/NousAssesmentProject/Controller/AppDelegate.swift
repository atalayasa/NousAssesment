//
//  AppDelegate.swift
//  NousAssesmentProject
//
//  Created by Atalay Asa on 20.09.2019.
//  Copyright © 2019 Atalay Asa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC: UIViewController = MainVC()
        let navController = UINavigationController(rootViewController: mainVC)
        navController.navigationBar.isTranslucent = false
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        return true
    }
}

