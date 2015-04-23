//
//  AppDelegate.swift
//  Playground
//
//  Created by George Yamana on 21/04/2015.
//  Copyright (c) 2015 localz. All rights reserved.
//

import CryptoSwift
import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//      let encrypted = "8b99b66942f2d1724b2242ef7d16755b:57d10cc4f417871f95acbc9cb8056e5d"

        let encrypted = "9401b2d4a94beb28a231adf7fe8577ca:6602b861f8ea732119bafddeef54605b15172cba03cbe29b3ea422446a9b46e6b4bebc5418c0bedb4afaf6367e475518883d7e3bbd806271fd550e4d2d1e78c78173b4a6e97538e04b17e713592c55edb836a0fb6ed0713b9a4992713a0829129a9116cb5d1c0b46c6a57e08302b88e3"

        let key = "FAC3104855E94B2AB7F51D5241EBF314"
        println(Decrypt.decryptHexString(encrypted, keyHexString: key))
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

