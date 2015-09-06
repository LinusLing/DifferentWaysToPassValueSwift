//
//  KVOViewController.swift
//  DifferentWaysToPassValueSwift
//
//  Created by Linus on 15-9-2.
//  Copyright (c) 2015年 Linus. All rights reserved.
//

import UIKit

class kvo: NSObject {
    var ptitle : String = ""
    dynamic var title : String {
        get {
            return self.ptitle
        }
        set {
            self.ptitle = newValue
        }
    }
    
    override init() {
        println("init")
    }
    
    deinit {
        println("deinit")
    }
}
class KVOViewController: UIViewController {
    var k = kvo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("KVOViewController viewDidLoad")
        self.view.backgroundColor = UIColor.whiteColor()
        
        var label:UILabel = UILabel(frame: CGRect(x: 20, y: 40, width: 400, height: 20))
        label.text = k.title
        self.view.addSubview(label)
        
        var tf:UITextField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 20))
        tf.backgroundColor = UIColor.lightGrayColor()
        tf.text = "Negative Pass Value KVO"
        tf.tag = 13
        self.view.addSubview(tf)
        
//        k.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.New | NSKeyValueObservingOptions.Old, context: nil)
        
        var but:UIButton = UIButton(frame: CGRect(x: 20, y: 140, width: 50, height: 20))
        but.setTitle("返回", forState: UIControlState.Normal)
        but.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(but)
        
        but.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func back(sender:UIButton) {
        var tit = (self.view.viewWithTag(13) as UITextField).text

        k.title = tit //对监听的属性赋值会触发observeValueForKeyPath方法

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit {
//        k.removeObserver(self, forKeyPath: "title", context: nil)
    }

//    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
//        println("observeValueForKeyPath")
//        if keyPath == "title" {
//            println(change)
//            var newvalue: AnyObject? = change["new"]
//            println("the new value is \(newvalue)")
//            k.title = newvalue as String
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
