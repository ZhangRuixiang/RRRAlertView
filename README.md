# RRRAlertView

这是一个自定义的alertView，功能和UIAlertView相似，你可以随意修改
直接上图：
<img src="https://github.com/ZhangRuixiang/RRRAlertView/raw/master/shotPic1.png" width="320">
<img src="https://github.com/ZhangRuixiang/RRRAlertView/raw/master/shotPic2.png" width="320"> 

### 使用

```
// 只有两个item
RRRAlertView *alert1 = [[RRRAlertView alloc] initWithTitle:@"倔强的提示" message:@"RRRAlertView 是一个可以自定义的控件，可以随意修改字体颜色大小，你高兴就好" cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];

alert1.indexBlock = ^(RRRAlertView *alert,NSInteger index) {
    NSLog(@"****点击了 item %ld****",(long)index);
};

```

```

// 多个item
RRRAlertView *alert = [[RRRAlertView alloc] initWithTitle:@"倔强的提示" message:@"RRRAlertView 是一个可以自定义的控件，可以随意修改字体颜色大小，你高兴就好" cancelButtonTitle:@"取消" otherButtonTitles:@"小明",@"小红",@"小兰",nil];

alert.indexBlock = ^(RRRAlertView *alert,NSInteger index) {
    NSLog(@"****%ld****",(long)index);
};

```
