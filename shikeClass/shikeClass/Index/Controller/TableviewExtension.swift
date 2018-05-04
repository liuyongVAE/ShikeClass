//
//  TableviewExtension.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/4/1.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit

// MARK: -  tableview
extension IndexViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func setTV(){
        self.tableview.frame = FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.view.addSubview(tableview)
        tableview.backgroundColor = backColor
        let TapRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(touchMine))
        TapRecognizer.direction = .right
        tableview.isUserInteractionEnabled = true
        tableview.addGestureRecognizer(TapRecognizer)
        
        
        
        
        
        //let cellnib = UINib(nibName:"IndexTableViewCell",bundle:nil)
        //tableview.register(cellnib, forCellReuseIdentifier: "index")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.dataSource["id"]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell : IndexTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "index") as! IndexTableViewCell
        
        let cell = IndexTableViewCell(style:.default,reuseIdentifier:"cell")
        cell.selectionStyle = .none
        cell.ClassName.text = self.dataSource.dataSource["name"]?[indexPath.row]
        cell.time.text = self.dataSource.dataSource["time"]?[indexPath.row]
        cell.location.text = self.dataSource.dataSource["position"]?[indexPath.row]
        if self.characterInfo["isEmpty"] == "1"{
            cell.SignButton.isHidden = true
        }
        else  if self.characterInfo["character"]! == "tea"{
            cell.SignButton.setTitle("获取\n签到码", for: .normal)
        }else{
            cell.SignButton.setTitle("立即\n签到", for: .normal)
        }
        
        
        switch self.dataSource.dataSource["status"]![indexPath.row] {
        case "0":
            cell.SignButton.isSelected = false
        case "1":
            cell.SignButton.isSelected = true
            cell.SignButton.setTitle("已签到", for: .selected)

        case "2":
            cell.SignButton.isSelected = true
            cell.SignButton.setTitle("用户暂离", for: .selected)
        case "3":
            cell.SignButton.isSelected = true
            cell.SignButton.setTitle("旷课", for: .selected)
        default:
            break
        }
        
        
        
        
        
        cell.fileButton.tag = indexPath.row
        cell.fileLabel.text = (self.dataSource.dataSource["name"]?[indexPath.row])! + "  课件"
        cell.fileLabel.sizeToFit()
        cell.SignButton.tag = indexPath.row
        cell.fileButton.tag = indexPath.row
        cell.ClassName.sizeToFit()
        cell.time.sizeToFit()
        cell.location.sizeToFit()
        cell.SignButton.addTarget(self, action: #selector(didTouchSign(btn:)), for: .touchUpInside)
        cell.fileButton.addTarget(self, action: #selector(touchFile(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(263)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return getHeight(20)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let line = UIView()
        line.frame = CGRect(x:0,y:getHeight(0),width:SCREEN_WIDTH,height:getHeight(20))
        line.backgroundColor = backColor
        
        
        return line
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.signCode == nil{
            self.navigationController?.pushViewController(MySIgnViewController(), animated: true)
        }else{
            self.navigationController?.pushViewController(MySIgnViewController.init(code: signCode!, lesson_id: self.dataSource.dataSource["id"]![indexPath.row]), animated: true)
            
        }
    }
    
    
}
