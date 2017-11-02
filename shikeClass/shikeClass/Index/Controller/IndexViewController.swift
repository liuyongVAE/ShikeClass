//
//  IndexViewController.swift
//  shikeClass
//
//  Created by ly on 2017/10/30.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    fileprivate let tableview:UITableView = UITableView()
    fileprivate var dataSource:[String:[String]] = [
        "name":[],
        "time":[],
        "position":[],
        "status":[],
        "id":[]
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        self.setUI()
        self.setTV()
        
        UIScreen.main.brightness = 1
        print(UIScreen.main.brightness)
        // Do any additional setup after loading the view.
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
    }
    
    
    //点击个人中心
    @objc func  touchMine(){}
    

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
