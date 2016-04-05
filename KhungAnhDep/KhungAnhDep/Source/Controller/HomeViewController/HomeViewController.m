//
//  HomeViewController.m
//  KhungAnhDep
//
//  Created by DatDV on 4/5/16.
//  Copyright (c) 2016 dd. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

static HomeViewController *sharedInstance;

+ (HomeViewController *)sharedInstance {
    if (sharedInstance) {
        return sharedInstance;
    }
    
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    //custom navigationbar
    [self.customNavigationBar.btnMenu addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.lbTitle setText:@"Home"];
    [self.customNavigationBar.lbTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:22]];
    [self.customNavigationBar.btnBookMark addTarget:self action:@selector(btnBookMark:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.btnReload addTarget:self action:@selector(btnReload:) forControlEvents:UIControlEventTouchUpInside];
//    [self.customNavigationBar.btnBookMark setHidden:YES];
//    [self.customNavigationBar.btnReload setHidden:YES];

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
