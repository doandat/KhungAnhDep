//
//  ShowBackgroundController.m
//  KhungAnhDep
//
//  Created by DatDV on 4/6/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "ShowBackgroundController.h"
#import "CustomNavigationBar.h"

@interface ShowBackgroundController (){
    UITextView  *textView;
    CGFloat widthBounds;
    CGFloat heightBounds;
}

@property (weak, nonatomic) IBOutlet CustomNavigationBar *customNavigationBar;
@property (weak, nonatomic) IBOutlet UIView *viewContain;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) UIImage *backgroundResult;


@end

@implementation ShowBackgroundController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNavigationBar.btnMenu addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.btnMenu setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [self.customNavigationBar.lbTitle setText:@"Wall Paper"];
    [self.customNavigationBar.lbTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:22]];
//    self.backgroundResult = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlBackground]]];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.urlBackground] placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"finish");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnBack:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)saveBackground:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(_backgroundResult, nil, nil, nil);
        ////NSLog(@"Background saved");
    });
    [self.view makeToast:@"Saved"];
}


@end
