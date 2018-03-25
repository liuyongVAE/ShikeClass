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
    //MARK: - 转换时间
    func timeFormat(_ tt:Int)->String{
        let date  =  Date.init(timeIntervalSince1970: TimeInterval(tt/1000))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
        
    }
    
    
}
