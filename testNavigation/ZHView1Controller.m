//
//  ZHView1Controller.m
//  testNavigation
//
//  Created by i-Bejoy on 13-11-23.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "ZHView1Controller.h"
#import "ZHNavigationViewController.h"

@interface ZHView1Controller ()

@end

@implementation ZHView1Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)pop
{
    
    [self.zhNavigationController popViewController];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor  ];
    
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setTitle:@"push" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    b.frame = CGRectMake(100, 100, 50, 50);
    
    [self.view addSubview:b];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
