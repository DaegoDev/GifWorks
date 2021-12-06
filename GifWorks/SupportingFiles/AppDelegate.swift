//
//  AppDelegate.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 4/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let tabBarController = DashboardViewController()
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
    return true
  }
}

