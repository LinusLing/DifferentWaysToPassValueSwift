//
//  KVOViewController.swift
//  DifferentWaysToPassValueSwift
//
//  Created by Linus on 15-9-2.
//  Copyright (c) 2015年 Linus. All rights reserved.
//

import UIKit

class kvo: NSObject {
    var ptitle : Double = 0.0
    dynamic var title : Double {
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
        
        
//        k.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.New | NSKeyValueObservingOptions.Old, context: nil)
        k.title = 250.0
        
        var but:UIButton = UIButton(frame: CGRect(x: 20, y: 140, width: 50, height: 20))
        but.setTitle("返回", forState: UIControlState.Normal)
        but.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(but)
        
        but.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func back(sender:UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit {
//        k.removeObserver(self, forKeyPath: "title", context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        println("observeValueForKeyPath")
        if keyPath == "title" {
            println(change)
            var newvalue: AnyObject? = change["new"]
            println("the new value is \(newvalue)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
