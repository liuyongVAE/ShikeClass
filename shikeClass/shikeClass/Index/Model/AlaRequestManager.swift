//
//  AlaRequestManager.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/24.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//网络请求类库的封装

import Foundation
import Alamofire
class AlaRequestManager{
    
    // 请求单例
    static let shared:AlaRequestManager = {
        let m = AlaRequestManager()
        return m;
    }()
    
    func postRequest(urlString : String, params : [String : AnyObject], success : @escaping (_ responseObject : JSON)->(), failture : @escaping (_ error : NSError)->()) {
        
        Alamofire.request(urlString, method:.post, parameters: params).responseJSON
            {response in
               // print(response.result)
                if  response.result.isSuccess {
                    if let value = response.result.value{
                        success(JSON(value))
                    }
                }else{
                    let error = response.result.error
                    failture(error! as NSError)
                    
                }
        }
    }
    

//
//    func postRequest(urlString:String,params:[String:AnyObject],success:(responseObject:([String : AnyObject])->(),failture:(_ error:NSError)->())){
//
//        Alamofire.request(urlString, method:.post, parameters: params).responseJSON{
//            response in
//            if let success = response.result.value{
//                 let value = JSON(success)
//                 success(success)
//            }
//
//
//
//            }
//
//
//        }
    
    
    
    
    
    
}
