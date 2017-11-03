//
//  IndexTableViewCell.swift
//  shikeClass
//
//  Created by ly on 2017/10/31.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class IndexTableViewCell: UITableViewCell {
    
    let ClassName = UILabel()
    let time = UILabel()
    let location = UILabel()
    let fileButton = UIButton()
    let fileLabel = UILabel()
    let SignButton = UIButton()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func  setUI(){
        
        ClassName.frame = CGRect(x:getWidth(30),y:getHeight(20),width:0,height:0)
        ClassName.font = UIFont.systemFont(ofSize: getHeight(42))
        ClassName.textColor = UIColor.black
        self.addSubview(ClassName)
        
        time.frame = CGRect(x:getWidth(40),y:getHeight(60),width:0,height:0)
        time.font = UIFont.systemFont(ofSize: getHeight(26))
        time.textColor = title2color
        self.ClassName.addSubview(time)
        
        let TimeImage = UIImageView()
        TimeImage.frame = CGRect(x:getWidth(30),y:getHeight(78),width:getWidth(30),height:getHeight(30))
        TimeImage.image = #imageLiteral(resourceName: "bottom_icon5")
        self.addSubview(TimeImage)
        
        
        let LocationImage = UIImageView()
        LocationImage.frame = CGRect(x:getWidth(30),y:getHeight(125),width:getWidth(30),height:getHeight(30))
        LocationImage.image = #imageLiteral(resourceName: "bottom_icon5")
        self.addSubview(LocationImage)
        
        
        location.frame = CGRect(x:getWidth(40),y:getHeight(105),width:0,height:0)
        location.font = UIFont.systemFont(ofSize: getHeight(26))
        location.textColor = title2color
        self.ClassName.addSubview(location)
        
        
        let linet = UIView()
        linet.frame = CGRect(x:0,y:getHeight(0),width:SCREEN_WIDTH,height:getHeight(1))
        linet.backgroundColor = lineColor
        self.addSubview(linet)
        
        let line = UIView()
        line.frame = CGRect(x:0,y:getHeight(170),width:SCREEN_WIDTH,height:getHeight(1))
        line.backgroundColor = lineColor
        self.addSubview(line)
        
        
        let lineb = UIView()
        lineb.frame = CGRect(x:0,y:getHeight(262),width:SCREEN_WIDTH,height:getHeight(1))
        lineb.backgroundColor = lineColor
        self.addSubview(lineb)
        
        SignButton.frame = CGRect(x:SCREEN_WIDTH -  getWidth(123),y:0,width:getWidth(123),height:getHeight(170))
        SignButton.backgroundColor = naviColor
        SignButton.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(30))
        SignButton.titleLabel?.numberOfLines = 0
        self.addSubview(SignButton)
        
        fileButton.frame = CGRect(x:0,y:getHeight(171),width:SCREEN_WIDTH,height:getHeight(70))
        //fileButton.backgroundColor = UIColor.blue
        self.addSubview(fileButton)
        
        fileLabel.frame = CGRect(x:getWidth(70),y:getHeight(23),width:0,height:0)
        fileLabel.font = UIFont.systemFont(ofSize: getHeight(26))
        fileLabel.textColor = title1Color
        fileButton.addSubview(fileLabel)

        let lineC = UIView()
        lineC.frame = CGRect(x:-1,y:getHeight(69),width:SCREEN_WIDTH + 2,height:getHeight(22))
        lineC.backgroundColor = backColor
       // lineC.layer.borderWidth = getHeight(1)
        //lineC.layer.borderColor = lineColor.cgColor
        fileButton.addSubview(lineC)
        
        
        let FileImage = UIImageView()
        FileImage.frame = CGRect(x:getWidth(30),y:getHeight(19),width:getWidth(30),height:getHeight(30))
        FileImage.image = #imageLiteral(resourceName: "bottom_icon5")
        fileButton.addSubview(FileImage)
        
        let rightImage = UIImageView()
        rightImage.frame = CGRect(x: SCREEN_WIDTH - getWidth(60),y:getHeight(19),width:getWidth(43),height:getHeight(43))
        rightImage.image = #imageLiteral(resourceName: "bottom_icon5")
        fileButton.addSubview(rightImage)
        
    
        
        
        
        
        
        
    }
    
    
    
}
