//
//  BookingHandleViewController.swift
//  mushroom
//
//  Created by Patrick@fuhu on 6/22/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit
import Parse
import Bolts

class BookingHandleViewController: UITableViewController {

    var bookingList:[PFObject]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "訂單處理"

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.registerNib(UINib(nibName: "ClosetViewCell", bundle: nil), forCellReuseIdentifier:"ClosetViewCell")
        
        var query:PFQuery=PFQuery(className: "BookingList")
        query.findObjectsInBackgroundWithBlock { (array:[AnyObject]?, error:NSError?) -> Void in
            
            for booking in array! {
                let info : PFObject = booking as! PFObject
                if !(info["handled"] as! Bool){
                    self.bookingList.append(info)
                }
            }
            
            self.tableView.reloadData()
            
            for section in 0...(self.bookingList.count-1) {
                let info = self.bookingList[section]
                for product in info["itemsData"] as! [PFObject] {
                    product.fetchInBackgroundWithBlock({ (pfObj:PFObject?, error:NSError?) -> Void in
                        let url:String = product["imgUrl"] as! String
                        
                        self.tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: UITableViewRowAnimation.Fade)
                    })
                }
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.bookingList.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info:PFObject = self.bookingList[section]
        let count:Int = (info["items"] as! [String]).count
        return count+2
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var bookingInfo = bookingList[indexPath.section]
        
        if indexPath.row == 0 || indexPath.row == tableView.numberOfRowsInSection(indexPath.section)-1 {
            let cell=UITableViewCell(style:UITableViewCellStyle.Value1, reuseIdentifier: "Cell")

            cell.textLabel?.text=bookingInfo["customer"] as? String
            cell.detailTextLabel?.text=bookingInfo["phone"] as? String
            cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        }
        
        var cell=tableView.dequeueReusableCellWithIdentifier("ClosetViewCell") as! ClosetViewCell
        
        
//        cell.lblName.text=product["DisplayName"] as? String
//        cell.closetImgView.sd_setImageWithURL(NSURL(string: (product["imgUrl"] as? String)!))
//        var price:Int = product["price"] as! Int
//        cell.lblOnSale.text="$\(price)"
//        
//        var selectedView:UIView = UIView()
//        selectedView.backgroundColor = UIColor(red: 1, green: 1, blue: 240.0/255, alpha: 1);
//        cell.selectedBackgroundView =  selectedView;
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 { return 44.0 }
        
        var info = bookingList[indexPath.section]
        let count:Int = (info["items"] as! [String]).count
        if  indexPath.row == (count + 1) { return 55.0 }
        return 88.0
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
