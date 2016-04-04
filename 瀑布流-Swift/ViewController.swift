//
//  ViewController.swift
//  瀑布流-Swift
//
//  Created by zhuming on 16/3/29.
//  Copyright © 2016年 zhuming. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate{

    var tableView1 : UITableView?
    var tableView2 : UITableView?
    var tableView3 : UITableView?
    var indexPath : NSIndexPath?
    var menbers1 = [NSDictionary]()
    var menbers2 = [NSDictionary]()
    var menbers3 = [NSDictionary]()
    var PICModelArray1 = [PICModel]()
    var PICModelArray2 = [PICModel]()
    var PICModelArray3 = [PICModel]()
    var dataArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let urlString1 = "http://itugo.com/client/ios/api/getpiclist?_version=20140117.2.5.1&_req_from=oc&_source=ios&type=&_uuid=efe47094e00109db8c28cf0ae9b607b9&max=&tag=&_promotion_channel=App%20Store&_platform=iPhone&sort=new&from=tag&_uiid=2FF998CF0D2A40E7AF6F8FAFB8F57538&_net=wifi&min=0";
    let urlString2 = "http://itugo.com/client/ios/api/getpiclist?_version=20140117.2.5.1&_req_from=oc&_source=ios&type=accessary&_uuid=efe47094e00109db8c28cf0ae9b607b9&max=&tag=&_promotion_channel=App%20Store&_platform=iPhone&sort=new&from=tag&_uiid=2FF998CF0D2A40E7AF6F8FAFB8F57538&_net=wifi&min=0";
    let urlString3 = "http://itugo.com/client/ios/api/getpiclist?_version=20140117.2.5.1&_req_from=oc&_source=ios&type=shoes&_uuid=efe47094e00109db8c28cf0ae9b607b9&max=&tag=&_promotion_channel=App%20Store&_platform=iPhone&sort=new&from=tag&_uiid=2FF998CF0D2A40E7AF6F8FAFB8F57538&_net=wifi&min=0";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        
        self.requestData(urlString1)
        self.requestData(urlString2)
        self.requestData(urlString3)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    /**
        初始化表格
     */
    func initTableView() {
        self.tableView1 = UITableView.init(frame: CGRectMake(5, 20, 100, 548))
        self.tableView1!.delegate = self
        self.tableView1!.dataSource = self;
        self.tableView1?.showsVerticalScrollIndicator = false
        self.tableView1!.registerNib(UINib(nibName:"PBTableViewCell", bundle:nil),
                                    forCellReuseIdentifier:"PBTableViewCell")
        self.view .addSubview(self.tableView1!)
        
        self.tableView2 = UITableView.init(frame: CGRectMake(110, 20, 100, 548))
        self.tableView2!.delegate = self
        self.tableView2!.dataSource = self;
        self.tableView2?.showsVerticalScrollIndicator = false
        self.tableView2!.registerNib(UINib(nibName:"PBTableViewCell", bundle:nil),
                                     forCellReuseIdentifier:"PBTableViewCell")
        self.view .addSubview(self.tableView2!)
        
        self.tableView3 = UITableView.init(frame: CGRectMake(215, 20, 100, 548))
        self.tableView3!.delegate = self
        self.tableView3!.dataSource = self;
        self.tableView3?.showsVerticalScrollIndicator = false
        self.tableView3!.registerNib(UINib(nibName:"PBTableViewCell", bundle:nil),
                                     forCellReuseIdentifier:"PBTableViewCell")
        self.view .addSubview(self.tableView3!)
        
    }
    // 网络请求数据
    func requestData(urlString : String){
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL:  url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse?, data:NSData?, error:NSError?) in
            let jsonResult:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options:  NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let dice:NSDictionary = (jsonResult["data"] as? NSDictionary)!
            
            if (url!.isEqual(NSURL(string: self.urlString1))){
                self.menbers1 = dice["data"] as! Array
                print("self.menbers = \(self.menbers1.count)")
                
                for value in self.menbers1{
                    let dice:NSDictionary = value
                    self.PICModelArray1.append(self .makePICModel(dice))
                }
                print("PICModelArray = \(self.PICModelArray1.count)")
                self.tableView1?.reloadData()
            }
            if (url!.isEqual(NSURL(string: self.urlString2))){
                self.menbers2 = dice["data"] as! Array
                print("self.menbers = \(self.menbers2.count)")
                
                for value in self.menbers2{
                    let dice:NSDictionary = value
                    self.PICModelArray2.append(self .makePICModel(dice))
                }
                print("PICModelArray = \(self.PICModelArray2.count)")
                self.tableView2?.reloadData()
            }
            if (url!.isEqual(NSURL(string: self.urlString3))){
                self.menbers3 = dice["data"] as! Array
                print("self.menbers = \(self.menbers3.count)")
                
                for value in self.menbers3{
                    let dice:NSDictionary = value
                    self.PICModelArray3.append(self .makePICModel(dice))
                }
                print("PICModelArray = \(self.PICModelArray3.count)")
                self.tableView3?.reloadData()
            }
        }
    }
    // 数据封装成模型
    func makePICModel(dice : NSDictionary) -> PICModel{
        let model = PICModel.init()
        model.album_id = dice["album_id"] as? NSNumber
        model.brand_name = dice["brand_name"] as? String
        model.created_at = dice["created_at"] as? NSNumber
        model.height = dice["height"] as? NSNumber
        model.id = dice["id"] as? String
        model.new_height = dice["new_height"] as? NSNumber
        model.new_width = dice["new_width"] as? NSNumber
        model.pic_url_d = dice["pic_url_d"] as? String
        model.pic_url_x = dice["pic_url_x"] as? String
        model.price = dice["price"] as? String
        model.title = dice["title"] as? String
        model.width = dice["width"] as? NSNumber
        return model
    }
    // UITableViewDelegate, UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.isEqual(self.tableView1) {
            return self.PICModelArray1.count
        }
        if tableView.isEqual(self.tableView2) {
            return self.PICModelArray2.count
        }
        if tableView.isEqual(self.tableView3) {
            return self.PICModelArray3.count
        }
        return 10;
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    // 设置cell的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.isEqual(self.tableView1) {
            let model = self.PICModelArray1[indexPath.row] as PICModel
            let height = model.new_height as! CGFloat
            return height*0.5
        }
        if tableView.isEqual(self.tableView2) {
            let model = self.PICModelArray2[indexPath.row] as PICModel
            let height = model.new_height as! CGFloat
            return height*0.5
        }
        if tableView.isEqual(self.tableView3) {
            let model = self.PICModelArray3[indexPath.row] as PICModel
            let height = model.new_height as! CGFloat
            return height*0.5
        }
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify:String = "PBTableViewCell"
        let cell:PBTableViewCell = tableView.dequeueReusableCellWithIdentifier(identify)
            as! PBTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        var model:PICModel!
        
        if tableView.isEqual(self.tableView1) {
            model = self.PICModelArray1[indexPath.row] as PICModel
        }
        if tableView.isEqual(self.tableView2) {
            model = self.PICModelArray2[indexPath.row] as PICModel
        }
        if tableView.isEqual(self.tableView3) {
            model = self.PICModelArray3[indexPath.row] as PICModel
        }
        
       
        cell.titleLabel?.text = model.title
        // 异步加载图片
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData.init(contentsOfURL: NSURL(string: model.pic_url_x!)!)
            dispatch_async(dispatch_get_main_queue(), { 
                cell.backImageView?.image = UIImage.init(data: data!)
            })
        }
        
        
        return cell
    }
    // 三个TableView 关联滚动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.isEqual(self.tableView1) {
            self.tableView2?.setContentOffset((self.tableView1?.contentOffset)!, animated: false)
            self.tableView3?.setContentOffset((self.tableView1?.contentOffset)!, animated: false)
        }
        if scrollView.isEqual(self.tableView2) {
            self.tableView1?.setContentOffset((self.tableView2?.contentOffset)!, animated: false)
            self.tableView3?.setContentOffset((self.tableView2?.contentOffset)!, animated: false)
        }
        if scrollView.isEqual(self.tableView3) {
            self.tableView1?.setContentOffset((self.tableView3?.contentOffset)!, animated: false)
            self.tableView2?.setContentOffset((self.tableView3?.contentOffset)!, animated: false)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("row = \(indexPath.row)")
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        self.indexPath = indexPath
        self.showAlView(indexPath)
    }
    // UIAlertView的使用
    func showAlView(indexPath :NSIndexPath){
        let alert = UIAlertView.init(title: "警告", message: "确定删除第\(indexPath.row + 1)行", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alert.show()
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex == 0) {
            NSLog("取消");
        }
        else{
            NSLog("删除\(self.indexPath!.row)")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

