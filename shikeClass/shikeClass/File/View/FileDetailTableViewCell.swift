//
//  MyFileTableViewCell.swift
//  shikeClass
//
//  Created by ly on 2017/11/23.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class FileDetailTableViewCell: UITableViewCell {
    
    let leftImage = UIImageView()
    let TitleLabel = UILabel()
    let numLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        leftImage.frame = Rect(30, 40,108, 97)
        leftImage.image = #imageLiteral(resourceName: "pdf")
        TitleLabel.frame = Rect(180, 40, 0, 0)
        numLabel.frame = Rect(180, 102, 0, 0)
        TitleLabel.font = UIFont.boldSystemFont(ofSize: getHeight(42))
        numLabel.font = UIFont.systemFont(ofSize:getHeight(26))
        
        let rightImage = UIImageView(frame:Rect(700, 67, 26, 40))
        rightImage.image = #imageLiteral(resourceName: "更多")
        
        self.addSubview(leftImage)
        self.addSubview(TitleLabel)
        self.addSubview(numLabel)
       // self.addSubview(rightImage)
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

