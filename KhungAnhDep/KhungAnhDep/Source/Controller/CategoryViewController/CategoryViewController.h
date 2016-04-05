//
//  CategoryViewController.h
//  KhungAnhDep
//
//  Created by DatDV on 4/5/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomNavigationBar.h"

@interface CategoryViewController : BaseViewController

@property (strong, nonatomic) IBOutlet CustomNavigationBar *customNavigationBar;
@property (nonatomic) DCategory *dCategory;
@end
