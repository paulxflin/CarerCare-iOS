//
//  AppDelegate.swift
//  GapdarMyPages
//
//  Created by localadmin on 07/12/2019.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    let defaults = UserDefaults.standard


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        //let someDelegate = stepController()
        //UNUserNotificationCenter.current().delegate = someDelegate
        
        //Setting the First View Controller
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let barSB : UIStoryboard = UIStoryboard(name: "MenuTabBar", bundle: nil)
        
        if (defaults.bool(forKey: "setup") == false) {
            let initialVC = mainSB.instantiateViewController(withIdentifier: "Setup")
            self.window?.rootViewController = initialVC
        } else {
            let barVC = barSB.instantiateViewController(withIdentifier: "tabBar")
            self.window?.rootViewController = barVC
        }
        
        self.window?.makeKeyAndVisible()
        
        //Setting Tab Appearance
        UITabBar.appearance().barTintColor = .black
        UITabBar.appearance().tintColor = .red
        // Override point for customization after application launch.
        
        //Background Fetch as quickly as possible (3600 for once an hour)
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let vc = stepController()
        vc.nudge()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("I did receive a response")
        completionHandler()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

