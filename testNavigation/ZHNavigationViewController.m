//
//  ZHNavigationViewController.m
//  testNavigation
//
//  Created by i-Bejoy on 13-11-23.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "ZHNavigationViewController.h"




static const CGFloat kAnimationDuration = 0.5f;
static const CGFloat kAnimationDelay = 0.0f;
static const CGFloat kMaxBlackMaskAlpha = 0.8f;



@interface ZHNavigationViewController ()

@end

@implementation ZHNavigationViewController



#pragma mark - ChildViewController
- (UIViewController *)currentViewController {
    UIViewController *result = nil;
    if ([self.viewControllers count]>0) {
        result = [self.viewControllers lastObject];
    }
    return result;
}

#pragma mark - ParentViewController
- (UIViewController *)previousViewController {
    UIViewController *result = nil;
    if ([self.viewControllers count]>1) {
        result = [self.viewControllers objectAtIndex:self.viewControllers.count - 2];
    }
    return result;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

- (id) initWithRootViewController:(UIViewController*)rootViewController {
    if (self = [super init]) {
        self.viewControllers = [NSMutableArray arrayWithObject:rootViewController];
        
    }
    return self;
}

- (void) pushViewController:(UIViewController *)viewController
{
    viewController.view.frame = CGRectOffset(self.view.bounds, self.view.bounds.size.width, 0);
    viewController.view.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [UIView animateWithDuration:kAnimationDuration delay:kAnimationDelay options:0 animations:^{
        
        
        
        [self currentViewController].view.frame = CGRectMake(-100, 0, screenWidth, screenHeight);
        viewController.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        
        viewController.view.frame = self.view.bounds;
        
        
    }   completion:^(BOOL finished) {
        if (finished) {
            [self.viewControllers addObject:viewController];

        }
    }];
}
- (void) popViewController
{

//    _animationInProgress = YES;
    if (self.viewControllers.count < 2) {
        return;
    }
    
    UIViewController *currentVC = [self currentViewController];
    UIViewController *previousVC = [self previousViewController];
    [previousVC viewWillAppear:NO];
    [UIView animateWithDuration:kAnimationDuration delay:kAnimationDelay options:0 animations:^{
        //        currentVC.view.frame = CGRectOffset(self.view.bounds, self.view.bounds.size.width, 0);
        //        CGAffineTransform transf = CGAffineTransformIdentity;
        //        previousVC.view.transform = CGAffineTransformScale(transf, 1.0, 1.0);
        //        previousVC.view.frame = self.view.bounds;
        
        previousVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        currentVC.view.frame = CGRectMake(320, 0, screenWidth, screenHeight);
        
//        _blackMask.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [currentVC.view removeFromSuperview];
            [currentVC willMoveToParentViewController:nil];
            [self.view bringSubviewToFront:[self previousViewController].view];
            [currentVC removeFromParentViewController];
            [currentVC didMoveToParentViewController:nil];
            [self.viewControllers removeObject:currentVC];
//            _animationInProgress = NO;
            [previousVC viewDidAppear:NO];
//            handler();
        }
    }];

}



- (void) loadView {
    [super loadView];
    
    UIViewController *rootViewController = [self.viewControllers objectAtIndex:0];
    [rootViewController willMoveToParentViewController:self];
    [self addChildViewController:rootViewController];
    
    UIView * rootView = rootViewController.view;
    rootView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:rootView];
    [rootViewController didMoveToParentViewController:self];

    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor greenColor    ]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




#pragma mark - UIViewController Category
//For Global Access of flipViewController
@implementation UIViewController (ZHNavigationViewController)
@dynamic zhNavigationController;

- (ZHNavigationViewController *)zhNavigationController
{
    
    if([self.parentViewController isKindOfClass:[ZHNavigationViewController class]]){
        return (ZHNavigationViewController*)self.parentViewController;
    }
    else if([self.parentViewController isKindOfClass:[UINavigationController class]] &&
            [self.parentViewController.parentViewController isKindOfClass:[ZHNavigationViewController class]]){
        return (ZHNavigationViewController*)[self.parentViewController parentViewController];
    }
    else{
        return nil;
    }
    
}


@end


