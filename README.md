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

反向传值包括 delegate 和闭包两种方式：

### Delegate

RootVC:

```
@IBAction func delegateButtonDidTapped(sender: AnyObject) {
...
    del.delegate = self //设置下一个VC的delegate为当前的rootVC
...
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

### 无向传值

其实就是利用`NSUserDefaults`来存取数据，哈哈。

