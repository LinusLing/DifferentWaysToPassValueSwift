//
//  ViewController.swift
//  DifferentWaysToPassValueSwift
//
//  Created by Linus on 15-9-1.
//  Copyright (c) 2015年 Linus. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, delegateOfNegative {
    
    @IBOutlet weak var delegateTF: UITextField!
    @IBOutlet weak var KVOTF: UITextField!
    @IBOutlet weak var blockTF: UITextField!
    
    var kvoVariable:String = String()
    
    var kvc:KVOViewController = KVOViewController() //全局的KVOvc方便在deinit时removeobserver
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("RootViewController viewDidLoad")
        
        var center = NSNotificationCenter.defaultCenter()
        var mainq = NSOperationQueue.mainQueue()
        addObserver(self, forKeyPath: "kvoVariable", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    @IBAction func delegateButtonDidTapped(sender: AnyObject) {
        
        var title = self.delegateTF.text
        
        var del:DelegateViewController = DelegateViewController()
        del.positiveValue = title //正向传值
        self.presentViewController(del, animated: true, completion: nil)
        
        del.delegate = self //设置下一个VC的delegate为当前的rootVC
    }
    
    //实现delegate的方法
    func passValue(str:String) {
        self.delegateTF.text = str
    }
    
    // ------------------------------------
    
    @IBAction func blockButtonDidTapped(sender: AnyObject) {
        self.saveUD(self.blockTF.text)
        
        var blo:BlockViewController = BlockViewController()
        
        //设置block中要传递的值的接收方式
        blo.passBlockValue = {
            (title:String) in
            self.blockTF.text = title
        }
        
        self.presentViewController(blo, animated: true, completion: nil)
    }
    
    func saveUD(title:String) {
        NSUserDefaults().setObject(title, forKey: "title")
        NSUserDefaults().synchronize()
    }
    
    // ------------------------------------
    
    @IBAction func KVOButtonDidTapped(sender: AnyObject) {
        
        kvc.k = kvo()
        
        // addObserver添加监听
        kvc.k.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.Old | NSKeyValueObservingOptions.New, context: nil)
        kvc.k.title = self.KVOTF.text
        self.presentViewController(kvc, animated: true, completion: nil)
        
        
    }
    
    // 监听对象的属性或者实例变量发生变化，就自动调用该函数，执行相应操作
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "title" {
            println(change)
            var newvalue: AnyObject? = change["new"]
            println("the new value is \(newvalue!)")
            self.KVOTF.text = "\(newvalue!)"
        }
    }
    
    deinit {
        // removeObserver移除监听
        // add和remove必须对应，否则报错
        kvc.k.removeObserver(self, forKeyPath: "title", context: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

