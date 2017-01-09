# RRRAlertView
这是一个自定义的alertView，功能和UIAlertView相似，你可以随意修改

直接上图：![](https://github.com/ZhangRuixiang/RRRAlertView/raw/master/shotPic1.png)

直接上图：![](https://github.com/ZhangRuixiang/RRRAlertView/raw/master/shotPic2.png)

#usage
```
// 只有两个item
RRRAlertView *alert1 = [[RRRAlertView alloc] initWithTitle:@"这是自定义的alertView" message:@"你可以随意修改字体颜色大小，怎么高兴怎么来" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定1",nil];
// 实现block，等待回调
alert1.indexBlock = ^(RRRAlertView *alert,NSInteger index) {
NSLog(@"****点击了 item %ld****",(long)index);
};

```

```

// 多个item
RRRAlertView *alert = [[RRRAlertView alloc] initWithTitle:@"这是自定义的alertView" message:@"你可以随意修改字体颜色大小，怎么高兴怎么来" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定1",@"确定2",@"确定3",nil];
// 实现block，等待回调
alert.indexBlock = ^(RRRAlertView *alert,NSInteger index) {
NSLog(@"****%ld****",(long)index);
};

```
