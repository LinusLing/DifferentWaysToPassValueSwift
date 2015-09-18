//
//  BlockViewController.swift
//  DifferentWaysToPassValueSwift
//
//  Created by Linus on 15-9-1.
//  Copyright (c) 2015年 Linus. All rights reserved.
//

import UIKit

class BlockViewController: UIViewController {
    
    var passBlockValue:((title:String) -> Void)? // 定义block，包含参数title
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("BlockViewController viewDidLoad")
        self.view.backgroundColor = UIColor.whiteColor()
        
        let tf:UITextField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 20))
        tf.backgroundColor = UIColor.lightGrayColor()
        tf.text = NSUserDefaults().objectForKey("title") as? String
        tf.tag = 10001
        self.view.addSubview(tf)
        
        let but:UIButton = UIButton(frame: CGRect(x: 20, y: 140, width: 50, height: 20))
        but.setTitle("返回", forState: UIControlState.Normal)
        but.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(but)
        
        but.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func back(sender:UIButton) {
        let tf:UITextField = self.view.viewWithTag(10001) as! UITextField
        passBlockValue?(title:tf.text!) // 使用block传递title这个值
        
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
