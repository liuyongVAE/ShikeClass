//
//  MyViewController.swift
//  shikeClass
//
//  Created by ly on 2017/11/25.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
import SVProgressHUD
class MyViewController: UIViewController {
    var image = WKWebView()
   // var image2 = UIImageView()
    var link:String!
    init(link:String) {
        self.link = link
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        self.view.addSubview(image)

        image.frame = self.view.frame
        down()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func down(){
        //指定下载路径和保存文件名
        //var z:URL = URL(string:link)!
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("file1/\(self.link)")
            //z = fileURL
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        
    
        //开始下载
        Alamofire.download(link, to: destination)
            .downloadProgress { progress in
        
              SVProgressHUD.showProgress(Float(progress.completedUnitCount/progress.totalUnitCount), status: "正在下载")
                print("已下载：\(progress.completedUnitCount/1024)KB")
                print("总大小：\(progress.totalUnitCount/1024)KB")
            }
            .responseData { response in
                if response.result.value != nil {
                    print("下载完毕!")
                    SVProgressHUD.dismiss()
                    DispatchQueue.main.async {

                      if let path = response.destinationURL?.path{
                        
                          let urlStr = URL.init(fileURLWithPath:path);
                          let data = try! Data(contentsOf: urlStr)
                          self.image.load(data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL() as URL)
                      }
                        
                    }
                }
        }
    }
    
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
