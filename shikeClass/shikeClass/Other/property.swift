//
//  、.swift
//  shikeClass
//
//  Created by ly on 2017/10/30.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit

public func hexStringToColor(hexString: String) -> UIColor{
    
    var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    
    if cString.characters.count < 6 {
        return UIColor.black
    }
    if cString.hasPrefix("0X") {
        cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
    }
    if cString.hasPrefix("#") {
        cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
    }
    if cString.characters.count != 6 {
        return UIColor.black
    }
    
    var range: NSRange = NSMakeRange(0, 2)
    let rString = (cString as NSString).substring(with: range)
    range.location = 2
    let gString = (cString as NSString).substring(with: range)
    range.location = 4
    let bString = (cString as NSString).substring(with: range)
    
    var r: UInt32 = 0x0
    var g: UInt32 = 0x0
    var b: UInt32 = 0x0
    Scanner.init(string: rString).scanHexInt32(&r)
    Scanner.init(string: gString).scanHexInt32(&g)
    Scanner.init(string: bString).scanHexInt32(&b)
    
    return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    
}



let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width

func getHeight(_ height: Double) -> CGFloat{
    return CGFloat(height/1334)*(SCREEN_HEIGHT)
}

func getWidth(_ width :Double) -> CGFloat {
    return  CGFloat(width/750)*(SCREEN_WIDTH)
}

let naviColor = hexStringToColor(hexString: "#d33a32")
let title2color = hexStringToColor(hexString: "#7a7a7a")
let backColor = hexStringToColor(hexString:"#fafafa")
let lineColor = hexStringToColor(hexString:"#dddddd")
let title1Color = hexStringToColor(hexString:"#333333")
