//
//  Extension.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/25.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

//签到操作
extension IndexViewController{
    
    
    func saveDateNow(){
        
        let now = Date()
        // 创建一个日期格式器
        let nn = String(now.timeIntervalSince1970)
        UserDefaults.standard.set(nn, forKey: "signTime")
        
        
    }
    
    
    
    @objc func didTouchSign(btn:UIButton){
        
//        if !btn.isSelected{
//            btn.isEnabled = false
//        }else{
//            return
//        }
        
        
        let tag = btn.tag
        if self.characterInfo["character"] == "stu"{
 
        let alertController = UIAlertController(title:"提示",message:"请输入签到码",preferredStyle:.alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addTextField(configurationHandler: ({
            (text:UITextField) in
            //text.keyboardType = .numberPad
            text.placeholder = "签到码"
        }))
        
        let okAction = UIAlertAction(title:"确认",style:.default,handler:{
            action in
            
            SVProgressHUD.show(withStatus: "")
            let login = alertController.textFields?.first!
            if login?.text == "" {
              //  SVProgressHUD.showInfo(withStatus: "请输入签到码")
               // SVProgressHUD.dismiss(withDelay: 1)
                //self.present(alertController, animated: true, completion: nil)

            }
            
           // print(login?.text)
            let params:[String:String] = {
                if let tt  = login?.text{
                    
                    return ["student_id":self.characterInfo["userNum"]!,"lesson_id":"\(self.dataSource.dataSource["id"]![tag])","code":tt,"isStudent":"0"]
                }else{
             
                    return [:]
                }
            }()
            
             let url = rootURL + "/shikeya/api/student_sign"
                
            AlaRequestManager.shared.postRequest(urlString: url, params: params as [String : AnyObject], success:({
                js in
                print(js)

                if js["status"].string! == "200"{
                    SVProgressHUD.showSuccess(withStatus: js["data"].string!)
                    //self.setSigned(tag: tag)
                    self.request()
                    //修改本地存储当前正在上的课程

                    let userDefault = UserDefaults.standard
                    userDefault.set(self.dataSource.dataSource["id"]![tag], forKey: "nowLesson")
                    self.saveDateNow()
                    
        
                }else{
                    
                   // self.setSigned(tag: tag)
                    SVProgressHUD.showError(withStatus: js["data"].string!)
                    self.present(alertController, animated: true, completion: nil)
                    

                }
                
                SVProgressHUD.dismiss(withDelay: 1.5)
                
            }), failture: ({
                error  in
                SVProgressHUD.showError(withStatus: "签到失败，请稍后后重试")
                SVProgressHUD.dismiss(withDelay: 1.5)

                print(error)
            }))
            
        })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        }else{
            
            getSignCode(tag:tag)
            
            
        }
        
    }
    //MARK: - 转换时间
    func timeFormat(_ tt:Int)->String{
        let date  =  Date.init(timeIntervalSince1970: TimeInterval(tt/1000))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
        
    }
    
    func getSignCode(tag:Int){
        
        let tt  = self.dataSource.dataSource["id"]![tag]

        
        let params:[String:String] = {
                return ["lesson_id":tt]
        }()
        
        let url = rootURL + "/shikeya/api/teacher_sign"
        
        AlaRequestManager.shared.postRequest(urlString: url, params: params as [String : AnyObject], success:({
            js in
            print(js)
            
            if js["status"].string! == "200"{
                //SVProgressHUD.showSuccess(withStatus: "")
                self.setSigned(tag: tag)
                self.request()
                if let ss = js["data"].string{
                let alertController = UIAlertController(title:"签到码为",message:ss,preferredStyle:.alert)
                    let okAction = UIAlertAction(title: "确定", style: .cancel, handler: {
                            action in
                        self.signCode = ss; self.navigationController?.pushViewController(MySIgnViewController.init(code: ss, lesson_id: tt), animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
            }
                
            }else{
                
                SVProgressHUD.showError(withStatus: js["data"].string!)
                //self.present(alertController, animated: true, completion: nil)
                
                
            }
            
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        }), failture: ({
            error  in
            SVProgressHUD.showError(withStatus: "获取失败，请稍后后重试")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
            print(error)
        }))
        
    //alertController.addAction(okAction)
    //alertController.addAction(cancelAction)
    //self.present(alertController, animated: true, completion: nil)
}
    
    
    func setSigned(tag:Int){
        
        let cell =  self.tableview.cellForRow(at: IndexPath.init(row:tag, section: 0)) as! IndexTableViewCell
        cell.SignButton.isSelected = true
        cell.SignButton.isEnabled = false
        //self.dataSource.dataSource[""]
        cell.SignButton.setTitle("已签到", for: .normal)
        cell.SignButton.backgroundColor = UIColor.orange
    }
    
    
   @objc func  touchFile(_ tag:UIButton){
        self.navigationController?.pushViewController(FileDetailTableView.init(class_id: self.dataSource.dataSource["id"]![tag.tag]), animated: true)
        
    }
    
    
    
    
    
    
}
