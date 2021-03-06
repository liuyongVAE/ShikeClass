//
//  FileDetailTableView.swift
//  shikeClass
//
//  Created by ly on 2017/11/25.
//  Copyright © 2017年 shikeTeam. All rights reserved.
// FileDetailTableView b
import UIKit
class FileDetailTableView: UITableViewController {
var database:[String:[String]] = ["Filename":[],"FileTag":[],"numofFile":[],"FileLink":[],"File":[]]
    var class_id:String!
    
    
    init(class_id:String){
        self.class_id = class_id
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(){
        self.init(class_id: "")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        netRequest()
        self.navigationItem.title = "我的文件"
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let data = database["Filename"]?.count
        {
            return data
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(170)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = FileDetailTableViewCell.init(style: .default, reuseIdentifier: "cell")
        if let data = database["Filename"]?[indexPath.row]{
            cell.TitleLabel.text = data
            cell.TitleLabel.sizeToFit()
            cell.numLabel.text = database["numofFile"]?[indexPath.row]
            cell.numLabel.sizeToFit()
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          self.navigationController?.pushViewController(MyViewController.init(link: self.database["FileLink"]![indexPath.row]), animated: true)
    }
    
    func netRequest(){
        
        
        var new = self.database
        let url = rootURL + "/shikeya/api/file_search_condition"
        let params:[String:String] = {
            if let mm = UserDefaults.standard.string(forKey: "userNum"){
                return ["studentid":mm,"lessonid":self.class_id]
            }else{
                
                return [:]
            }
        }()
        
        AlaRequestManager.shared.postRequest(urlString: url, params: params as [String:AnyObject], success:({
            js in
            print(js)
            for i in 0..<js["data"].count{
                new["Filename"]?.append(js["data"][i]["file_name"].string!)
                new["numofFile"]?.append(js["data"][i]["file_size"].string! +  "KB")
                //new["FileTag"]?.append(js["data"][i]["file_id"].string!)
                new["FileLink"]?.append(js["data"][i]["file_link"].string!)
            }
            self.database = new
            //            print(new)
            self.tableView.reloadData()
            
        }), failture: ({
            
            error in print(error)
            
        }))
        
        
    }

    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

