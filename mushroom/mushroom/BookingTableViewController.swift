//
//  BookingTableViewController.swift
//  mushroom
//
//  Created by Puyan on 2015/6/20.
//  Copyright (c) 2015年 Puyan. All rights reserved.
//

import UIKit
import Parse
import Bolts

class BookingTableViewController: UITableViewController,UIAlertViewDelegate,ProductDetailViewDelegate,ClostClassFooterConfirmViewDelegate,BookingViewDelegate {

    var arrayProduct:[PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="我的衣櫃"
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        self.tableView.registerNib(UINib(nibName: "ClosetViewCell", bundle: nil), forCellReuseIdentifier:"ClosetViewCell")
        self.tableView.registerNib(UINib(nibName: "ClostClassFooterConfirmView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ClostClassFooterConfirmView")
        
        arrayProduct=BookingManager.sharedManager.arrayProduct()
        
        self.tableView.tableFooterView=UIView()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayProduct.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCellWithIdentifier("ClosetViewCell") as! ClosetViewCell
        
        let product:PFObject = self.arrayProduct[indexPath.row]
        cell.lblName.text=product["DisplayName"] as? String
        cell.closetImgView.sd_setImageWithURL(NSURL(string: (product["imgUrl"] as? String)!))
        let price:Int = product["price"] as! Int
        cell.lblOnSale.text="$\(price)"
        
        let selectedView:UIView = UIView()
        selectedView.backgroundColor = UIColor(red: 1, green: 1, blue: 240.0/255, alpha: 1);
        cell.selectedBackgroundView =  selectedView;
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let view:ProductDetailView=NSBundle.mainBundle().loadNibNamed("ProductDetailView", owner: nil, options: nil)[0] as! ProductDetailView
        view.frame=self.view.frame
        
        let product:PFObject = self.arrayProduct[indexPath.row]
        view.product = product
        view.delegate = self
        
        self.navigationController?.view.addSubview(view)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var totalPrice:Int=0
        
        for product in arrayProduct {
            let price:Int = product["price"] as! Int
            totalPrice += price
        }
        
        return "估計價格:  \(totalPrice) 塊"
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let confirmFooter=tableView.dequeueReusableHeaderFooterViewWithIdentifier("ClostClassFooterConfirmView") as! ClostClassFooterConfirmView
        confirmFooter.delegate=self
        
        return confirmFooter
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88.0
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
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 66.0
    }

    //MARK: - ProductDetailViewDelegate
    func removeProduct(product: PFObject) {
        arrayProduct=BookingManager.sharedManager.arrayProduct()
        self.tableView.reloadData()
        
        if arrayProduct.count == 0 {
            let alert = UIAlertView()
            alert.title = "衣櫃裡沒有衣服囉，再挑一下吧！"
            alert.addButtonWithTitle("好")
            alert.delegate=self
            alert.show()

        }
    }
    
    //MARK: - UIAlertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    //MARK: - ClostClassFooterConfirmViewDelegate
    func didConfirm(){
        let view:BookingView=NSBundle.mainBundle().loadNibNamed("BookingView", owner: nil, options: nil)[0] as! BookingView
        view.frame=self.view.frame
        view.bookingList=arrayProduct
        view.delegate=self
        
        self.navigationController?.view.addSubview(view)
    }
    //MARK - BookingViewDelegate
    func didBookingFinished(bookingSerial:String){
        self.navigationController?.popToRootViewControllerAnimated(true)
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
