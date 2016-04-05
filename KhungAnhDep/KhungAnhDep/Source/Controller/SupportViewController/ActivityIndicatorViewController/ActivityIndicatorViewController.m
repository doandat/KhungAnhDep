//
//  ActivityIndicatorViewController.m
//  ThiepMung
//
//  Created by DatDV on 3/14/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "ActivityIndicatorViewController.h"

@interface ActivityIndicatorViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ActivityIndicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    self.view.layer.cornerRadius = 10.0f;
    [self applyType:JBWatchActivityIndicatorTypeSegments];
}
- (void)applyType:(JBWatchActivityIndicatorType)type {
    
    self.watchActivityIndicator = [[JBWatchActivityIndicator alloc] initWithType:type];
    [self update];
}


- (void)update {
    self.imageView.image = [self.watchActivityIndicator animatedImageWithDuration:1.0f];
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
