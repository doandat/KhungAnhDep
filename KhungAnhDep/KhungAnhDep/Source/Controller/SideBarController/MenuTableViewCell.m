//
//  MenuTableViewCell.m
//  MedisafeRD
//
//  Created by ThucTapiOS on 2/16/16.
//  Copyright © 2016 Ominext. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "config.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_lbTitle setFont:FONT_ROBOTO_REGULAR(17)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
