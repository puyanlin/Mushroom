//
//  ContactTableViewController.swift
//  mushroom
//
//  Created by Puyan on 6/17/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {

    let aboutContact=[["icon":"line","title":"LINE ID","detail":"yenju1208 (香菇）","url":"line://ti/p/l6dsTkb1Bf"],
                      ["icon":"fb","title":"facebook 粉絲專頁","detail":"香菇日韓服飾","url":"fb://profile/135345183313097"],
                      ["icon":"phone","title":"聯絡電話","detail":"0916-242-077","url":"telprompt://+886916242077"],
                      ["icon":"map","title":"位置","detail":"新北市三重區長壽西街54號","url": String("http://maps.apple.com/?q="+"新北市三重區長壽西街54號".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="找香菇"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        
        print("\(aboutContact)")
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch(section){
        case 1:     return 4
        case 2:     return 1
        default:    return 0
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=UITableViewCell(style: indexPath.section == 1 ? UITableViewCellStyle.Value1:UITableViewCellStyle.Subtitle , reuseIdentifier: "Cell")
        
        if indexPath.section == 1 {
            cell.imageView?.image=UIImage(named: aboutContact[indexPath.row]["icon"]!)
            cell.textLabel?.text=aboutContact[indexPath.row]["title"]
            cell.detailTextLabel?.text=aboutContact[indexPath.row]["detail"]
        }else if indexPath.section == 2 {
            cell.imageView?.image=UIImage(named:"mail")
            cell.textLabel?.text = "Joseph Lin"
            cell.detailTextLabel?.text = "puyanlinmailbox@gmail.com"
        }
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0:     return "香菇日韓服飾"
        case 2:     return "App製作"
        default:    return ""
        }
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch(section){
        case 0:     return "我是香菇，因愛穿韓貨、愛看韓劇，因此決定在研究所時候開始我的擺攤人生。沒想到能從邊趕論文邊批貨擺攤到現在全職擺攤生活；更沒想到連粉絲團也成立了，app也有了！！一切都感謝各位的支持愛護，我會更加努力，維持我的熱忱，找更多好看的服飾，讓大家一起變美變有型"+String(UnicodeScalar(0x1F618))
        case 2:     return "Copyright (c) 2015 Puyan.All rights reserved."
        default:    return ""
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section){
        case 0: break
        default:
            if indexPath.section == 1 {
                UIApplication.sharedApplication().openURL(NSURL(string: aboutContact[indexPath.row]["url"]!)!)
            }else {
                UIApplication.sharedApplication().openURL(NSURL(string:"mailto://puyanlinmailbox@gmail.com")!)
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
