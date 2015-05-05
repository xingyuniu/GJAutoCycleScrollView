//
//  GJViewController.m
//  GJAutoCycleScrollView
//
//  Created by devgj on 15/5/3.
//  Copyright (c) 2015年 devgj. All rights reserved.
//

#import "GJViewController.h"
#import "GJAutoCycleScrollView.h"

@interface GJViewController () <GJAutoCycleScrollViewDataSource, GJAutoCycleScrollViewDelegate>
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation GJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    _webView = webView;
    
//    _imageNames = @[@"yellow0", @"yellow1", @"yellow2", @"yellow3", @"yellow4", @"yellow5"];
    _imageNames = @[@"http://img.mukewang.com/553a16fa0001d50d07500442.jpg", @"http://img.mukewang.com/54bf403f0001ba9506000338.jpg", @"http://img.mukewang.com/5477ea610001494206000338.jpg", @"http://img.mukewang.com/550a33b00001738a06000338.jpg"];
    
    //    http://img.mukewang.com/553a16fa0001d50d07500442.jpg
    //    http://img.mukewang.com/54bf403f0001ba9506000338.jpg
    //    http://img.mukewang.com/5477ea610001494206000338.jpg
    //    http://img.mukewang.com/550a33b00001738a06000338.jpg
    _titles = @[@"这个title真的好长啊1", @"这个title真的好长啊2", @"这个title真的好长啊3", @"这个title真的好长啊4"];
    
    GJAutoCycleScrollView *scrollView = [[GJAutoCycleScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.dataSource = self;
    scrollView.delegate = self;
    scrollView.frame = CGRectMake(10, 60, 300, 200);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, 320, 300) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
}

- (void)call:(id)sender
{
    NSURLRequest *rst = [NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://15123506486"]];
    [_webView loadRequest:rst];
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
    return _imageNames[index];
}

- (NSString *)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView titleAtIndex:(NSInteger)index
{
    return _titles[index];
}

- (void)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView didSelectPageAtIndex:(NSInteger)index
{
    NSLog(@"%ld", (long)index);
}

@end
