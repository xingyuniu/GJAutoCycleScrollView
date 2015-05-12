//
//  GJHomeViewController.m
//  GJAutoCycleScrollViewSample
//
//  Created by devgj on 15/5/6.
//  Copyright (c) 2015年 devgj. All rights reserved.
//

#import "GJHomeViewController.h"
#import "GJAdViewController.h"

@interface GJHomeViewController ()

@end

@implementation GJHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击页面任意位置进入第二页";
    [self.view addSubview:label];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    GJAdViewController *ad = [[GJAdViewController alloc] init];
    [self presentViewController:ad animated:YES completion:nil];
}

@end
