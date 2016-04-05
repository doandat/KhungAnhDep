//
//  AddTextTableViewCell.m
//  ThiepMung
//
//  Created by DatDV on 3/9/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "AddTextTableViewCell.h"

@implementation AddTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.viewMessage.layer.borderColor = [UIColor grayColor].CGColor;
    self.viewMessage.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
