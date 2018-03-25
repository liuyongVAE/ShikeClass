//
//  LoginView.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/20.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class LoginView: UIView {

    
    lazy var Logo:UIImageView = {
        let imageLogo = UIImageView(frame:CGRect(x:(SCREEN_WIDTH/CGFloat(2)-(getWidth(187/2))),y:getHeight(90),width:getWidth(187),height:getHeight(187)))
        imageLogo.image = #imageLiteral(resourceName: "logot6")

        
    return imageLogo
    }()
    
    lazy var  userNum:UITextField = {
        let text = UITextField(frame:CGRect(x:getWidth(90),y:getHeight(380),width:getWidth(555),height:getHeight(86)))
        text.placeholder = "   学号"
        text.font = UIFont.systemFont(ofSize: getHeight(32))
        text.layer.borderWidth = 1
        text.layer.borderColor = title2color.cgColor
        text.backgroundColor = UIColor.white
        text.keyboardType = .numberPad

        text.layer.cornerRadius = 2
        return text
    }()
    
    lazy var  userLabel:UITextField = {
        let text = UITextField(frame:CGRect(x:getWidth(90),y:getHeight(530 - 40),width:getWidth(555),height:getHeight(86)))
        text.font = UIFont.systemFont(ofSize: getHeight(32))
        //text.isSecureTextEntry = true
        text.placeholder = "   姓名"
        text.layer.borderWidth = 1
        text.layer.borderColor = title2color.cgColor
        text.backgroundColor = UIColor.white
        text.layer.cornerRadius = 2

        return text
        
    }()
    
    
    lazy var  NewPassword:UITextField = {
        let text = UITextField(frame:CGRect(x:getWidth(90),y:getHeight(530 - 40 + 110),width:getWidth(555),height:getHeight(86)))
        text.font = UIFont.systemFont(ofSize: getHeight(32))
        //text.isSecureTextEntry = true
        text.placeholder = "   确认密码"
        text.layer.borderWidth = 1
        text.layer.borderColor = title2color.cgColor
        text.backgroundColor = UIColor.white
        text.layer.cornerRadius = 2
        
        return text
        
    }()
    
    lazy var segment:UISegmentedControl={
        let seg = UISegmentedControl.init(frame:CGRect(x:getWidth(90),y:getHeight(640),width:getWidth(555),height:getHeight(56)))
        seg.tintColor = title2color
        seg.insertSegment(withTitle: "教师", at:  1, animated: true)
        seg.insertSegment(withTitle: "学生", at: 0, animated: true)
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(self.segmentChange(_:)), for: .valueChanged)
        return seg
        
    }()
    
    lazy var LoginButton:UIButton = {
         let login = UIButton.init(frame:CGRect(x:getWidth(90),y:getHeight(800),width:getWidth(555),height:getHeight(86)))
        login.layer.cornerRadius = 7
        login.backgroundColor = naviColor
        login.setTitleColor(UIColor.white, for: .normal)
        login.setTitle("立即验证", for: .normal)
        login.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(32))
    
        return login
    }()
    
    
    @objc func segmentChange(_ sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            self.userNum.placeholder = "   学号"
            self.userLabel.placeholder = "   姓名"
        }else{
            self.userNum.placeholder = "   工号"
            self.userLabel.placeholder = "   密码"
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.userNum.resignFirstResponder()
        self.userLabel.resignFirstResponder()
        self.NewPassword.resignFirstResponder()
    }
    
    
    override func draw(_ rect: CGRect) {
        self.addSubview(Logo)
        self.addSubview(userNum)
        self.addSubview(userLabel)
        self.addSubview(segment)
        self.addSubview(LoginButton)
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
