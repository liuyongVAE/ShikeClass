//
//  IndexViewController.swift
//  shikeClass
//
//  Created by ly on 2017/10/30.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SVProgressHUD

class IndexViewController: UIViewController,CLLocationManagerDelegate{
    
    
    
    //测试位置Label、
    lazy var locaLabel:UILabel = {
        let label = UILabel.init(frame: FloatRect(0, 100, 300, 100))
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.orange
        label.text = "location"
        return label
    }()
    
    
    //Model
    var characterInfo:[String:String]!
    var dataSource:IndexModel!
    var signCode:String?
    //View
    let Mview = MineView()
    let viewLeft = UIView();
    let viewReturn = UIView();
    var offsetX:CGFloat = 0
    let locationManager:CLLocationManager = CLLocationManager()
    let tableview:UITableView = UITableView()
   //今日无课
    lazy var defaultView:UIView = {
        let dd = UIView(frame:self.tableview.frame)
        dd.backgroundColor = UIColor.white
        let def = UIImageView.init(frame: FloatRect(SCREEN_WIDTH/10, 0, SCREEN_WIDTH*4/5, SCREEN_HEIGHT*4/5))
        
        let random = Int(arc4random()%3)+1
        let str =  "今日无课"+"\(random)"
        def.image = UIImage.init(named: str)
        dd.addSubview(def)
        
        return dd
    }()
    
    
 
    
    override func viewWillAppear(_ animated: Bool) {

    }
    override func viewDidDisappear(_ animated: Bool) {
       // self.dataSource.dataSource.removeAll()
        
    }
    
    override func viewDidLoad() {
    
        
        
        
        super.viewDidLoad()
        dataSource = IndexModel.init()
        readInfo()
        request()
        self.setUI()
        self.setTV()
        self.setMineUI()

        
        //self.tableview.addSubview(locaLabel)
       
        getLocation()
       // UIScreen.main.brightness = 1
       // print(UIScreen.main.brightness)
        // Do any additional setup after loading the view.
    }
    

    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.touchReturn()
    }
    //读取用户信息
    
    func readInfo(){
    
        self.characterInfo = [
        "character":"",
        "userLabel":"",
        "userNum":"",
        "isLogin":"",
        "isEmpty":""
        ]
        let usd = UserDefaults.standard
        if let ss = usd.string(forKey: "character"){
            self.characterInfo["character"]! = ss
        }
        
        //读取不到就是未登录状态
        if let ss = usd.string(forKey: "userNum"){
            self.characterInfo["userNum"]! = ss
            self.characterInfo["isLogin"] = "1"
        }else{
            self.Mview.NumLabel.text = "  点击头像登录"
            Mview.NumLabel.sizeToFit()
            self.Mview.MineImage.isUserInteractionEnabled = true
            self.Mview.topBackview.isUserInteractionEnabled = true

            let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchLogin))
            Mview.topBackview.addGestureRecognizer(tap)
            Mview.MineImage.addGestureRecognizer(tap)
            //self.isLogin = false;
            
        }
        if let ss = usd.string(forKey: "userLabel"){
            self.characterInfo["userLabel"]! = ss
        }
        
    }
    
    
   
    
    //MARK: -  定位相关
    
    func  getLocation(){
    
        showEventAcessDeniedAlert()
        locationManager.delegate = self
        //精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.distanceFilter = 100
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            print("定位开始")
            
        }
    }
    //检测定位权限
    func showEventAcessDeniedAlert(){
        
        if CLLocationManager.authorizationStatus() != .denied{
            
            print("拥有定位权限")
        }else{
            let alertController = UIAlertController(title:"请开启定位",message:"定位服务未开启，请进入系统设置>隐私>定位服务>打开开关，并允许App试用定位服务",preferredStyle:.alert)
            let setting = UIAlertAction(title:"设置",style:.default){
                (alertAction) in
                if let appsetting = NSURL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.open(appsetting as URL)
                }
                
            }
            
            let cancel = UIAlertAction(title:"取消",style:.cancel,handler:nil)
            alertController.addAction(setting)
            alertController.addAction(cancel)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currLocation = locations.last!
        print(currLocation.coordinate.latitude)
        print(currLocation.coordinate.longitude)
       // self.locaLabel.text = String(currLocation.coordinate.latitude) + "  " +  String(currLocation.coordinate.longitude)
        
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    // MARK: - 网络请求
    
        func request(){
            
            let url:String = {
                if self.characterInfo["character"] == "stu"{
                   return  rootURL + "/shikeya/api/lesson_search"
                }else{
                    return  rootURL + "/shikeya/api/teacher_lesson"
                }
            }()
            
            let id:String = {
                if self.characterInfo["character"] == "stu"{
                    return   self.characterInfo["userNum"]!
                }else if  self.characterInfo["character"] == "tea"{
                    return   UserDefaults.standard.string(forKey: "teacher_name")!
                }
                
               return ""
            }()
                
            let paramete:[String:String] = {
                if self.characterInfo["character"] == "stu"{
                    return   ["student_id":"\(id)"]
                }else{
                    return   ["teacher_name":"\(id)"]
                }
            }()// = ["student_id":"\(id)"]
                // print(paramete,url)
                
                Alamofire.request(url, method: .post,parameters:paramete).responseJSON(completionHandler: {
                    response in
                    if let al = response.response{
                        // print(al)
                        SVProgressHUD.dismiss(withDelay: 1.5)
                        
                    }else{
                        SVProgressHUD.showError(withStatus: "网络连接失败")
                    }
                    
                    var new =  self.dataSource.dataSource
                    for (key,_) in new{
                        new[key]?.removeAll()
                    }
                    
                
                    if let js = response.result.value{
                        let json = JSON(js)
                        print(json)
                        if json["status"].string! == "200"{
                            
                            let result = json["data"]

                            if json["data"].count>0{
                              for i in 0...json["data"].count-1{
                               if let ss = result[i]["lesson_id"].string{
                                    new["id"]?.append(ss);
                                    var mm = ss
                                   let index = mm.index(mm.startIndex, offsetBy: 3);
                                   mm =  mm.substring(from: index);
                                   new["position"]?.append(mm);
                                }
                                if let ss = result[i]["lesson_name"].string{
                                    new["name"]?.append(ss);
                                }
                                if let ss = result[i]["exist"].string{
                                    new["status"]?.append(ss);
                                }else
                                {
                                    new["status"]?.append("0");

                                }
                                
                                
                                if let ss = result[i]["start_time"].int{
                                    let t1 = self.timeFormat(ss)
                                    let t2 = self.timeFormat(result[i]["end_time"].int!)
                                    new["time"]?.append(t1+" - "+t2);
                                }
                                
                              }
                                
                            }else{
                                
                                
                                self.tableview.addSubview(self.defaultView)
                           
                                
                                
                                

                            }
                            // SVProgressHUD.showSuccess(withStatus: "")
                        }else{
                            
                            SVProgressHUD.showInfo(withStatus: json["data"].string!)
                            
                        }
                        
                        //刷新
                        self.dataSource = IndexModel.init(dic: new);
                        self.tableview.reloadData()
                        
                        
                    }
                    
                })
            
    }


}













