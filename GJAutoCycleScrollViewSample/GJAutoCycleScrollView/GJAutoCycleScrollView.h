//
//  GJAutoCycleScrollView.h
//  GJAutoCycleScrollViewSample
//
//  Created by imooc_gj on 15/5/3.
//  Copyright (c) 2015年 devgj. All rights reserved.
//  自动循环滚动视图
//  网络图片功能依赖SDWebImage，
//  如不需要或者你的工程中已经有SDWebImage,可自行删除我提供的
//  如果你的工程中还没有SDWebImage,建议你添加一个,非常好用

// 如需要网络图片的占位图，填充宏内容即可
#define GJPlaceholderImageName @""

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
 *  每页图片的图片名(本地图片)或者图片链接(网络图片)
 *
 *  @param autoCycleScrollView autoCycleScrollView
 *  @param index               页索引
 *
 *  @return 每页图片的图片名或者图片链接
 */
- (NSString *)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView imageUrlAtIndex:(NSInteger)index;

@optional
/**
 *  图片标题(如需要图片标题，则实现该方法。如不实现该方法，则不会创建titleLabel)
 *
 *  @param autoCycleScrollView 这个没啥好说的
 *  @param index               页索引
 *
 *  @return 图片对应的标题
 */
- (NSString *)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView titleAtIndex:(NSInteger)index;

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
 *  分页，你可以自定义位置大小,默认在底部中间; 默认显示,如不需要可自行隐藏
 */
@property (nonatomic, weak, readonly) UIPageControl *pageControl;
/**
 *  自动滚动的时间间隔,默认为3秒
 */
@property (nonatomic, assign) CGFloat timeIntervalForAutoScroll;
/**
 *  是否需要自动滚动 YES:需要 NO:不需要 默认为YES
 */
@property (nonatomic, assign) BOOL autoScroll;

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
