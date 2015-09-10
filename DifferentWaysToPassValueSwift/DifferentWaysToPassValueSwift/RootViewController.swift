//
//  ViewController.swift
//  DifferentWaysToPassValueSwift
//
//  Created by Linus on 15-9-1.
//  Copyright (c) 2015年 Linus. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, delegateOfNegative {
    
    @IBOutlet weak var positiveTF: UITextField!

    
    var kvc:KVOViewController = KVOViewController() // 全局的KVOvc方便在deinit时removeobserver
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("RootViewController viewDidLoad")

        
        // 注册一个通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notifReceive:", name: "notifName", object: nil)
    }
    
    @IBAction func delegateButtonDidTapped(sender: AnyObject) {
//        setTFValue(sender)
        
        var title = self.positiveTF.text
        
        var del:DelegateViewController = DelegateViewController()
        del.positiveValue = title // 正向传值
        self.presentViewController(del, animated: true, completion: nil)
        
        del.delegate = self // 设置下一个VC的delegate为当前的rootVC
    }
    
    // 实现delegate的方法
    func passValue(str:String) {
        self.positiveTF.text = str
    }
    
    // ------------------------------------
    
    @IBAction func blockButtonDidTapped(sender: AnyObject) {
        self.saveUD(self.positiveTF.text)
        
        var blo:BlockViewController = BlockViewController()
        
        // 设置block中要传递的值的接收方式
        blo.passBlockValue = {
            (title:String) in
            self.positiveTF.text = title
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
        kvc.k.title = self.positiveTF.text
        self.presentViewController(kvc, animated: true, completion: nil)

    }
    
    // 监听对象的属性或者实例变量发生变化，就自动调用该函数，执行相应操作
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "title" {
            println(change)
            var newvalue: AnyObject? = change["new"]
            println("the new value is \(newvalue!)")
            self.positiveTF.text = "\(newvalue!)" // 将监听到的变化值赋值给TF来显示
        }
    }
    
    deinit {
        // removeObserver移除监听
        // add和remove必须对应，否则报错
        kvc.k.removeObserver(self, forKeyPath: "title", context: nil)
        

    // ------------------------------------
        
        // removeObserver移除对应name的通知
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "notifName", object: nil)
        
    }
    
    @IBAction func NotificationButtonDidTapped(sender: AnyObject) {
        var noti:NotificationViewController = NotificationViewController()
        noti.positiveValue = self.positiveTF.text
        
        self.presentViewController(noti, animated: true, completion: nil)
        
    }

    // 每次调用对应name的postNotificationName方法会由selector处理
    func notifReceive(notification:NSNotification) {
        self.positiveTF.text = "\(notification.object!)"
        println("notif : \(notification.name), \(notification.object!)")
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

