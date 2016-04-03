//
//  MYInfiniteScrollView.m
//  无限滚动(UIScrollView)
//
//  Created by MY❤️mqq on 16/4/2.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import "MYInfiniteScrollView.h"

@interface MYInfiniteScrollView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
/** 计时器 **/
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation MYInfiniteScrollView

#pragma mark - 系统方法重写
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 添加scrollView
        UIScrollView *scrollView = ({
            scrollView = [[UIScrollView alloc] init];
            scrollView.pagingEnabled = YES;
            scrollView.bounces = NO;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            self.scrollView = scrollView;
            scrollView.delegate = self;
            [self addSubview:scrollView];
            scrollView;
        });
        
        // scrollView中添加imageView
        for (int i=0; i< 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)]];
            
            [scrollView addSubview:imageView];
        }

        // 添加pageControl
        UIPageControl *pageControl = ({
            pageControl = [[UIPageControl alloc] init];
            pageControl.pageIndicatorTintColor = [UIColor greenColor];
            pageControl.currentPageIndicatorTintColor = [UIColor redColor];
            self.pageControl = pageControl;
            [self addSubview:pageControl];
            pageControl;
        });
        
        // 默认时间间隔
        _timeInterval = 1.0;
        
        // 开启定时器
        [self startTimer];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat scrollW = self.frame.size.width;
    CGFloat scrollH = self.frame.size.height;
    
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(3 * scrollW, 0);
    
    for (int i=0; i< 3; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(i * scrollW, 0, scrollW, scrollH);
    }
    
    CGFloat pageControlW = self.images.count * 30;
    CGFloat pageControlH = 30;
    self.pageControl.frame = CGRectMake(scrollW - pageControlW, scrollH - pageControlH, pageControlW, pageControlH);
    self.pageControl.numberOfPages = self.images.count;
    
    [self updateContent];
}

// 设置时间间隔
-(void)setTimeInterval:(CGFloat)timeInterval
{
    _timeInterval = timeInterval;
    [self stopTimer];
    [self startTimer];
}

#pragma mark - 手势监听(代理方法实现)
- (void)imageViewClick:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didSelectedItemAtIndex:)]) {
        [self.delegate infiniteScrollView:self didSelectedItemAtIndex:tap.view.tag];
    }
}

#pragma mark - 计时器方法
- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.frame.size.width, 0) animated:YES];
}

#pragma mark - 更新内容
- (void)updateContent{
    NSInteger page = self.pageControl.currentPage;
    
    for (int i=0; i< 3; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        NSInteger index = 0;
        if (i == 0) {
            index = page - 1;
        }else if (i == 1){
            index = page;
        }else{
            index = page + 1;
        }
        
        if (index == -1) {
            index = self.images.count - 1;
        }else if(index == self.images.count){
            index = 0;
        }
        
        imageView.image = self.images[index];
        imageView.tag = index;
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIImageView *desView = nil;
    CGFloat minDelta = MAXFLOAT;
    
    for (int i=0; i< 3; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat delta = ABS(self.scrollView.contentOffset.x - imageView.frame.origin.x);
        if (delta < minDelta) {
            minDelta = delta;
            desView = imageView;
        }
    }
    
    self.pageControl.currentPage = desView.tag;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
    [self startTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updateContent];
}


@end














