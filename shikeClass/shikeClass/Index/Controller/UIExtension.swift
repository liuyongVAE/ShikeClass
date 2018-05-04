//
//  UIExtension.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/25.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit

extension IndexViewController{
    
     func  setUI(){
        
        
        self.navigationItem.title = "时课"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // 添加个人中心按钮
        let item = UIBarButtonItem(image:#imageLiteral(resourceName: "bottom_icon5"),style:.plain,target:self,action:#selector(touchMine))
        item.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = item
        
        let image = #imageLiteral(resourceName: "帮助")
        // image = UIImage.ini
        
        let itemRight = UIBarButtonItem(image:image,style:.plain,target:self,action:#selector(touchMore(_:)))
        itemRight.tag = 0;
        itemRight.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = itemRight
        
        //个人中心选单
        
        self.viewReturn.addSubview(Mview.topBackview)
        self.viewReturn.addSubview(Mview.bottomView)
        print(characterInfo)
        if characterInfo["character"] == "stu"{
            Mview.NameLabel.text = self.characterInfo["userLabel"]
            Mview.NameLabel.sizeToFit()

            Mview.NumLabel.text = self.characterInfo["userNum"];
            Mview.NumLabel.sizeToFit()
        }else{
            let usd = UserDefaults.standard
            Mview.NameLabel.text = usd.string(forKey: "teacher_name");
            Mview.NameLabel.sizeToFit()
        }
        
    }
    
    

    
    @objc func  touchMore(_ sender:UIButton){
        
        let al = UIAlertController.init(title: "软件说明", message: "1.签到功能会检测您当前的位置，请开启定位权限\n2.您在程序暂时挂起和锁屏时不会被检测为课堂暂离状态   \n3.当您尝试切换应用、点击home键进入主菜单、尝试杀死应用时，都会触发暂离状态检测，请不要在课堂尝试\n4.当您不小心触发暂离状态，我们会给予三分钟的时限让您返回\n5.时课团队祝您学习进步！", preferredStyle: .alert)
        al.addAction(UIAlertAction.init(title: "我知道啦", style: .cancel, handler: nil))
        self.present(al, animated: true, completion: nil)
        
        
        
        
    }
    
    
    
}


//MARK: - 点击个人中心
extension IndexViewController{
    
    
    @objc open func  touchMine(){
        // self.tableview.removeFromSuperview()
        UIView.animate(withDuration: 0.5, animations: {()-> Void in
            
            self.viewLeft.frame.origin.x = 0
            
        })
        
    }
    
    
    @objc func touchLogin(){
        
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
        
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
        
       // self.view.addSubview(viewLeft)
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
            if characterInfo["character"] == "tea"{
                self.navigationController?.pushViewController(MySIgnViewController(), animated: true)
            }else{
                self.navigationController?.pushViewController(MySIgnViewController(), animated: true)
            }
            
        case 3:
            print("setting")
            self.navigationController?.pushViewController(SettingViewController(), animated: true)
            
        default:
            return
        }
        
    }
    
}

