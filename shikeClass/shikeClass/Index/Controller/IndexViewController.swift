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
    
    //Model
    var characterInfo:[String:String]!
    var dataSource:IndexModel!
    //View
    let Mview = MineView()
    let viewLeft = UIView();
    let viewReturn = UIView();
    var offsetX:CGFloat = 0
    let locationManager:CLLocationManager = CLLocationManager()
    let tableview:UITableView = UITableView()
 
    
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
        self.setMineUI()
        self.setUI()
        self.setTV()

       
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
            self.characterInfo["userLabel"]! = "登录"
            self.Mview.topBackview.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchLogin))
            Mview.topBackview.addGestureRecognizer(tap)
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
            
            let url = rootURL + "/shikeya/api/lesson_search"
                let id = characterInfo["userNum"]!
                
                let paramete = ["student_id":"\(id)"]
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
                                if let ss = result[i]["start_time"].int{
                                    let t1 = self.timeFormat(ss)
                                    let t2 = self.timeFormat(result[i]["end_time"].int!)
                                    new["time"]?.append(t1+" - "+t2);
                                }
                                
                              }
                                
                            }else{
                                //如果没有课，添加默认数据；
                                new["id"]?.append("")
                                new["name"]?.append("今日暂无课程！");
                                new["time"]?.append(" ");
                                new["position"]?.append(" ");
                                self.characterInfo["isEmpty"] = "1"
                                
                                
                                

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





// MARK: -  tableview
extension IndexViewController:UITableViewDelegate,UITableViewDataSource{

    
    func setTV(){
        self.tableview.frame = FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.view.addSubview(tableview)
        tableview.backgroundColor = backColor
        let TapRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(touchMine))
       TapRecognizer.direction = .right
        tableview.isUserInteractionEnabled = true
        tableview.addGestureRecognizer(TapRecognizer)
        
        //let cellnib = UINib(nibName:"IndexTableViewCell",bundle:nil)
        //tableview.register(cellnib, forCellReuseIdentifier: "index")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.dataSource["id"]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell : IndexTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "index") as! IndexTableViewCell
        
        let cell = IndexTableViewCell(style:.default,reuseIdentifier:"cell")
        cell.selectionStyle = .none
        cell.ClassName.text = self.dataSource.dataSource["name"]?[indexPath.row]
        cell.time.text = self.dataSource.dataSource["time"]?[indexPath.row]
        cell.location.text = self.dataSource.dataSource["position"]?[indexPath.row]
        if self.characterInfo["isEmpty"] == "1"{
            cell.SignButton.isHidden = true
        }
        else  if self.characterInfo["character"]! == "tea"{
            cell.SignButton.setTitle("获取\n签到码", for: .normal)
        }else{
            cell.SignButton.setTitle("立即\n签到", for: .normal)
            
        }
        cell.fileButton.tag = indexPath.row
        cell.fileLabel.text = (self.dataSource.dataSource["name"]?[indexPath.row])! + "  课件"
        cell.fileLabel.sizeToFit()
        cell.SignButton.tag = indexPath.row
        cell.ClassName.sizeToFit()
        cell.time.sizeToFit()
        cell.location.sizeToFit()
        cell.SignButton.addTarget(self, action: #selector(didTouchSign(btn:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(263)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return getHeight(20)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let line = UIView()
        line.frame = CGRect(x:0,y:getHeight(0),width:SCREEN_WIDTH,height:getHeight(20))
        line.backgroundColor = backColor
        
        
        return line
    }
    
    
}








