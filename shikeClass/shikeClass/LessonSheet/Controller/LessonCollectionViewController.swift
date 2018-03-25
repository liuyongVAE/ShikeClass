//
//  LessonCollectionViewController.swift
//  shikeClass
//
//  Created by ly on 2017/11/4.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LessonCollectionViewController: UICollectionViewController {
    
    
    //Model
    
    fileprivate var lessonSheetData:LessonSheetModel = LessonSheetModel()
    
    //View
    let itemWidth =  SCREEN_WIDTH/8
    let itemInterval = 0.0//SCREEN_WIDTH/48
    let itemHeight = SCREEN_HEIGHT/6
    let leftWidth = getWidth(69)
    let topHeight = getHeight(96)
    let Lessonlayout = UICollectionViewFlowLayout()
    var topButtons = [UIButton]()
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        //let layout = UICollectionViewLayout(
      
        Lessonlayout.itemSize = CGSize(width:itemWidth,height:itemHeight)
        Lessonlayout.minimumInteritemSpacing = CGFloat(itemInterval)
        Lessonlayout.sectionInset = UIEdgeInsetsMake(topHeight,leftWidth, 0, 0)
        super.init(collectionViewLayout: Lessonlayout)
    }
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        setUI()
        self.collectionView?.backgroundColor = backColor
        self.collectionView?.frame = UIScreen.main.bounds
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - setUI
    func setUI(){

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationItem.title = "我的课程"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        let view = UIView()
        view.frame = FloatRect(0,0,leftWidth+getWidth(6), SCREEN_HEIGHT)
        //view.backgroundColor = title2color
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.collectionView?.addSubview(view)
        for i in 0...2{
            let  leView = UIView()
            let label = UILabel()
            label.text = "上午\n8:00\n——\n12:00"
            leView.frame = FloatRect(0,0+CGFloat(i)*(itemHeight*2+self.Lessonlayout.minimumLineSpacing),leftWidth,itemHeight*2+self.Lessonlayout.minimumLineSpacing)
            if i == 2{
                label.text = "晚上\n19:10\n——\n22:00"
                leView.frame = FloatRect(0, CGFloat(i)*(itemHeight*2+self.Lessonlayout.minimumLineSpacing) - itemHeight/2,leftWidth,itemHeight*2+self.Lessonlayout.minimumLineSpacing)
            }else if i == 1 {
                label.text = "下午\n14:30\n——\n18:10"
                
            }
            
            
            //leView.backgroundColor = UIColor.blue
            view.addSubview(leView)
           
            label.frame = FloatRect(4,itemHeight,leftWidth + getWidth(26), leView.frame.height/2)
           
            label.font = UIFont.systemFont(ofSize: getHeight(24))
            label.textColor = title2color
            label.numberOfLines = 0
            leView.addSubview(label)
            label.adjustsFontSizeToFitWidth = true
           // label.sizeToFit()
        }
        
        let topView = UIView()
        topView.frame = FloatRect(0, 0, SCREEN_WIDTH, topHeight)
        topView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.collectionView?.addSubview(topView)
        let button1 = UIButton()
        button1.frame = FloatRect(0, 0, leftWidth, topHeight)
        button1.setTitle("第6周", for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
        button1.titleLabel?.numberOfLines = 0
        button1.titleLabel?.adjustsFontSizeToFitWidth = true
        self.topButtons.append(button1)
        for i in 0...6{
            let button1 = UIButton()
            button1.frame = FloatRect(leftWidth+itemWidth*CGFloat(i) + getWidth(6), 0,itemWidth, topHeight)
            var title = ""
            switch i{
            case 0: title = "周一";
            case 1: title = "周二";
            case 2: title = "周三";
            case 3: title = "周四";
            case 4: title = "周五";
            case 5: title = "周六";
            case 6: title = "周日"
               default: return
            }
            button1.setTitleColor(title1Color, for: .normal)
            button1.setTitleColor(naviColor, for: .selected)
            button1.setTitle(title, for: .normal)
        
            self.topButtons.append(button1)
        }
        
        for i in topButtons{
            topView.addSubview(i)
        }
        
        //测试当日
        //topButtons[3].isSelected = true
        
        
    
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
       return 7*5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
      //填写课程名
        let label = UILabel()
        label.frame = cell.contentView.frame

        label.text = ""
        cell.backgroundColor = UIColor.clear
        if (self.lessonSheetData.lessonPosition?.contains(indexPath.row))! {
            print(indexPath.row)
            label.text = lessonSheetData.lessonName?[(lessonSheetData.lessonPosition?.index(of: indexPath.row))!];
            // lessonSheetData.lessonName?.removeFirst()
            cell.backgroundColor = UIColor.randomColor
        }
        label.font = UIFont.systemFont(ofSize: getHeight(26))
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        //label.sizeToFit()
        label.textColor = UIColor.white
        cell.addSubview(label)

        // Configure the cell
    
        return cell
    }
    

    
    

}


extension LessonCollectionViewController{
    func request(){
        
        let url = rootURL + "/shikeya/api/lesson_search_all"
        var id = ""
        if let idd = UserDefaults.standard.string(forKey: "userNum"){
            id = idd;
        }
        let paramete = ["student_id":"\(id)"]
        var new:LessonSheetModel!
        AlaRequestManager.shared.postRequest(urlString: url, params: paramete as [String : AnyObject], success:{
            (js:JSON)-> () in
            
            if js["status"].string! == "200"{
                let cc = js["data"].count
                new = LessonSheetModel()
                new.length = cc;
                new.todayWeek = "1"
            
                
                print(js)
                if cc>0{
                    for i in 0...cc{
                        if let sna = js["data"][i]["lesson_id"].string{
                            new.lessonId?.append(sna)
                            var time1 = String(sna[sna.startIndex])
                            var time = String(sna[sna.startIndex])
                            new.lessonWeek?.append(Int(time1)!)
                            let index = sna.index(sna.startIndex, offsetBy: 1)
                            var index2 = sna.index(sna.startIndex, offsetBy: 2)
                            time = String(sna[index2])
                            //计算行列
                            new.lessonPosition?.append(self.calculateClassNum(row:Int(time)!, col:Int(time1)! ))
                            
                            new.lessonTime?.append(time)
                            index2 = sna.index(sna.startIndex, offsetBy: 3)
                            time = String(sna[index2...])
                            new.lessonAdress?.append(time)
                            
                            
                        }else{
                             new.lessonId?.append("")
                        }
                        
                        if let sna = js["data"][i]["lesson_name"].string{
                            new.lessonName?.append(sna)
                        }else{
                            new.lessonName?.append("")
                        }
                      
                        
                        
                        
                    }
                }
                
                    self.lessonSheetData = new
                self.topButtons[Int(self.lessonSheetData.todayWeek!)!].isSelected = true
                    self.collectionView?.reloadData()
                    print(new)
                
            }
            
            
            
            
            
            
            
        }, failture:{ error -> () in
              print(error)
            }
     )
    }
    
    
    func calculateClassNum(row:Int,col:Int)->Int{
        var rownew = row;
        if row>2{
            rownew = row-1;
        }
        return  (rownew-1)*7 + col - 1
    }

    
    
}




extension UIColor{
    class var randomColor: UIColor {
        get{
            let red = CGFloat((arc4random()%200))/255.0
            let green = CGFloat((arc4random()%200))/255.0
            let blue = CGFloat((arc4random()%200))/255.0
            return UIColor(red:red,green:green,blue:blue,alpha:0.5)
        }
        
    }
    
    
}
