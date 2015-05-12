//
//  GJThirdViewController.m
//  GJAutoCycleScrollViewSample
//
//  Created by devgj on 15/5/7.
//  Copyright (c) 2015年 devgj. All rights reserved.
//

#import "GJThirdViewController.h"

@interface GJThirdViewController ()

@end

@implementation GJThirdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击页面任意位置返回第二页";
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
