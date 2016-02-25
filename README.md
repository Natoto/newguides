---
###一个新手引导需求
1. 在当前界面上针对某些按钮或视图做提示
2. 有文字或图片的提示
3. 提示的部分显示正常，其他部分被半透明遮盖
4. 提示部分功能正常，可相应各种事件，其他功能不可操作

如下效果：
![效果图](https://raw.githubusercontent.com/Natoto/newguides/master/newguidedemo.gif)

### 实现思路
1. 难点在于使得一个遮罩上面某些区域是可点击的并且没有遮罩而其他区域则被屏蔽了事件
2. 解决难点好像并不是那么简单，需要涉及到遮罩，或者路径，如果对于一些复杂一点的图标，如不规则图形，就变得更麻烦，于是乎网上找了一些资料，看到个比较好的思路
3. 截图法：对于需要被引导的部分，如view，button等，对他做一个截屏，映射到当前的引导界面去，此时只需要转化一下坐标即可。而截图放入的imageview只需要响应点击事件即可了。
4. 总结：有时候我们看到的只是个表象，它的真相可能并不是我们的初衷，转换一下思路或许也是另一片天地。

### 截屏法的启示(假象和视觉差异)
1. 还可以用来做手势滑动返回前一个页面过程中的前一个页面的镜像
2. 可以做弹出层 (push->present)->(dismiss)->push->pop
3. 截图+模糊效果
4. 还有其他地方用到了欢迎大家在评论区告诉我哈

###看图说话
1. 手势返回+弹出层 ([PENG](https://appsto.re/cn/YIbS8.i))
![弹出层](https://raw.githubusercontent.com/Natoto/newguides/master/jieping01.gif)

2. [YYKIT](https://github.com/ibireme/YYKit)
![kkit weibo](https://raw.githubusercontent.com/Natoto/newguides/master/jieping02.gif)
 
提供两个截图的方法 
注意：iOS 7上UIView上提供了drawViewHierarchyInRect:afterScreenUpdates:来截图，速度比renderInContext:快15倍
```
- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}
//iOS 7上UIView上提供了drawViewHierarchyInRect:afterScreenUpdates:来截图，速度比renderInContext:快15倍。
- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}
```

- 新手引导demo https://github.com/Natoto/newguides  
- 原创地址 http://www.jianshu.com/p/2378f99a0c48
