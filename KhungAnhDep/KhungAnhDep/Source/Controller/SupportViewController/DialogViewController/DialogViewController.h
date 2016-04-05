//
//  DialogViewController.h
//  ThiepMung
//
//  Created by DatDV on 3/10/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DialogViewController;
@protocol DialogViewDelegate <NSObject>

@required
- (void)dialogViewController:(DialogViewController *)dialogVC selectIndex:(NSInteger)index;

@end

@interface DialogViewController : UIViewController
+(DialogViewController *)dialogVC;
@property (weak, nonatomic) id<DialogViewDelegate> delegate;
@property (nonatomic) NSArray *arrDataSource;
@property (nonatomic) NSArray *arrImageDes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
