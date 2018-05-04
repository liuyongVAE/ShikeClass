//
//  SheetTableViewCell.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/5/2.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class SheetTableViewCell: UICollectionViewCell {
    let label = UILabel()

    
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        label.frame = self.contentView.frame
        
        //label.text = ""
        self.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: getHeight(26))
        label.numberOfLines = 0
        label.textAlignment = .center
        //label.sizeToFit()
        label.textColor = UIColor.white
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        // Initialization code
    }

    
    

}
