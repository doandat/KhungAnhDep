//
//  AddTextTableViewCell.h
//  ThiepMung
//
//  Created by DatDV on 3/9/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTextTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbMessage;
@property (weak, nonatomic) IBOutlet UIView *viewMessage;
@property (weak, nonatomic) IBOutlet UITextView *tvMessage;


@end
