//
//  GJAdViewController.m
//  GJAutoCycleScrollViewSample
//
//  Created by devgj on 15/5/6.
//  Copyright (c) 2015年 devgj. All rights reserved.
//

#import "GJAdViewController.h"
#import "GJAutoCycleScrollView.h"
#import "GJThirdViewController.h"

@interface GJAdViewController ()<GJAutoCycleScrollViewDataSource, GJAutoCycleScrollViewDelegate>
/**
 *  图片名称或者图片链接
 */
@property (nonatomic, strong) NSArray *imageNames;
/**
 *  图片标题
 */
@property (nonatomic, strong) NSArray *titles;
/**
 *  Banner
 */
@property (nonatomic, weak) GJAutoCycleScrollView *adScrollView;
@end

@implementation GJAdViewController

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 当页面出现的时候，启用定时器。当然如果你不需要自动滚动功能，则不需要写这一句
    [self.adScrollView fireTimer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    // 添加GJAutoCycleScrollView
    [self.view addSubview:self.adScrollView];
    
    // 添加提示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, self.view.bounds.size.width, 120)];
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击图片进入第三页.\n\n点击黄色背景回到第一页，此时控制台会打印'GJAutoCycleScrollView 销毁了', 用于测试是否内存泄漏.";
    [self.view addSubview:label];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 当页面消失的时候，停用定时器，优化性能。当然如果你不需要自动滚动功能，则不需要写这一句
    [self.adScrollView invalidateTimer];
}

#pragma mark - GJAutoCycleScrollViewDataSource

- (NSInteger)numberOfPagesInAutoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView
{
    return self.imageNames.count;
}

- (NSString *)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView imageUrlAtIndex:(NSInteger)index
{
    return self.imageNames[index];
}

- (NSString *)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView titleAtIndex:(NSInteger)index
{
    return self.titles[index];
}

#pragma mark - GJAutoCycleScrollViewDelegate

- (void)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView didSelectPageAtIndex:(NSInteger)index
{
    GJThirdViewController *third = [[GJThirdViewController alloc] init];
    [self presentViewController:third animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark getter & setter

- (NSArray *)imageNames
{
    if (_imageNames == nil) {
        _imageNames = @[@"yellow0",
                        @"http://d.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=209c55050b23dd54357eaf3ab060d8bb/728da9773912b31b5bdee4488418367adab4e125.jpg",
                        @"yellow2",
                        @"http://g.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=797df575ba99a9012f3853647cfc611e/37d12f2eb9389b50298fc9338735e5dde7116e5a.jpg"];
    }
    return _imageNames;
}

- (NSArray *)titles
{
    if (_titles == nil) {
        _titles = @[@"第一页，本地图片", @"第二页，网络图片", @"第三页，本地图片", @"第四页，网络图片"];
    }
    return _titles;
}

- (GJAutoCycleScrollView *)adScrollView
{
    if (_adScrollView == nil) {
        GJAutoCycleScrollView *adScrollView = [[GJAutoCycleScrollView alloc] init];
        //        scrollView.autoScroll = NO; //是否需要自动滚动。默认为自动滚动
        adScrollView.dataSource = self;
        adScrollView.delegate = self;
        adScrollView.frame = CGRectMake(10, 60, 300, 200);
        _adScrollView = adScrollView;
    }
    return _adScrollView;
}

@end
