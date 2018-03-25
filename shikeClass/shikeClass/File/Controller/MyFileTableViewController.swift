//
//  MyFileTableViewController.swift
//  shikeClass
//
//  Created by ly on 2017/11/23.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class MyFileTableViewController: UITableViewController {
    var database:[String:[String]] = ["Filename":[],"FileTag":[],"numofFile":[]]
    override func viewDidLoad() {
        super.viewDidLoad()
        netRequest()
       self.navigationItem.title = "我的文件"
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        let cell = MyFileTableViewCell.init(style: .default, reuseIdentifier: "cell")
        if let data = database["Filename"]?[indexPath.row]{
            cell.TitleLabel.text = data
            cell.TitleLabel.sizeToFit()
            cell.numLabel.text = database["numofFile"]?[indexPath.row]
            cell.numLabel.sizeToFit()
            
        }

        return cell
    }
    
    func netRequest(){
     
        let url = rootURL + "/shikeya/api/file_search_sid"
        let params:[String:String] = {
            if let mm = UserDefaults.standard.string(forKey: "userNum"){
                return ["sid":mm]
            }else{
                
                return [:]
            }
        }()
        
        AlaRequestManager.shared.postRequest(urlString: url, params: params as [String:AnyObject], success:({
            js in
            print(js)
        
        }), failture: ({
            
            error in print(error)
            
        }))
        
        
        
        
        
        
        
        print(database)
        self.tableView.reloadData()
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(FileDetailTableView(), animated: true)
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
