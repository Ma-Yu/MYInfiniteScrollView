//
//  ViewController.m
//  无限滚动(UIScrollView)
//
//  Created by MY❤️mqq on 16/4/2.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import "ViewController.h"
#import "MYInfiniteScrollView.h"

@interface ViewController ()<MYInfiniteScrollViewDelegate>
/** <#名字#> **/
@property (nonatomic, weak) MYInfiniteScrollView *infiniteView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
}


- (void)infiniteScrollView:(MYInfiniteScrollView *)infiniteScrollView didSelectedItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第%zd个图片", index);
}
@end
