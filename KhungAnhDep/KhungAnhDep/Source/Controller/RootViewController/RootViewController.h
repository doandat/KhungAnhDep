//
//  RootViewController.h
//  KhungAnhDep
//
//  Created by DatDV on 4/5/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "SWRevealViewController.h"

@class SWRevealViewController;


@interface RootViewController : BaseViewController

@property (nonatomic, strong) UINavigationController *navigation;

@property (strong, nonatomic) SWRevealViewController *viewController;
@property (weak, nonatomic) IBOutlet UIView *viewContain;

+(RootViewController*)sharedInstance;

@end
