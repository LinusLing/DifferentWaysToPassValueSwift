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
    
    @IBOutlet weak var blockTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("RootViewController viewDidLoad")
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

