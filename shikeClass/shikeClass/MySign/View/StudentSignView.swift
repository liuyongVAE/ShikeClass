//
//  StudentSignView.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/26.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

protocol StudentViewDelegate {
    func Push(vc:UIViewController)
    func Present(vc:UIAlertController)

    
}


class StudentSignView: UIView {
    
    open var delegate:StudentViewDelegate?
    
    lazy var tableview:UITableView = {
        let tableview = UITableView.init(frame: self.frame)
        tableview.dataSource = self
        tableview.delegate = self
        return tableview
    }()
    
    lazy  var titleView:UIView = {
       let view  = UIView.init(frame: FloatRect(0, 0, SCREEN_WIDTH, getHeight(120)))
        view.backgroundColor = backColor
        return view
    }()
    
    lazy var SelectButton:UIButton = {
        let button:UIButton = UIButton.init(frame:Rect(31, 25,330, 60) )
        button.setTitle("选择周数", for: .normal)
        button.addTarget(self, action: #selector(touchWeek), for: .touchUpInside)
        button.setTitleColor(title1Color, for: .normal)
        button.layer.cornerRadius = 2;
        button.layer.borderWidth = 1
        return button
    }()
    
    
    
    fileprivate var titles =  StudentModel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableview)
        titleView.addSubview(SelectButton)
        request(week: "")
       // request()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func touchWeek (){
        let drop = DropListView.init(frame:Rect(0, 120, 330, 80), arrData: ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"], completion: ({
            list in
            self.SelectButton.setTitle(list as String, for: .normal)
            self.request(week: list as String)
            //print(list)
        }))
        drop.tabWidth = getWidth(630)
        drop.tabOffset = 280
        drop.showList()
    
    }
    
    
    
    
    
    func request(week:String){
        var dic:[String:[String]] = ["name":[],"num":[],"status":[],"lesson_Id":[]]
        var params = ["sid":"","week":""]
        
        if let xm = UserDefaults.standard.string(forKey: "userNum"){
            params = ["student_id":"\(xm)","week":"\(week)"]
            
            let url = rootURL + "/shikeya/api/student_sign_week"
            
            AlaRequestManager.shared.postRequest(urlString: url, params: params as [String : AnyObject], success: ({
                js in
                
                //print(js)
                
                if  js["data"].count != 0{
                    for i in 0..<js["data"].count{
                        if let name = js["data"][i]["lesson_name"].string{
                            dic["name"]!.append(name)
                        }
                        if let name = js["data"][i]["exist"].string{
                            dic["status"]!.append(name)
                        }
                        
                        if let name = js["data"][i]["student_id"].string{
                            dic["num"]?.append(name)
                        }
                        if let name = js["data"][i]["lesson_id"].string{
                            dic["lesson_Id"]?.append(name)
                        }

                       print(dic)
                
                        
                    }
                    
                    
                }
                
                
                self.titles = StudentModel.init(dic: dic as [String : [AnyObject]])
               // print(dic,titles)
                self.tableview.reloadData()
                
                
                
            }), failture: ({
                error in
                
                print(error)
                
            }))
            
            
        }else{
            let AlertView = UIAlertController.init(title: "提示", message: "您未登录", preferredStyle: .alert)
            AlertView.addAction(UIAlertAction.init(title: "前往登录", style: .default, handler: ({
                al in
                  self.delegate?.Push(vc: LoginViewController())
            })))
            AlertView.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
            
            
            
        }
        
   
       // self.titles.append("","","")
        
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

extension StudentSignView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titles.num?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SignTableViewCell.init(style: .default, reuseIdentifier: "cell")
        
        if titles.status![indexPath.row] == "1"{
            cell.rightImage.backgroundColor = SignedColor
            cell.rightImage.text = "正\n常"
        }else{
            cell.rightImage.text = "旷\n课"
            cell.rightImage.backgroundColor = naviColor

        }
        
        cell.numLabel.text = titles.num?[indexPath.row]
        cell.TitleLabel.text = titles.name?[indexPath.row]
        cell.numLabel.sizeToFit()
        cell.TitleLabel.sizeToFit()
        
       
       
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(120);
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return getHeight(120)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return titleView
    }
    
    
    
    
    
}
