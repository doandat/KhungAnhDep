//
//  MenuTableViewCell.m
//  MedisafeRD
//
//  Created by ThucTapiOS on 2/16/16.
//  Copyright © 2016 Ominext. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_lbTitle setFont:[UIFont fontWithName:@"Roboto-Regular" size:17]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
