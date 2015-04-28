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

        let encrypted = "062d01c237a140f1c036fb3855adb18e:1c666788a98a4eb3cf3e421de52bfad04491eb30a8904fb042630f668a56782df7dbc6369c4d2f3159ad06f42034ab2d3356595ac4feba9f6ea014ffbe6019e9b5f455a93c3f45b447a7835f0440eae147fb6a88f6866a015f9866bc29cd68842561b83d80fdf8603760f15cbfcb862d"

        let key = "FAC3104855E94B2AB7F51D5241EBF314"
        println(Decrypt.decryptHexString(encrypted, keyString: key))
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

