//
//  GJAdViewController.m
//  GJAutoCycleScrollViewSample
//
//  Created by imooc_gj on 15/5/6.
//  Copyright (c) 2015年 devgj. All rights reserved.
//

#import "GJAdViewController.h"
#import "GJAutoCycleScrollView.h"
#import "GJThirdViewController.h"

@interface GJAdViewController ()<GJAutoCycleScrollViewDataSource, GJAutoCycleScrollViewDelegate>
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) GJAutoCycleScrollView *scrollView;
@end

@implementation GJAdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_scrollView invalidateTimer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_scrollView fireTimer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageNames = @[@"yellow0", @"yellow1", @"yellow2", @"yellow3", @"yellow4", @"yellow5"];
    //    _imageNames = @[@"http://img.mukewang.com/553a16fa0001d50d07500442.jpg", @"http://img.mukewang.com/54bf403f0001ba9506000338.jpg", @"http://img.mukewang.com/5477ea610001494206000338.jpg", @"http://img.mukewang.com/550a33b00001738a06000338.jpg"];
    
    //    http://img.mukewang.com/553a16fa0001d50d07500442.jpg
    //    http://img.mukewang.com/54bf403f0001ba9506000338.jpg
    //    http://img.mukewang.com/5477ea610001494206000338.jpg
    //    http://img.mukewang.com/550a33b00001738a06000338.jpg
    _titles = @[@"这个title真的好长啊1", @"这个title真的好长啊2", @"这个title真的好长啊3", @"这个title真的好长啊4", @"这个title真的好长啊5",@"这个title真的好长啊6"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    GJAutoCycleScrollView *scrollView = [[GJAutoCycleScrollView alloc] init];
    [self.view addSubview:scrollView];
//        scrollView.autoScroll = NO;
    scrollView.dataSource = self;
    scrollView.delegate = self;
    scrollView.frame = CGRectMake(10, 60, 300, 200);
    _scrollView = scrollView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)numberOfPagesInAutoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView
{
    return _imageNames.count;
}

- (NSString *)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView imageUrlAtIndex:(NSInteger)index
{
//    NSLog(@"%d", index);
    return _imageNames[index];
}

- (NSString *)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView titleAtIndex:(NSInteger)index
{
    return _titles[index];
}

- (void)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView didSelectPageAtIndex:(NSInteger)index
{
    NSLog(@"%ld", (long)index);
    GJThirdViewController *third = [[GJThirdViewController alloc] init];
    [self presentViewController:third animated:YES completion:nil];
}

@end
