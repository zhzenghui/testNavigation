//
//  ZHViewController.m
//  testNavigation
//
//  Created by i-Bejoy on 13-11-23.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "ZHViewController.h"
#import "ZHNavigationViewController.h"
#import "ZHView1Controller.h"

@interface ZHViewController ()

@end

@implementation ZHViewController

- (void)push
{
    
    ZHView1Controller *v1 = [[ZHView1Controller alloc] init ];
    [self.zhNavigationController pushViewController:v1];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setTitle:@"push" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    b.frame = CGRectMake(100, 100, 50, 50);
    
    [self.view addSubview:b];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
