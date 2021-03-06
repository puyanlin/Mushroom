//
//  ViewController.swift
//  mushroom
//
//  Created by Patrick@fuhu on 6/16/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit
import Parse
import Bolts

class MasterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate{
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var loadingIndicator: UIView!
    var appConfig:PFConfig!
    
    let arrayTitle=["最新消息","香菇衣櫃","找香菇"]
    
    var launchTime:Bool=true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"Cell")
        self.tableView.registerNib(UINib(nibName: "OpenOffCell", bundle: nil), forCellReuseIdentifier:"OpenOffCell")
        self.tableView.registerNib(UINib(nibName: "SalesCell", bundle: nil), forCellReuseIdentifier:"SalesCell")
        self.tableView.tableFooterView=UIView()
        
        
        PFConfig.getConfigInBackgroundWithBlock { ( cfg:PFConfig?, error:NSError?) -> Void in
            self.appConfig = cfg as PFConfig!
            
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.fillMode = kCAFillModeForwards
            transition.duration = 0.5
            transition.subtype = kCATransitionFromBottom
            self.tableView.layer.addAnimation(transition, forKey: "UITableViewReloadDataAnimationKey")
            self.tableView.reloadData()
            
            if self.launchTime {
                let view:UIActivityIndicatorView=self.loadingIndicator.viewWithTag(10) as! UIActivityIndicatorView
                view.removeFromSuperview()
                self.loadingIndicator.hidden=true
                self.launchTime=false
            }
            
        }
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title="香菇日韓服飾"

        if !launchTime {
            self.tableView.reloadData()
            
            PFConfig.getConfigInBackgroundWithBlock { ( cfg:PFConfig?, err:NSError?) -> Void in
                self.appConfig = cfg as PFConfig!
                self.tableView.reloadData()
                
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterBackground:", name: UIApplicationDidEnterBackgroundNotification, object: nil)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !launchTime {

            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.loadingIndicator.alpha=0
                }, completion: { (complete) -> Void in
                    self.loadingIndicator.hidden=true
            })
            
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.loadingIndicator.hidden=false
        self.loadingIndicator.alpha=1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func applicationWillEnterForeground(notification: NSNotification) {
        //println("did enter foreground")
        self.viewWillAppear(true)
    }
    
    func applicationWillEnterBackground(notification: NSNotification) {
        //println("did enter background")
    }
    
    //MARK: UITableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if AppDelegate.MANAGE { return self.appConfig==nil ? 0 : 4 }
        
        return self.appConfig==nil ? 0 : 3
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 1:
            let onSale=self.appConfig["onSale"] as! Bool
            return onSale ? 1:0
        case 2:     return 3
        default:    return 1
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch(indexPath.section){
            case 0:
                let cell=tableView.dequeueReusableCellWithIdentifier("OpenOffCell") as! OpenOffCell
                
                let open=self.appConfig["open"] as! Bool
                cell.isOpen=open
                
                if open {
                    let opentime=self.appConfig["openTime"] as! String
                    let close=self.appConfig["closeTime"] as! String
                    cell.setOpeningTimeAndOffTime(opentime, off: close)
                }else{
                    cell.closeReason=self.appConfig["closeReason"] as! String
                }
                
                return cell
            case 1:
                let cell=tableView.dequeueReusableCellWithIdentifier("SalesCell") as! SalesCell
                let salesInfo=self.appConfig["saleContent"] as! String
                cell.tvSales.text=salesInfo.stringByReplacingOccurrencesOfString("\\n", withString: "\n")
                let size=self.appConfig["saleTextSize"] as! CGFloat
                cell.tvSales.font = UIFont.systemFontOfSize(size)
                cell.tvSales.textColor=UIColor.whiteColor()
                cell.imgUrl=self.appConfig["saleImage"] as! String
                return cell
            case 2:
                let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!

                cell.textLabel?.text = arrayTitle[indexPath.row]
                switch(indexPath.row){
                case 0:
                    cell.backgroundColor=UIColor(patternImage: UIImage(named: "cute")!)
                case 1:
                    cell.backgroundColor=UIColor(patternImage: UIImage(named: "pretty")!)
                default:
                    cell.backgroundColor=UIColor(patternImage: UIImage(named: "jeans")!)
                }
                cell.contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
                
                let selectedView:UIView = UIView()
                selectedView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3);
                cell.selectedBackgroundView =  selectedView;
                
                cell.textLabel?.font=UIFont(name: "Arial-BoldMT", size: 30)
                cell.textLabel?.textColor=UIColor.darkGrayColor()
                
                return cell
            default:
                let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!
                
                cell.textLabel?.text = "處理訂單 >"
                
                cell.contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
                
                let selectedView:UIView = UIView()
                selectedView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3);
                cell.selectedBackgroundView =  selectedView;
                
                cell.textLabel?.font=UIFont(name: "Arial-BoldMT", size: 30)
                cell.textLabel?.textColor=UIColor.darkGrayColor()
                
                cell.selectionStyle=UITableViewCellSelectionStyle.None
                
                return cell
        }
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch(indexPath.section){
        case 0:     return 66.0
        case 1:     return 110.0
        default:    return 142.0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if AppDelegate.MANAGE { if section==3 { return 0 } }
        else { if section==2 { return 0 } }
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 1:
            let onSale = self.appConfig["onSale"] as! Bool
            return onSale ? "特別促銷":""
        default:    return ""
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section==2 {
            self.title="返回"
            
            switch(indexPath.row){
            case 0:
                let newsTableViewController:NewsTableViewController=NewsTableViewController()
                self.navigationController?.pushViewController(newsTableViewController, animated: true)
            case 1:
                let closetTableViewController:ClosetTableViewController=ClosetTableViewController()
                self.navigationController?.pushViewController(closetTableViewController, animated: true)
            case 2:
                let contactViewController:ContactTableViewController=ContactTableViewController(style:UITableViewStyle.Grouped)
                self.navigationController?.pushViewController(contactViewController, animated: true)
            default:
                break
            }
        }else if indexPath.section == 3 {
            let bookViewController:BookingHandleViewController=BookingHandleViewController(style:UITableViewStyle.Grouped)
            self.navigationController?.pushViewController(bookViewController, animated: true)
        }
        
    }


}

