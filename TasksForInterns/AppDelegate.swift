//
//  AppDelegate.swift
//  Tets Table
//
//  Created by Даниил Гетманцев on 09.06.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navVc = UINavigationController(rootViewController: InfoViewController())
        let splashVcNav = UINavigationController(rootViewController: SplachViewController())
        window?.rootViewController = splashVcNav
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.window?.rootViewController = navVc
                }
        return true
    }
    
    var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }
    
}

