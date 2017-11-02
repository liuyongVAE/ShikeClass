//
//  AppDelegate.swift
//  shikeClass
//
//  Created by ly on 2017/10/30.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let state  = UIApplication.shared.applicationState

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = IndexViewController()
        self.window?.rootViewController = UINavigationController(rootViewController:vc)
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = UIColor.white
        // Override point for customization after application launch.
        
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        print("程序挂起");
//        let state  = UIApplication.shared.applicationState
//        print(state.rawValue)
//        if state == .inactive{
//
//        }else if state == .background{
//            let ScreenBrightness = UIScreen.main.brightness
//            print(ScreenBrightness)
//            if ScreenBrightness > 0.0
//            {
//
//            }else{
//
//                print("lock")
//            }
//        }
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        if self.didUserPressLockButton() {
            //User pressed lock button
            print("Lock screen.")
        }
        else {
            print("Home.")
            //user pressed home button
        }
        
        // print("进入后台");
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("重新唤醒")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("应用杀死")
    }
    
    func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {

        //print("锁屏")  //只有在设置密码后才能用
    }
    
    func didUserPressLockButton()->Bool{
        //
        let oldBrightness = UIScreen.main.brightness
        //
        UIScreen.main.brightness =  oldBrightness + (oldBrightness <= 0.01 ? (0.01) : (-0.01))
        let newBrightness = UIScreen.main.brightness
        //
        UIScreen.main.brightness = oldBrightness;
        return oldBrightness != newBrightness;
        
        
    }
  


}

