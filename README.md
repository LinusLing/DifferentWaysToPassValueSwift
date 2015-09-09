# DifferentWaysToPassValueSwift

这是一个工程，展示了如何使用 Swift 进行传值，包括正向传值、反向传值和无向传值。

## Demo

![](https://raw.githubusercontent.com/kevin833752/DifferentWaysToPassValueSwift/master/DifferentWaysToPassValueSwift/demo.gif)

## 正向传值

RootVC:

```
var del:DelegateViewController = DelegateViewController()
del.positiveValue = title //正向传值
self.presentViewController(del, animated: true, completion: nil)
```

DelegateVC:

```
var positiveValue:String = String() //正向传值，接收方
```

## 反向传值

反向传值包括 delegate 、闭包、KVO 和 Notification 四种种方式：

### Delegate

RootVC:

```
@IBAction func delegateButtonDidTapped(sender: AnyObject) {
    ...
    del.delegate = self //设置下一个VC的delegate为当前的rootVC
    ...
}
```

```
//实现delegate的方法
func passValue(str:String) {
    self.delegateTF.text = str
}
```

DelegateVC:

```
var delegate:delegateOfNegative? //定义具体的delegate
```

```
func back(sender:UIButton) {
    var tf:UITextField = self.view.viewWithTag(10) as UITextField
    delegate?.passValue(tf.text) //调用delegate的传值方法passValue
    self.dismissViewControllerAnimated(true, completion: nil)
}
```

### 闭包

RootVC:

```
@IBAction func blockButtonDidTapped(sender: AnyObject) {
    ...
    var blo:BlockViewController = BlockViewController()
    //设置block中要传递的值的接收方式
    blo.passBlockValue = {
        (title:String) in
        self.blockTF.text = title
    }
    self.presentViewController(blo, animated: true, completion: nil)
}
```

BlockVC:

```
var passBlockValue:((title:String) -> Void)? //定义block，包含参数title
```

```
func back(sender:UIButton) {
    var tf:UITextField = self.view.viewWithTag(11) as UITextField
    passBlockValue?(title:tf.text) //使用block传递title这个值
    self.dismissViewControllerAnimated(true, completion: nil)
}
```

### KVO

KVO只要是监听的属性，不管是正向还是反向都会触发`observeValueForKeyPath`方法，在其中做相应的显示即可。

RootVC:

```
var kvc:KVOViewController = KVOViewController() //全局的KVOvc方便在deinit时removeobserver
```

```
@IBAction func KVOButtonDidTapped(sender: AnyObject) {
    kvc.k = kvo()
        
    // addObserver添加监听
    kvc.k.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.Old | NSKeyValueObservingOptions.New, context: nil)
    
    kvc.k.title = self.KVOTF.text
    
    self.presentViewController(kvc, animated: true, completion: nil)
}
```

```
// 监听对象的属性或者实例变量发生变化，就自动调用该函数，执行相应操作
override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
    if keyPath == "title" {
        println(change)
        var newvalue: AnyObject? = change["new"]
        println("the new value is \(newvalue!)")
        self.KVOTF.text = "\(newvalue!)" //将监听到的变化值赋值给TF来显示
    }
}

deinit {
    // removeObserver移除监听
    // add和remove必须对应，否则报错
    kvc.k.removeObserver(self, forKeyPath: "title", context: nil)
}
```

KVOVC:

```
//要监听的对象的定义
class kvo: NSObject {
    var ptitle : String = ""
    
    // dynamic修饰的即为可支持KVO
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
```

```
func back(sender:UIButton) {
    var tit = (self.view.viewWithTag(13) as UITextField).text
    
    k.title = tit //对监听的属性赋值会触发observeValueForKeyPath方法
    
    self.dismissViewControllerAnimated(true, completion: nil)
}
```

### Notification

RootVC:

viewDidLoad:
```
// 注册一个通知
NSNotificationCenter.defaultCenter().addObserver(self, selector: "notifReceive:", name: "notifName", object: nil)
```

```
@IBAction func NotificationButtonDidTapped(sender: AnyObject) {
    var noti:NotificationViewController = NotificationViewController()
    noti.positiveValue = self.NotificationTF.text
    
    self.presentViewController(noti, animated: true, completion: nil)
    
}

// 每次调用对应name的postNotificationName方法会由selector处理
func notifReceive(notification:NSNotification) {
    self.NotificationTF.text = "\(notification.object!)"
    println("notif : \(notification.name), \(notification.object!)")
}

deinit {
    ...
    // removeObserver移除对应name的通知
    NSNotificationCenter.defaultCenter().removeObserver(self, name: "notifName", object: nil)
}
```

NSNotificationVC:

```
func back(sender:UIButton) {
    var tit = (self.view.viewWithTag(14) as UITextField).text
    
    // 发送一个通知，name要对应。单一数据可用object传，多个数据可以用dictionary放进userInfo传
    NSNotificationCenter.defaultCenter().postNotificationName("notifName", object: tit, userInfo: nil)
    
    self.dismissViewControllerAnimated(true, completion: nil)
}
```

## 无向传值

* 其实就是利用`NSUserDefaults`来存取数据，哈哈。

## PS

所谓“反向传值”只是在业务逻辑上是从第二个VC回到第一个VC的过程中传值。并不是说列出的几种传值方式只能在反向情况下使用。
