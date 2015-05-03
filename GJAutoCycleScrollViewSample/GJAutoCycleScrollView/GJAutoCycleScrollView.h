//
//  GJAutoCycleScrollView.h
//  GJAutoCycleScrollViewSample
//
//  Created by imooc_gj on 15/5/3.
//  Copyright (c) 2015年 devgj. All rights reserved.
//  自动循环滚动视图

#import <UIKit/UIKit.h>

@class  GJAutoCycleScrollView;

@protocol GJAutoCycleScrollViewDataSource <NSObject>

/**
 *  一共有多少页
 *
 *  @param autoCycleScrollView autoCycleScrollView
 *  @return 页数
 */
- (NSInteger)numberOfPagesInAutoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView;

/**
 *  每页图片的图片名或者图片链接
 *
 *  @param autoCycleScrollView autoCycleScrollView
 *  @param index               页索引
 *
 *  @return 每页图片的图片名或者图片链接
 */
- (NSString *)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView imageUrlAtIndex:(NSInteger)index;

@end

@protocol GJAutoCycleScrollViewDelegate <NSObject>

@optional
/**
 *  点击了某一页
 *
 *  @param autoCycleScrollView autoCycleScrollView
 *  @param index               点击页的索引
 */
- (void)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView didSelectPageAtIndex:(NSInteger)index;

@end

/**
 *  自动循环滚动视图
 */
@interface GJAutoCycleScrollView : UIView

/**
 *  你可以自定义位置,默认在底部中间,默认显示,如不需要可自行隐藏
 */
@property (nonatomic, weak, readonly) UIPageControl *pageControl;
/**
 *  自动滚动的时间间隔,默认为3秒
 */
@property (nonatomic, assign) CGFloat timeIntervalForAutoScroll;

/**
 *  是否显示分页
 *
 *  @param show YES 显示，NO 如果不显示，会从父视图移除
 */
//- (void)showPageControl:(BOOL)show;
/**
 *  刷新数据
 */
- (void)reloadData;

/**
 *  数据源
 */
@property (nonatomic, weak) id<GJAutoCycleScrollViewDataSource> dataSource;
/**
 *  代理
 */
@property (nonatomic, weak) id<GJAutoCycleScrollViewDelegate> delegate;

@end
