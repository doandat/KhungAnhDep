//
//  MessageViewController.m
//  ThiepMung
//
//  Created by DatDV on 3/11/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_btnOk addTarget:self action:@selector(btnOk:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)viewWillAppear:(BOOL)animated{
    self.view.layer.cornerRadius = 5;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.viewTitle.bounds byRoundingCorners:( UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(5.0, 5.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.viewTitle.bounds;
    maskLayer.path  = maskPath.CGPath;
    self.viewTitle.layer.mask = maskLayer;
    _btnOk.layer.cornerRadius = 5;
    [_lbDes setText:_message];
    [_lbTitle setText:_titleText];
}
- (void)btnOk:(id) sender{
    [self.delegate messageOkPress:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
