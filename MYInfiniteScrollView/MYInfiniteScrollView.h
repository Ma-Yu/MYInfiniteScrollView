//
//  MYInfiniteScrollView.h
//  无限滚动(UIScrollView)
//
//  Created by MY❤️mqq on 16/4/2.
//  Copyright © 2016年 MY❤️mqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYInfiniteScrollView;

@protocol MYInfiniteScrollViewDelegate <NSObject>
@optional
- (void)infiniteScrollView:(MYInfiniteScrollView *)infiniteScrollView didSelectedItemAtIndex:(NSInteger)index;
@end

@interface MYInfiniteScrollView : UIView
/** 图片数据 **/
@property (nonatomic, strong) NSArray<UIImage *> *images;
/** 自动滚动间隔 */
@property (nonatomic, assign) CGFloat timeInterval;

@property (nonatomic, weak, readonly) UIPageControl *pageControl;

/** 代理 **/
@property (nonatomic, weak) id<MYInfiniteScrollViewDelegate> delegate;

@end
