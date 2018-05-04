//
//  StudentModel.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/26.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation

struct StudentModel {
    var name:[String]?
    var num:[String]?
    var lessonId:[String]?
    var status:[String]?
    var length:Int?
    
    init() {
        name = [String]()
        num = [String]()
        status = [String]()
        length = Int();
    }
    
  

    
    init(dic:[String:[AnyObject]]) {
        self.name = (dic["name"] as! [String])
        self.num = (dic["num"] as! [String])
        self.status = dic["status"] as? [String]
        self.lessonId = dic["lessonId"] as? [String]
    
    
}




}
