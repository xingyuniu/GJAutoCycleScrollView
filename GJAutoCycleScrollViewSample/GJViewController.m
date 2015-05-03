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
@end

@implementation GJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imageNames = @[@"h1.jpg", @"h2.jpg", @"h3.jpg", @"h4.jpg"];
    
    GJAutoCycleScrollView *scrollView = [[GJAutoCycleScrollView alloc] init];
    scrollView.frame = CGRectMake(10, 100, 320, 200);
    scrollView.dataSource = self;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
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

- (void)autoCycleScrollView:(GJAutoCycleScrollView *)autoCycleScrollView didSelectPageAtIndex:(NSInteger)index
{
    NSLog(@"%d", index);
}

@end
