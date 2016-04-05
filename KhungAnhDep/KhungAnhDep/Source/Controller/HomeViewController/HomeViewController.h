//
//  HomeViewController.h
//  KhungAnhDep
//
//  Created by DatDV on 4/5/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomNavigationBar.h"

@interface HomeViewController : BaseViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (strong, nonatomic) IBOutlet CustomNavigationBar *customNavigationBar;
@property (weak, nonatomic) IBOutlet UIView *viewContain;

@property (strong, nonatomic) UIPageViewController *pageController;

+(HomeViewController*)sharedInstance;

@end
