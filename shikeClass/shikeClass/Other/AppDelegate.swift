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
        self.window?.rootViewController = MyTabViewController() //UINavigationController(rootViewController:self.CusTomTabBar())
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
            
            self.sendMessageOfLeave(status: "2")
            print("Home.")
            //user pressed home button
        }
        
        // print("进入后台");
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        sendMessageOfLeave(status: "1")
        print("重新唤醒")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        sendMessageOfLeave(status: "2")
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
    
    
    
    
    
    func testLessonStatus()->Bool{
        
        let now = Date()
        // 创建一个日期格式器
        
        let m = UserDefaults.standard
        if let ss = m.string(forKey: "signTime"){
            //let interval = TimeInterval.init(Int(ss)!)
            //let m = Date.init(timeIntervalSinceNow: interval);
            //print(interval)
            //print(m)
            
        }
        
        
        return true
    }
    
    
    
    
    
    
    func  sendMessageOfLeave(status:String){
        //判断当前是否为下课时间 用当前时间 - 签到时间
       testLessonStatus()
        //创建NSURL对象
        //改变学生的签到状态‘
        
        let params:[String:String] = {
            let m = UserDefaults.standard
            if let ss = m.string(forKey: "nowLesson"){
                return ["student_id":m.string(forKey: "userNum")!,"lesson_id":"\(ss)","exist":status]
            }else{
                return ["student_id":""]
            }
        }()
        
        let list = NSMutableArray()
        for i in params{
            let temstr = i.key+"="+i.value
            list.add(temstr)
        }
        let paramStr = list.componentsJoined(by: "&")
        
        let paraData = paramStr.data(using: .utf8)

        let urlString =  rootURL + "/shikeya/api/changeStatus"
        
        
        let url:URL! = URL(string: urlString)
        //创建请求对象
        var urlRequest:URLRequest = URLRequest.init(url: url)
        urlRequest.httpBody = paraData
        urlRequest.httpMethod = "POST"
        print(urlRequest)
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
    
    

    
  


}

