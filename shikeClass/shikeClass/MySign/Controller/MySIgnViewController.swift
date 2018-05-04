//
//  MySIgnViewController.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/26.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class MySIgnViewController: UIViewController,StudentViewDelegate{
  
    
    
    
    var code:String!
    var lesson_id:String!
    
    init(code:String,lesson_id:String){
        self.code = code
        self.lesson_id = lesson_id
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(){
        self.init(code: "", lesson_id: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func Present(vc:UIAlertController) {
        self.present(vc, animated: true, completion: nil)
    }
    
  
    


    lazy var mview:StudentSignView = {
        let m = StudentSignView.init(frame: self.view.frame)
        m.delegate = self
        return m
    }()
    
    
    lazy var tview:TeacherSignView = {
        let m = TeacherSignView.init(frame: self.view.frame,lesson_id:self.lesson_id,code:self.code)
        m.delegate = self
        return m
    }()
    
    
    func setNavi(){
        self.navigationItem.title = "签到状态"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = naviColor
        
        let image = #imageLiteral(resourceName: "刷新")
        // image = UIImage.ini
        
        let itemRight = UIBarButtonItem(image:image,style:.plain,target:self,action:#selector(touchSource))
        itemRight.tag = 0;
        itemRight.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = itemRight
        
    }
    
    @objc func touchSource(){
           tview.request()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if lesson_id == ""{
            self.navigationItem.title = "签到状态"
            self.view.addSubview(mview)
        }else{
            setNavi()
            self.view.addSubview(tview)
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
