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
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation GJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    _webView = webView;
    
//    _imageNames = @[@"yellow0", @"yellow1", @"yellow2", @"yellow3", @"yellow4", @"yellow5"];
    _imageNames = @[@"yellow0", @"yellow2"];
    
    GJAutoCycleScrollView *scrollView = [[GJAutoCycleScrollView alloc] init];
    scrollView.frame = CGRectMake(10, 60, 300, 200);
    scrollView.dataSource = self;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
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
    return @"hah";
}

- (void)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView didSelectPageAtIndex:(NSInteger)index
{
    NSLog(@"%ld", (long)index);
}

@end
