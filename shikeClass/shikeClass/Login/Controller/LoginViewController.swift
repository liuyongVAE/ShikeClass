//
//  LoginViewController.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/20.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class LoginViewController: UIViewController {

    
    var loginView:LoginView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi();
        loginView = LoginView.init(frame: self.view.frame);
        loginView.backgroundColor = backColor
        self.view.addSubview(loginView)
        loginView.LoginButton.addTarget(self, action: #selector(Alarequest), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavi(){
        self.navigationItem.title = "登录"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = naviColor
    }
    
    func saveInfo(_ Character:String,_ name:String,_ psw:String){
        let userDefault = UserDefaults.standard
        userDefault.set(Character, forKey: "Character")
        userDefault.set(name, forKey: "userLabel")
        userDefault.set(psw, forKey: "userNum")
    }
    
    
    
   @objc func Alarequest(){
        let url = rootURL + "/shikeya/api/student_login"
        let id = self.loginView.userNum.text!
        let pas = self.loginView.userLabel.text!
        
        
        let paramete = ["student_id":"\(id)","student_name":"\(pas)"]
       // print(paramete,url)

        Alamofire.request(url, method: .post,parameters:paramete).responseJSON(completionHandler: {
            response in
            if let al = response.response{
                // print(al)
                SVProgressHUD.dismiss(withDelay: 1.5)

             }else{
                SVProgressHUD.showError(withStatus: "网络连接失败")
            }
            if let js = response.result.value{
                 let json = JSON(js)
                print(json)
                if json["status"].string! == "200"{
                    SVProgressHUD.showSuccess(withStatus: "登录成功")
                    if (self.loginView.segment.selectedSegmentIndex==0){
                        self.saveInfo("stu",pas,id);}else{
                        self.saveInfo("tea",pas,id)
                    }
                    
                    self.present(UINavigationController.init(rootViewController: IndexViewController()), animated: true, completion: nil)

                }else{
                    SVProgressHUD.showInfo(withStatus: json["data"].string!)
   
                }
                
                
            }
            
        })
        
        
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
