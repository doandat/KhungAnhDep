//
//  ActivityIndicatorViewController.h
//  ThiepMung
//
//  Created by DatDV on 3/14/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBWatchActivityIndicator.h"

@interface ActivityIndicatorViewController : UIViewController

@property (nonatomic, readwrite, strong) JBWatchActivityIndicator *watchActivityIndicator;

@end
