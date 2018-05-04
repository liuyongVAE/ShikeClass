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
        //let image = #imageLiteral(resourceName: "more").withRenderingMode(.alwaysOriginal)
        let itemRight = UIBarButtonItem(image:#imageLiteral(resourceName: "帮助"),style:.plain,target:self,action:#selector(touchMore))
        itemRight.tag = 0;
        itemRight.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = itemRight
    }
    
    func saveInfo(_ Character:String,_ name:String,_ psw:String){
        let userDefault = UserDefaults.standard
        userDefault.set(Character, forKey: "character")
        userDefault.set(name, forKey: "userLabel")
        userDefault.set(psw, forKey: "userNum")
        
        print(userDefault.string(forKey: "userNum"))
    }
    
    
    
    @objc func touchMore(){
        
        
        let al = UIAlertController.init(title: "账号检测说明", message: "时课无需注册，只需要提供您的学号姓名或工号密码即可登录！", preferredStyle: .alert)
        al.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        al.addAction(UIAlertAction.init(title: "使用游客账号登录", style: .default, handler: ({
            action in
            
            self.loginView.userNum.text =  "1525122009"
            self.loginView.userLabel.text = "小明"
            self.Alarequest()
            
        })))

        self.present(al, animated: true, completion: nil)
        
    }
    
    
   @objc func Alarequest(){
    
    var url = rootURL + "/shikeya/api/student_login";
    let id = self.loginView.userNum.text!;
    let pas = self.loginView.userLabel.text!;
        var paramete = ["student_id":"\(id)","student_name":"\(pas)"]

        if (self.loginView.segment.selectedSegmentIndex==1){
           url = rootURL + "/shikeya/api/teacher_login"
           paramete = ["teacher_id":"\(id)","password":"\(pas)"]

         }

    

        
        
       // let paramete = ["student_id":"\(id)","student_name":"\(pas)"]
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
                        if let name = json["data"]["teacher"]["teacher_name"].string{
                            self.saveInfo("tea",pas,id)
                            let usd = UserDefaults.standard
                            usd.set(name, forKey: "teacher_name")
                        }
                        
                    }
                   
                    //let vc = UINavigationController.init(rootViewController: IndexViewController())
                    self.present(MyTabViewController(), animated: true, completion:  nil)
                    //self.navigationController?.pushViewController(IndexViewController(), animated: true)
                    //self.navigationController?.view.viewDidLoad()
                   // let vc = UINavigationController.init(rootViewController: IndexViewController())
                  //self.navigationController?.popToRootViewController(animated: true)
                    //self.navigationController?.pushViewController(IndexViewController(), animated: true)//present(UINavigationController.init(rootViewController: IndexViewController()), animated: true, completion: nil)

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
