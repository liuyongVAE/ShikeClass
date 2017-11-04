//
//  IndexViewController.swift
//  shikeClass
//
//  Created by ly on 2017/10/30.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import CoreLocation


class IndexViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate{
    
    
    fileprivate let Mview = MineView()
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    fileprivate let tableview:UITableView = UITableView()
    fileprivate var dataSource:[String:[String]] = [
        "name":[],
        "time":[],
        "position":[],
        "status":[],
        "id":[]
    ]

    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    fileprivate func  setUI(){

        self.navigationItem.title = "时课"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = naviColor
        
        // 添加个人中心按钮
        let item = UIBarButtonItem(image:#imageLiteral(resourceName: "bottom_icon5"),style:.plain,target:self,action:#selector(touchMine))
        self.navigationItem.leftBarButtonItem = item
        
        //个人中心选单
        
        
        self.viewReturn.addSubview(Mview.topBackview)
        self.viewReturn.addSubview(Mview.bottomView)
        
        
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
    
    
    //MARK: - 点击个人中心
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
    
    
    var offsetX:CGFloat = 0
    @objc func viewSwip(sender: UISwipeGestureRecognizer){
        if sender.direction == UISwipeGestureRecognizerDirection.right{
            self.viewLeft.transform = CGAffineTransform.init(translationX: -SCREEN_WIDTH, y: 0)
        }
        
    }
    
  
    let viewLeft = UIView();
    let viewReturn = UIView();
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
        gesture.addTarget(self, action: #selector(viewSwip(sender:)))
       // viewReturn.addGestureRecognizer(gesture)
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
        switch btn.tag {
        case 0:
            let layout = UICollectionViewFlowLayout()
            self.navigationController?.pushViewController(LessonCollectionViewController(collectionViewLayout:layout), animated: true)
            print("lessonSheet")
        case 1:
            print("myfile")
        case 2:
            print("mySign")
        case 3:
            print("setting")
        default:
            return
        }
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  // MARK: -  tableview
    
    func setTV(){
        self.tableview.frame = self.view.frame
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.view.addSubview(tableview)
        tableview.backgroundColor = backColor
        //let cellnib = UINib(nibName:"IndexTableViewCell",bundle:nil)
        //tableview.register(cellnib, forCellReuseIdentifier: "index")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource["id"]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell : IndexTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "index") as! IndexTableViewCell
        
        let cell = IndexTableViewCell(style:.default,reuseIdentifier:"cell")
        cell.selectionStyle = .none
        cell.ClassName.text = self.dataSource["name"]?[indexPath.row]
        cell.time.text = self.dataSource["time"]?[indexPath.row]
        cell.location.text = self.dataSource["position"]?[indexPath.row]
        cell.SignButton.setTitle("立即\n签到", for: .normal)
        cell.fileButton.tag = indexPath.row
        cell.fileLabel.text = (self.dataSource["name"]?[indexPath.row])! + "  课件"
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
    
    
    
    
    // MARK: - 网络请求
    
        func request(){
             self.dataSource["id"]?.append("1233")
            self.dataSource["name"]?.append("高等数学A（一）")
            self.dataSource["time"]?.append("周一 上午8：00-9:50")
            self.dataSource["position"]?.append("E4-102")
            self.dataSource["id"]?.append("1233")
            self.dataSource["name"]?.append("高等数学A（一）")
            self.dataSource["time"]?.append("周一 上午8：00-9:50")
            self.dataSource["position"]?.append("E4-102")
            self.dataSource["id"]?.append("1233")
            self.dataSource["name"]?.append("高等数学A（一）")
            self.dataSource["time"]?.append("周一 上午8：00-9:50")
            self.dataSource["position"]?.append("E4-102")
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
