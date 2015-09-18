//
//  DelegateViewController.swift
//  DifferentWaysToPassValueSwift
//
//  Created by Linus on 15-9-1.
//  Copyright (c) 2015年 Linus. All rights reserved.
//

import UIKit

protocol delegateOfNegative {
    func passValue(str:String)
}

class DelegateViewController: UIViewController {
    
    var positiveValue:String = String() // 正向传值，接收方
    
    var delegate:delegateOfNegative? // 定义具体的delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("DelegateViewController viewDidLoad")
        self.view.backgroundColor = UIColor.whiteColor()
        
        let tf:UITextField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 20))
        tf.backgroundColor = UIColor.lightGrayColor()
        tf.text = self.positiveValue // 正向传值，赋值
        tf.tag = 10000
        self.view.addSubview(tf)
        
        let but:UIButton = UIButton(frame: CGRect(x: 20, y: 140, width: 50, height: 20))
        but.setTitle("返回", forState: UIControlState.Normal)
        but.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(but)
        
        but.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func back(sender:UIButton) {
        let tf:UITextField = self.view.viewWithTag(10000) as! UITextField
        delegate?.passValue(tf.text!) // 调用delegate的传值方法passValue
        
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
