//
//  SettingView.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/24.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

protocol SettingViewDelegate {
    func Push(vc:UIViewController)
    func Pop()
}



class SettingView: UIView {

    
    open var delegate:SettingViewDelegate?
    
    lazy var tableview:UITableView = {
        let tableview = UITableView.init(frame: self.frame)
        tableview.dataSource = self
        tableview.delegate = self
        return tableview
    }()
    
    fileprivate var titles = ["修改密码","关于","","","","","","","","","退出登录"]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func deleteInfo(){
        
        
         let usd = UserDefaults.standard;
        
        if usd.string(forKey: "userNum") != nil {
          usd.removeObject(forKey: "userNum")
          usd.removeObject(forKey: "character")
          usd.removeObject(forKey: "userLabel")
        }
        print(usd.string(forKey: "userLabel"),usd.string(forKey: "character"),usd.string(forKey: "userLabel"))
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension SettingView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cell = tableview.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = titles[indexPath.row]
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.textColor = title2color
        if indexPath.row == 10{
            cell?.textLabel?.textColor = UIColor.white
            cell?.backgroundColor = naviColor
            
        }
        
        return cell!
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 10{
            
            self.deleteInfo()
            self.delegate?.Push(vc: LoginViewController())
        }else if indexPath.row == 1{
            self.delegate?.Push(vc: AboutViewController())
            
        }else if indexPath.row == 0{
            self.delegate?.Push(vc: ChangePasswordViewController())
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40;
    }
    
    

    
    
    
}
