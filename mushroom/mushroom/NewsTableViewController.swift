//
//  NewsTableViewController.swift
//  mushroom
//
//  Created by Patrick@fuhu on 6/18/15.
//  Copyright (c) 2015 Puyan. All rights reserved.
//

import UIKit
import Parse
import Bolts

enum NewsSortType:Int{
    case ByTime=0
    case ByType
}

class NewsTableViewController: UITableViewController {

    var sortType:NewsSortType=NewsSortType.ByTime{
        didSet{
            print("set")
            self.tableView.reloadData()
        }
    }
    
    var arrayAllTypeNews:[PFObject]=[]
    var arrayNew:[PFObject]=[]
    var arrayDeclaration:[PFObject]=[]
    var arrayActivity:[PFObject]=[]
    var arrayClose:[PFObject]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="最新消息"
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var sortBtn:UIButton=UIButton(frame: CGRect(x: 0, y: 0, width: 65, height: 35))
        
        sortBtn.setTitle( sortType == NewsSortType.ByTime ? "按時間":"按分類", forState: UIControlState.Normal)
        let tintColor:UIColor = UIColor(red: 1, green: 0.5, blue: 0, alpha: 1)
        sortBtn.setTitleColor(tintColor, forState: UIControlState.Normal)
        sortBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        sortBtn.layer.borderWidth=1
        sortBtn.layer.borderColor=tintColor.CGColor
        sortBtn.layer.cornerRadius=5
        sortBtn.addTarget(self, action: "didClickSortBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var barSortBtn:UIBarButtonItem=UIBarButtonItem(customView: sortBtn)
        self.navigationItem.rightBarButtonItem=barSortBtn
        
        var loadingIndicator:UIActivityIndicatorView=UIActivityIndicatorView(frame:CGRect(x: self.tableView.frame.width/2-25, y: 10, width: 50, height: 50))
        loadingIndicator.startAnimating()
        loadingIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.WhiteLarge
        loadingIndicator.color=UIColor.yellowColor()
        
        self.tableView.addSubview(loadingIndicator)
        
        self.tableView.registerNib(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier:"NewsCell")
        
        self.tableView.tableFooterView=UIView()
        
        var query:PFQuery=PFQuery(className: "News")
        query.findObjectsInBackgroundWithBlock { ( arrayNews: [AnyObject]?,error:NSError?) -> Void in
            
            self.arrayAllTypeNews = arrayNews as! [PFObject]
            self.arrayAllTypeNews.sort({ (obj1, obj2) -> Bool in
                return true
            })
            
            for news in self.arrayAllTypeNews {
                switch(NewsType(rawValue: news["Type"] as! Int)!){
                case .New:
                    self.arrayNew.append(news)
                case .Declaration:
                    self.arrayDeclaration.append(news)
                case .Activity:
                    self.arrayActivity.append(news)
                case .Close:
                    self.arrayClose.append(news)
                default: break
                }
            }
            
            loadingIndicator.removeFromSuperview()
            
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.fillMode = kCAFillModeForwards
            transition.duration = 0.5
            transition.subtype = kCATransitionFromTop
            self.tableView.layer.addAnimation(transition, forKey: "UITableViewReloadDataAnimationKey")
            self.tableView.reloadData()
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if sortType == NewsSortType.ByType { return 4 }
        return self.arrayAllTypeNews.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sortType == NewsSortType.ByType {
            
            switch ( section ){
            case NewsType.New.rawValue: return self.arrayNew.count
            case NewsType.Declaration.rawValue: return self.arrayDeclaration.count
            case NewsType.Activity.rawValue: return self.arrayActivity.count
            case NewsType.Close.rawValue: return self.arrayClose.count
            default: break
            }
            
        }
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsCell

        var news:PFObject=self.arrayAllTypeNews[indexPath.section]
        
        if sortType == NewsSortType.ByType {
            
            switch ( indexPath.section ){
            case NewsType.New.rawValue: news=self.arrayNew[indexPath.row]
            case NewsType.Declaration.rawValue: news=self.arrayDeclaration[indexPath.row]
            case NewsType.Activity.rawValue:  news=self.arrayActivity[indexPath.row]
            case NewsType.Close.rawValue: news=self.arrayClose[indexPath.row]
            default: break
            }
            
        }
        
        cell.type=NewsType(rawValue: news["Type"] as! Int)!
        cell.tvContent.text=news["Content"] as! String
        cell.tvContent.textColor=UIColor.whiteColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132.0
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if sortType == NewsSortType.ByTime {
            if section < self.arrayAllTypeNews.count-1 { return 2.5 }
        }else{
            if section < 3 { return 15 }
        }
        return 30
            
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        if sortType == NewsSortType.ByTime {
        
            if section == self.arrayAllTypeNews.count-1 { return "最新消息內容如果很長可以捲動歐。" }
            
        }else{
            
            if section == 3 { return "最新消息內容如果很長可以捲動歐。" }
            
        }
        return ""
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sortType == NewsSortType.ByType {
            switch ( section ){
            case NewsType.New.rawValue: return "新貨通報"
            case NewsType.Declaration.rawValue: return "香菇公告"
            case NewsType.Activity.rawValue:  return "活動"
            case NewsType.Close.rawValue: return "偷懶時間"
            default: break
            }
        }
        
        return ""
    }
    
    //MARK: - UI Control Events
    
    func didClickSortBtn(sender:UIButton) -> Void{
        sortType=NewsSortType(rawValue:(sortType.rawValue+1)%2)!
        sender.setTitle( sortType == NewsSortType.ByTime ? "按時間":"按分類", forState: UIControlState.Normal)
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
