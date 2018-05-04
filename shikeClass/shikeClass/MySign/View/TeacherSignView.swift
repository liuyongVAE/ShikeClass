//
//  StudentSignView.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/26.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit
import SVProgressHUD

class TeacherSignView: UIView {
    
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
    var lesson_id:String!
    var code:String!

    init(frame: CGRect,lesson_id:String,code:String) {
        super.init(frame: frame)
        self.addSubview(tableview)
        self.lesson_id = lesson_id
        self.code = code
        titleView.addSubview(SelectButton)
        request()
        // request()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func touchWeek (){
        let drop = DropListView.init(frame:Rect(0, 120, 330, 80), arrData: ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"], completion: ({
            list in
            self.SelectButton.setTitle(list as String, for: .normal)
            self.request()
            //print(list)
        }))
        drop.tabWidth = getWidth(630)
        drop.tabOffset = 280
        drop.showList()
        
    }
    
    
    
    
    
    func request(){
        var dic:[String:[String]] = ["name":[],"num":[],"status":[],"lesson_Id":[]]
        var params = ["lesson_id":""]
        
        if let xm = UserDefaults.standard.string(forKey: "userNum"){
            params = ["lesson_id":"\(self.lesson_id!)"]
            
            let url = rootURL + "/shikeya/api/find_student"
            
            AlaRequestManager.shared.postRequest(urlString: url, params: params as [String : AnyObject], success: ({
                js in
                
                //print(js)
                
                if  js["data"].count != 0{
                    for i in 0..<js["data"].count{
                        if let name = js["data"][i]["student_name"].string{
                            dic["name"]!.append(name)
                        }
                        if let name = js["data"][i]["exist"].string{
                            dic["status"]!.append(name)
                        }
                        
                        if let name = js["data"][i]["student_id"].string{
                            dic["num"]?.append(name)
                        }
                        if let name = js["data"][i]["class_id"].string{
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

extension TeacherSignView:UITableViewDelegate,UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titles.num?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SignTableViewCell.init(style: .default, reuseIdentifier: "cell")
        
        switch titles.status![indexPath.row] {
        case "1":
            cell.rightImage.backgroundColor = SignedColor
            cell.rightImage.text = "正\n常"
        case "0":
            cell.rightImage.backgroundColor = naviColor
            cell.rightImage.text = "旷\n课"
        case "2":
            cell.rightImage.backgroundColor = SignYellow
            cell.rightImage.text = "暂\n离"
        default:
            break
        }
        
        cell.numLabel.text = titles.num?[indexPath.row]
        cell.TitleLabel.text = titles.name?[indexPath.row]
        cell.numLabel.sizeToFit()
        cell.TitleLabel.sizeToFit()
        
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        AlertView.shared.showAlert(vc: delegate!, titles: "确定改变该学生的签到状态么", message: "", okMessage: "确定", complete: ({
            
            
            //改变学生的签到状态
            let params:[String:String] = {
                
                if self.titles.status![indexPath.row] == "1"{
                     return ["student_id":self.titles.num![indexPath.row],"lesson_id":"\(self.lesson_id!)","exist":"0"]
                }else{
                     return ["student_id":self.titles.num![indexPath.row],"lesson_id":"\(self.lesson_id!)","exist":"1"]
                }
            }()
            
            let url = rootURL + "/shikeya/api/changeStatus"
            
            AlaRequestManager.shared.postRequest(urlString: url, params: params as [String : AnyObject], success: ({
                js in
                print(js)
                
                SVProgressHUD.showSuccess(withStatus: "签到状态修改成功")
                self.request()
                
            }), failture: ({
                error in
                
                print(error)
                
            }))
            
            
            
        }))

        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(120);
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    
    
    
    
}

