# MYInfiniteScrollView
MYInfiniteScrollView is a very useful framework for infinite scroll

## 功能介绍
- 只需要创建对象,添加图片数据就可以实现无限滚定, 自动滚动
- 可自定义自动滚动间隔
- 遵守代理协议即可监听滚动图片点击事件

## 示例代码
#### 初始化
```objc
MYInfiniteScrollView *infiniteView = [[MYInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 30, 375, 200)];
    [self.view addSubview:infiniteView];
    infiniteView.images = @[
                    [UIImage imageNamed:@"image0"],
                    [UIImage imageNamed:@"image1"],
                    [UIImage imageNamed:@"image2"],
                    [UIImage imageNamed:@"image3"],
                    [UIImage imageNamed:@"image4"],
                    [UIImage imageNamed:@"image5"],
                    [UIImage imageNamed:@"image6"],
                    [UIImage imageNamed:@"image7"],
                    ];
    infiniteView.timeInterval = 2.0;
    infiniteView.delegate = self;
    self.infiniteView = infiniteView;
```
#### 代理方法
```objc
- (void)infiniteScrollView:(MYInfiniteScrollView *)infiniteScrollView didSelectedItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第%zd个图片", index);
}
```
