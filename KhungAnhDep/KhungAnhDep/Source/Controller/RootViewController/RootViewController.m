//
//  RootViewController.m
//  KhungAnhDep
//
//  Created by DatDV on 4/5/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "SidebarViewController.h"

@interface RootViewController ()<SWRevealViewControllerDelegate>

@end

@implementation RootViewController
@synthesize viewController = _viewController;

static RootViewController *sharedInstance;

+(RootViewController*)sharedInstance {
    if (sharedInstance) {
        return sharedInstance;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    sharedInstance = self;
    // Do any additional setup after loading the view from its nib.
    HomeViewController *homeVC  = [[HomeViewController alloc] init];
    SideBarViewController *sidebarViewController = [[SideBarViewController alloc] init];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:sidebarViewController frontViewController:homeVC];
    revealController.delegate = self;
    
    self.viewController = revealController;
    
    self.navigation = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    CGRect frame = self.viewContain.bounds;
    
    if (MU_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                frame.origin.y = 20;
                frame.size.height -= 20;
    }
    
    self.navigation.view.frame = frame;
    self.navigation.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.viewContain addSubview:self.navigation.view];
    [self addChildViewController:self.navigation];
    
}
- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        revealController.frontViewController.view.userInteractionEnabled = YES;
    } else {
        revealController.frontViewController.view.userInteractionEnabled = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
