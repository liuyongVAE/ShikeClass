//
//  ChangePasswordViewController.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/24.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit
import SVProgressHUD
class ChangePasswordViewController: UIViewController {

    lazy var changeView:LoginView = {
        let v = LoginView.init(frame: self.view.frame)
        v.Logo.isHidden = true
        v.segment.isHidden  = true
        v.userNum.placeholder = "   原密码"
        v.userNum.keyboardType = .default
        v.userLabel.placeholder = "   新密码"
        v.NewPassword.placeholder = "   确认您的新密码"
        v.addSubview(v.NewPassword)
        v.backgroundColor = backColor
        v.LoginButton.addTarget(self, action: #selector(request), for: .touchUpInside)
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "修改密码"
         self.view.addSubview(changeView)
        // Do any additional setup after loading the view.
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   @objc func request(){
       let usd = UserDefaults.standard
    let oldText1 = self.changeView.userNum.text!;
    let newText1 = self.changeView.userNum.text!
    let newText2 = self.changeView.NewPassword.text!
    
    if oldText1=="" || newText1 == "" || newText2 == "" {
        SVProgressHUD.showInfo(withStatus: "请输入完全")
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
    

    if let ss = usd.string(forKey: "charater"){
        if ss == "stu"{
            let al = UIAlertController.init(title: "提示", message: "学生身份暂不支持修改！", preferredStyle: .alert)
            al.addAction(UIAlertAction.init(title: "确认", style: .cancel, handler: nil))
            self.present(al, animated: true, completion: nil)
            return
        }
        
        let oldpassword = usd.string(forKey: "userLabel")
        if  oldText1 != oldpassword {
            SVProgressHUD.showError(withStatus: "原密码错误")
            SVProgressHUD.dismiss(withDelay: 1.5)
            return
        }else{
            if newText1 != newText2{
                SVProgressHUD.showError(withStatus: "两次输入不一致")
                SVProgressHUD.dismiss(withDelay: 1.5)
                return
            }else{
                //正确流程
                let id = usd.string(forKey: "userNum")
                let url = rootURL + "/shikeya/api/teacher_password"
                let params = ["teacher_id":"\(id)","password":"\(newText2)"]
                
                AlaRequestManager.shared.postRequest(urlString: url, params: params as [String : AnyObject], success:({js in
                    if js["status"].string! == "200"{
                        
                        SVProgressHUD.showSuccess(withStatus: "修改成功")
                        SVProgressHUD.dismiss(withDelay: 1.5)
                        usd.set(newText2, forKey: "userLabel")
                    }else{
                        
                        SVProgressHUD.showSuccess(withStatus: "修改失败，请稍后再试")
                        SVProgressHUD.dismiss(withDelay: 1.5)
                        
                    }
                    
                }), failture:({
                    error in
                      print(error)
                    
                }))
                
                
                
                
                
                
                
                
            }
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }else{
        
        SVProgressHUD.showInfo(withStatus: "用户未登录")
        
    }
    
    
    
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
