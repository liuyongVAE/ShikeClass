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
    fileprivate var characterInfo:[String:String] = [
        "character":"",
        "userLabel":"",
        "userNum":"",
        "isLogin":"",
        "isEmpty":""
    ]
    fileprivate var dataSource:IndexModel! = IndexModel.init()
    //View
    fileprivate let Mview = MineView()
    fileprivate let viewLeft = UIView();
    fileprivate let viewReturn = UIView();
    fileprivate var offsetX:CGFloat = 0
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    fileprivate let tableview:UITableView = UITableView()
 
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readInfo()
        request()
        self.setMineUI()
        self.setUI()
        self.setTV()
       
        getLocation()
        UIScreen.main.brightness = 1
        print(UIScreen.main.brightness)
        // Do any additional setup after loading the view.
    }
    

    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.touchReturn()
    }
    //读取用户信息
    
    func readInfo(){
    
        let usd = UserDefaults.standard
        if let ss = usd.string(forKey: "character"){
            self.characterInfo["character"]! = ss
        }
        
        //读取不到就是未登录状态
        if let ss = usd.string(forKey: "userNum"){
            self.characterInfo["userNum"]! = ss
            self.characterInfo["isLogin"] = "1"
        }else{
            //self.isLogin = false;
            
        }
        if let ss = usd.string(forKey: "userLabel"){
            self.characterInfo["userLabel"]! = ss
        }
        
    }
    
    
    
    fileprivate func  setUI(){
      
        
        self.navigationItem.title = "时课"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = naviColor
        
        // 添加个人中心按钮
        let item = UIBarButtonItem(image:#imageLiteral(resourceName: "bottom_icon5"),style:.plain,target:self,action:#selector(touchMine))
        item.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = item
        
        //个人中心选单
        
        self.viewReturn.addSubview(Mview.topBackview)
        self.viewReturn.addSubview(Mview.bottomView)
        print(characterInfo)
        Mview.NameLabel.text = self.characterInfo["userLabel"];
        Mview.NameLabel.sizeToFit()
        if characterInfo["character"] == "stu"{
        Mview.NumLabel.text = self.characterInfo["userNum"];
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
    
 
    @objc func didTouchSign(btn:UIButton){
        
        let alertController = UIAlertController(title:"提示",message:"请输入签到码",preferredStyle:.alert)
    
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addTextField(configurationHandler: ({
            (text:UITextField) in
                text.keyboardType = .numberPad
                text.placeholder = "签到码"
        }))
        
        let okAction = UIAlertAction(title:"确认",style:.default,handler:{
            action in
               let login = alertController.textFields?.first!
               print(login?.text)
        })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        

        self.present(alertController, animated: true, completion: nil)
        
    }
    //MARK: - 转换时间
    func timeFormat(_ tt:Int)->String{
        let date  =  Date.init(timeIntervalSince1970: TimeInterval(tt/1000))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
        
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
        self.tableview.frame = self.view.frame
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




//MARK: - 点击个人中心
extension IndexViewController{
    

    @objc func  touchMine(){
        // self.tableview.removeFromSuperview()
        UIView.animate(withDuration: 0.5, animations: {()-> Void in
            
            self.viewLeft.frame.origin.x = 0
            
        })
        
    }
    
    @objc func touchReturn(){
        
        //print("-----")
        UIView.animate(withDuration: 0.5, animations: {()-> Void in
            
            self.viewLeft.frame.origin.x = -SCREEN_WIDTH
            
        })
        
    }
    
    

    @objc func viewSwip(sender: UISwipeGestureRecognizer){
        if sender.direction == UISwipeGestureRecognizerDirection.left{
            touchReturn()
        }
        
    }
    
    
    
    func setMineUI(){
        
        //self.edgesForExtendedLayout = UIRectEdge(rawValue: UIRectEdge.RawValue(0))
        viewLeft.frame = CGRect(x:-SCREEN_WIDTH,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT)
        viewLeft.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        UIApplication.shared.windows.last?.addSubview(viewLeft)
        viewLeft.isUserInteractionEnabled = true
        
        let btn = UIButton(frame:  CGRect(x:2*SCREEN_WIDTH/3,y:0,width:2*SCREEN_WIDTH/3,height:SCREEN_HEIGHT))
        viewLeft.addSubview(btn)
        
        btn.addTarget(self, action: #selector(touchReturn), for: .touchUpInside)
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .left
        gesture.addTarget(self, action: #selector(viewSwip(sender:)))
        viewLeft.isUserInteractionEnabled = true
         viewLeft.addGestureRecognizer(gesture)
        // let tap = UITapGestureRecognizer()
        // tap.addTarget(self, action: #selector(touchReturn))
        // tap.numberOfTapsRequired = 1
        //viewLeft.addGestureRecognizer(tap)
        //        viewReturn.isUserInteractionEnabled = true
        //        viewReturn.addGestureRecognizer(tap)
        
        viewReturn.frame = CGRect(x:0,y:0,width:2*SCREEN_WIDTH/3,height:SCREEN_HEIGHT)
        viewReturn.backgroundColor = naviColor
        viewLeft.addSubview(viewReturn)
        
        //设置点击事件
        self.Mview.classBtn.addTarget(self, action: #selector(leftTouchFunc(btn:)), for: .touchUpInside)
        self.Mview.fileBtn.addTarget(self, action: #selector(leftTouchFunc(btn:)), for: .touchUpInside)
        self.Mview.signBtn.addTarget(self, action: #selector(leftTouchFunc(btn:)), for: .touchUpInside)
        self.Mview.settingBtn.addTarget(self, action: #selector(leftTouchFunc(btn:)), for: .touchUpInside)
        
    }
    
    //左侧按钮点击事件
    @objc func leftTouchFunc(btn:UIButton){
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil,action:nil)
        switch btn.tag {
        case 0:
            let layout = UICollectionViewFlowLayout()
            self.navigationController?.pushViewController(LessonCollectionViewController(collectionViewLayout:layout), animated: true)
            print("lessonSheet")
        case 1:
            self.navigationController?.pushViewController(MyFileTableViewController(), animated: true)
        case 2:
            print("mySign")
        case 3:
            print("setting")
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
            
        default:
            return
        }
        
    }
    
    
    

    
    
}


