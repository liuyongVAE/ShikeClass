//
//  File.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/24.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation


struct LessonSheetModel {
    
    var lessonWeek:[Int]?
    var lessonId:[String]?
    var lessonTime:[String]?
    var lessonName:[String]?
    var lessonAdress:[String]?
    var lessonPosition:[Int]?
    var todayWeek:String?
    var length:Int?

    
    init(dic:[String:[AnyObject]]) {
        self.lessonWeek = (dic["todyWeek"] as! [Int])
        self.lessonId = (dic["lessonId"] as! [String])
        self.lessonName = dic["lessonName"] as? [String]
        self.lessonAdress = (dic["lessonAdress"] as! [String])
        self.lessonTime = (dic["lessonTime"] as! [String])
    }
    
    init() {
        self.lessonWeek = [Int]()
        self.lessonId = [String]()
        self.lessonName = [String]()
        self.lessonAdress = [String]()
        self.lessonTime = [String]()
        self.lessonPosition = [Int]()
    }
    
}
