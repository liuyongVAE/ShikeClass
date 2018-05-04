//
//  AlertView.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/4/1.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit


class AlertView{
    
    
    static let shared:AlertView = {
        let m = AlertView()
        return m;
    }()
    
    
    func showAlert(vc:UIViewController,titles:String,message:String,okMessage:String,complete:@escaping ()->()){
        
        let alert:UIAlertController = UIAlertController.init(title: titles, message: message, preferredStyle: .alert)
        let okAction:UIAlertAction = UIAlertAction.init(title: okMessage, style: .default, handler:({
            action in
            complete()
        }))
        alert.addAction(okAction)
        alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    
    func showAlert(vc:StudentViewDelegate,titles:String,message:String,okMessage:String,complete:@escaping ()->()){
        
        let alert:UIAlertController = UIAlertController.init(title: titles, message: message, preferredStyle: .alert)
        let okAction:UIAlertAction = UIAlertAction.init(title: okMessage, style: .default, handler:({
            action in
            complete()
        }))
        alert.addAction(okAction)
        alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        vc.Present(vc: alert)
        
    }
    
    
    
    
    
    
}
