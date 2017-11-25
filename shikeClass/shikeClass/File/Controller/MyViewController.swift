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

    override func viewDidLoad() {
        super.viewDidLoad()
        image.frame = self.view.frame
        down()
        self.view.addSubview(image)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func down(){
        //指定下载路径和保存文件名
        var z:URL = URL(string:"https://www.baicu.com")!
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("file1/myLogo.png")
            z = fileURL
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        //开始下载
        Alamofire.download("https://httpbin.org/image/png", to: destination)
            .downloadProgress { progress in
                SVProgressHUD.showProgress(Float(progress.completedUnitCount)/Float(progress.totalUnitCount))
                print("已下载：\(progress.completedUnitCount/1024)KB")
                print("总大小：\(progress.totalUnitCount/1024)KB")
            }
            .responseData { response in
                if let data = response.result.value {
                    print("下载完毕!")
                    SVProgressHUD.dismiss()
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.image.loadFileURL(z, allowingReadAccessTo: z)
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
