
//
//  File.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/26.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class SignTableViewCell: UITableViewCell {
    
    let leftImage = UIImageView()
    let TitleLabel = UILabel()
    let numLabel = UILabel()
    var rightImage = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUI(){
        leftImage.frame = Rect(30,15,85,85)
        leftImage.image =  #imageLiteral(resourceName: "红我的")
        TitleLabel.frame = Rect(180,15, 0, 0)
        numLabel.frame = Rect(180,74, 0, 0)
        TitleLabel.font = UIFont.boldSystemFont(ofSize: getHeight(42))
        numLabel.font = UIFont.systemFont(ofSize:getHeight(26))
        numLabel.textColor = title2color
        
         rightImage = UILabel(frame:FloatRect(SCREEN_WIDTH-getWidth(100), 0, getWidth(100), getHeight(118)))
            //Rect(700, 67, 26, 40))
        rightImage.backgroundColor = naviColor
        rightImage.font = UIFont.systemFont(ofSize: getHeight(26))
        rightImage.textAlignment = .center
        rightImage.text = "旷\n课"
        rightImage.numberOfLines = 0
        rightImage.textColor = UIColor.white
        //rightImage.image = #imageLiteral(resourceName: "更多")
        
        self.addSubview(leftImage)
        self.addSubview(TitleLabel)
        self.addSubview(numLabel)
        self.addSubview(rightImage)
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

