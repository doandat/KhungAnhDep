//
//  MessageViewController.h
//  ThiepMung
//
//  Created by DatDV on 3/11/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageViewController;
@protocol MessageDelegate <NSObject>

@optional
-(void)messageOkPress:(MessageViewController *)messageVC;

@end

@interface MessageViewController : UIViewController

@property (weak, nonatomic) id<MessageDelegate> delegate;
@property (nonatomic) NSString *titleText;
@property (nonatomic) NSString *message;

@property (weak, nonatomic) IBOutlet UIView *viewTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbDes;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;


@end
