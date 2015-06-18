//
//  ClosetTableViewController.swift
//  mushroom
//
//  Created by Patrick@fuhu on 6/18/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ClosetTableViewController: UITableViewController {

    var arrayCloset:[PFObject]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title="香菇衣櫃"
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        self.tableView.registerNib(UINib(nibName: "ClosetViewCell", bundle: nil), forCellReuseIdentifier:"ClosetViewCell")

        self.tableView.tableFooterView=UIView()
        
        var loadingIndicator:UIActivityIndicatorView=UIActivityIndicatorView(frame:CGRect(x: self.tableView.frame.width/2-25, y: 10, width: 50, height: 50))
        loadingIndicator.startAnimating()
        loadingIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.WhiteLarge
        loadingIndicator.color=UIColor.yellowColor()
        self.tableView.addSubview(loadingIndicator)
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var query:PFQuery=PFQuery(className: "Closet")
        query.findObjectsInBackgroundWithBlock { (array:[AnyObject]?, error:NSError?) -> Void in
            self.arrayCloset=array as! [PFObject]
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.fillMode = kCAFillModeForwards
            transition.duration = 0.5
            transition.subtype = kCATransitionFromBottom
            self.tableView.layer.addAnimation(transition, forKey: "UITableViewReloadDataAnimationKey")
            self.tableView.reloadData()
            
            loadingIndicator.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.arrayCloset.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88.0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell=tableView.dequeueReusableCellWithIdentifier("ClosetViewCell") as! ClosetViewCell

        let closet:PFObject=self.arrayCloset[indexPath.row]
        cell.lblName.text=closet["Name"] as? String
        let onSale:Bool=closet["onSale"] as! Bool
        let isNew:Bool=closet["New"] as! Bool
        cell.lblOnSale.hidden = !onSale && !isNew
        if isNew { cell.lblOnSale.text = "新" }
        if onSale { cell.lblOnSale.text = "特價" }
        cell.closetImgView.sd_setImageWithURL(NSURL(string: (closet["CoverURL"] as? String)!))
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset=UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins=false
        }
        if cell.respondsToSelector("setLayoutMargins:"){
            cell.layoutMargins=UIEdgeInsetsZero
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
