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
       // window?.rootViewController = IndexViewController()
      // self.window?.rootViewController = vc
        let vc  = IndexViewController()
        self.window?.rootViewController = CusTomTabBar() //UINavigationController(rootViewController:self.CusTomTabBar())
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
    
    
    func  sendMessageOfLeave(){
        //创建NSURL对象
        let url:URL! = URL(string: "https://www.baidu.com")
        //创建请求对象
        let urlRequest:NSURLRequest = NSURLRequest.init(url: url)
        //响应对象
        var response:URLResponse?
        
        do{
            //发送请求
            let data:NSData? = try NSURLConnection.sendSynchronousRequest(urlRequest as URLRequest,
                                                                          returning: &response) as NSData as NSData
            let str = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
            print(str)
            
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
        }
        
        
    }
    
    
    func CusTomTabBar() ->UITabBarController{
        let vc1 = IndexViewController()
        let vc2 = LessonCollectionViewController.init(collectionViewLayout: UICollectionViewFlowLayout.init())
        let vc3 = MyFileTableViewController()
        // let vc5 = IndexViewController()
        
        
        let nvc1:UINavigationController = UINavigationController(rootViewController: vc1)
        let nvc2:UINavigationController = UINavigationController(rootViewController: vc2)
        let nvc3:UINavigationController = UINavigationController(rootViewController: vc3)
        
       // nvc2.navigationItem.title = "课程表"
       // nvc3.navigationItem.title = "文件"
        
       // let nvc4:UINavigationController = UINavigationController(rootViewController: vc4)
        //let nvc5:UINavigationController = UINavigationController(rootViewController:vc5)
        
        let tabbar1 = UITabBarItem(title: "首页", image: UIImage(named:"首页"), selectedImage:  UIImage(named:"首页"))
        // tabbar1.imageInsets = UIEdgeInsetsMake(getHeight(25), width(25), getHeight(25), width(25))
        let tabbar2 = UITabBarItem(title: "课程", image: UIImage(named:"课程表"), selectedImage:  UIImage(named:"课程表"))
        let tabbar3 = UITabBarItem(title: "文件",image: UIImage(named:"文件"), selectedImage:  UIImage(named:"文件"))
       // let tabbar4 = UITabBarItem(title: "我的", image: UIImage(named:"bottom4"), selectedImage:  UIImage(named:"bottom4"))
        nvc1.tabBarItem = tabbar1;
        nvc2.tabBarItem = tabbar2;
        nvc3.tabBarItem = tabbar3;
        //nvc4.tabBarItem = tabbar4;
        let tc = UITabBarController()
        tc.tabBar.tintColor = naviColor
        tc.viewControllers = [nvc1,nvc2,nvc3]
        // tc.tabBar.backgroundImage = Public.getImgView("3.png")tc.viewControllers = [nvc1,nvc2,nvc3,nvc4,nvc5];return tc;
        return tc
    }
    
  


}

