//
//  IndexMode.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/24.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation



struct IndexModel {
    
    var dataSource:[String:[String]] = [
        "name":[],
        "time":[],
        "position":[],
        "status":[],
        "id":[],
        ]
    
    init(dic:[String:[String]]) {
       self.dataSource = dic
    }
    init() {
        
    }
    
}
