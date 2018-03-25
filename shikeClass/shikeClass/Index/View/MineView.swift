//
//  MineView.swift
//  shikeClass
//
//  Created by ly on 2017/11/3.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation
import SnapKit




class MineView{
  
    
    init() {
        self.topBackview.addSubview(MineImage)
        self.MineImage.addSubview(NameLabel)
        self.topBackview.addSubview(NumLabel)
        self.bottomView.addSubview(classBtn)
        self.bottomView.addSubview(fileBtn)
        self.bottomView.addSubview(signBtn)
        self.bottomView.addSubview(settingBtn)
        
    }
    

    
    lazy var topBackview:UIView = {
        let view = UIView()
        view.frame =  CGRect(x:0,y:0,width:SCREEN_WIDTH*2/3,height:getHeight(329))
        return view
    }()
    
    
    
    lazy var MineImage:UIButton = {
        let btn = UIButton()
        btn.frame = Rect(165, 68, 130, 130)
        btn.setImage(#imageLiteral(resourceName: "我的"), for: .normal)
        return btn

    }()
    
    lazy var NameLabel:UILabel = {
        let label = UILabel(frame:Rect(40,161,0,0))
        label.text = "名字"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: getHeight(26))
        label.sizeToFit()
        return label
    }()
    
    lazy var NumLabel:UILabel = {
        let label = UILabel(frame:Rect(145,265,0,0))
        label.text = "           "
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: getHeight(26))
        label.sizeToFit()
        return label
        
    }()
    
    lazy var bottomView:UIView = {
        let view = UIView(frame:CGRect(x:0,y:self.topBackview.frame.height,width:SCREEN_WIDTH*2/3,height:SCREEN_HEIGHT - self.topBackview.frame.height))
            //Rect(0,329,Double(self.topBackview.frame.width), Double(SCREEN_HEIGHT - self.topBackview.frame.height)))
        view.backgroundColor = backColor
        return  view
    }()

    lazy var classBtn:UIButton = {
        let button = UIButton()
        button.frame = FloatRect(0,getHeight(18),SCREEN_WIDTH*2/3,getHeight(98))
        button.setTitle("我的课程", for: .normal)
        //button.backgroundColor = UIColor.blue
        button.setTitleColor(title1Color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(32))
        //button.setImage(#imageLiteral(resourceName: "bottom_icon5"), for: .normal)
        let image = UIImageView()
        image.frame = Rect(40, 20, 50, 50)
        image.image = #imageLiteral(resourceName: "博士帽");
        button.addSubview(image)
        let line = UIView()
        let line1 = UIView()
        
        line1.frame = FloatRect(0,getHeight(0), SCREEN_WIDTH*2/3,getHeight(1))
        line1.backgroundColor = lineColor
        button.addSubview(line1)
        
        line.frame = FloatRect(0,getHeight(97), SCREEN_WIDTH*2/3,getHeight(1))
        line.backgroundColor = lineColor
        button.addSubview(line)
        
        
        button.tag = 0
        return button
    }()
    
    
    lazy var fileBtn:UIButton = {
        let button = UIButton()
        button.frame = FloatRect(0,getHeight(18+98),SCREEN_WIDTH*2/3,getHeight(98))
        button.setTitle("我的文件", for: .normal)
        //button.backgroundColor = UIColor.blue
        button.setTitleColor(title1Color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(32))
        //button.setImage(#imageLiteral(resourceName: "bottom_icon5"), for: .normal)
        let image = UIImageView()
        image.frame = Rect(40, 20, 50, 50)
        image.image = #imageLiteral(resourceName: "文件夹 空心");
        button.addSubview(image)
        let line = UIView()
        let line1 = UIView()
        
        line1.frame = FloatRect(0,getHeight(0), SCREEN_WIDTH*2/3,getHeight(1))
        line1.backgroundColor = lineColor
        button.addSubview(line1)
        
        line.frame = FloatRect(0,getHeight(97), SCREEN_WIDTH*2/3,getHeight(1))
        line.backgroundColor = lineColor
        button.addSubview(line)
        button.tag = 1
        return button
    }()
    
    lazy var signBtn:UIButton = {
        let button = UIButton()
        button.frame = FloatRect(0,getHeight(18+98*2),SCREEN_WIDTH*2/3,getHeight(98))
        button.setTitle("我的签到", for: .normal)
        //button.backgroundColor = UIColor.blue
        button.setTitleColor(title1Color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(32))
        //button.setImage(#imageLiteral(resourceName: "bottom_icon5"), for: .normal)
        let image = UIImageView()
        image.frame = Rect(40, 20, 50, 50)
        image.image = #imageLiteral(resourceName: "签到");
        button.addSubview(image)
        let line = UIView()
        let line1 = UIView()
        
        line1.frame = FloatRect(0,getHeight(0), SCREEN_WIDTH*2/3,getHeight(1))
        line1.backgroundColor = lineColor
        button.addSubview(line1)
        
        line.frame = FloatRect(0,getHeight(97), SCREEN_WIDTH*2/3,getHeight(1))
        line.backgroundColor = lineColor
        button.addSubview(line)
        button.tag = 2
        return button
    }()
    
    lazy var settingBtn:UIButton = {
        let button = UIButton()
        button.frame = FloatRect(0,getHeight(18+98*3),SCREEN_WIDTH*2/3,getHeight(98))
        button.setTitle("设置", for: .normal)
        //button.backgroundColor = UIColor.blue
        button.setTitleColor(title1Color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(32))
        //button.setImage(#imageLiteral(resourceName: "bottom_icon5"), for: .normal)
        let image = UIImageView()
        image.frame = Rect(40, 20, 50, 50)
        image.image = #imageLiteral(resourceName: "set").withRenderingMode(.automatic);
        //image.tintColor = naviColor
        button.addSubview(image)
        let line = UIView()
        let line1 = UIView()
        
        line1.frame = FloatRect(0,getHeight(0), SCREEN_WIDTH*2/3,getHeight(1))
        line1.backgroundColor = lineColor
        button.addSubview(line1)
        
        line.frame = FloatRect(0,getHeight(97), SCREEN_WIDTH*2/3,getHeight(1))
        line.backgroundColor = lineColor
        button.addSubview(line)
        button.tag = 3
        button.titleLabel?.textAlignment = .left
        
        
        return button
    }()
    
    
   
    

    
    
    
    
    
    
}
