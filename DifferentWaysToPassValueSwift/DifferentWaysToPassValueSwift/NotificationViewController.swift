//
//  NotificationViewController.swift
//  DifferentWaysToPassValueSwift
//
//  Created by Linus on 15-9-7.
//  Copyright (c) 2015年 Linus. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    var positiveValue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("NotificationViewController viewDidLoad")
        self.view.backgroundColor = UIColor.whiteColor()
        
        let tf:UITextField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 20))
        tf.backgroundColor = UIColor.lightGrayColor()
        tf.text = positiveValue
        tf.tag = 10004
        self.view.addSubview(tf)
        
        
        let but:UIButton = UIButton(frame: CGRect(x: 20, y: 140, width: 50, height: 20))
        but.setTitle("返回", forState: UIControlState.Normal)
        but.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(but)
        
        but.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func back(sender:UIButton) {
        let tit = (self.view.viewWithTag(10004) as! UITextField).text
        
        // 发送一个通知，name要对应。单一数据可用object传，多个数据可以用dictionary放进userInfo传
        NSNotificationCenter.defaultCenter().postNotificationName("notifName", object: tit, userInfo: nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
}
