//
//  GJHomeViewController.m
//  GJAutoCycleScrollViewSample
//
//  Created by imooc_gj on 15/5/6.
//  Copyright (c) 2015年 devgj. All rights reserved.
//

#import "GJHomeViewController.h"
#import "GJAdViewController.h"

@interface GJHomeViewController ()

@end

@implementation GJHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    GJAdViewController *ad = [[GJAdViewController alloc] init];
    [self presentViewController:ad animated:YES completion:nil];
}

@end
