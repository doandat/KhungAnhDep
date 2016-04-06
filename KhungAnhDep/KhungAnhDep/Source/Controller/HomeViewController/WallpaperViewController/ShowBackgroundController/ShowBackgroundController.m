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
    
    if (self.backgroundResult == NULL || false) {
        UIAlertView *alertErr = [[UIAlertView alloc] initWithTitle:@"Cellular Data is turned off" message:@"Turn on cellular data or use Wi-Fi to access data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertErr show];
    }else{
        //NSLog(@"Da vao view Background Result");
        
        // Do any additional setup after loading the view.
        //////NSLog(@"background result: %@",_backgroundResult);
        float ratioWidthHeight = _backgroundResult.size.width/_backgroundResult.size.height;
        float ratioHeightWidth = _backgroundResult.size.height/_backgroundResult.size.width;
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, widthBounds , heightBounds-75)];
        [scrollView setBackgroundColor:[UIColor orangeColor]];
        UIImageView *background = [[UIImageView alloc]init];
        [background setBackgroundColor:[UIColor blueColor]];
        background.image = _backgroundResult;
        if (ratioHeightWidth < (heightBounds-75)/widthBounds) {
            [background setFrame:CGRectMake(0, 70+(heightBounds-60-ratioHeightWidth*widthBounds)/2, widthBounds, ratioHeightWidth*widthBounds)];
            //NSLog(@"chieu rong lon hon");
            //        [scrollView setContentSize:(CGSizeMake( _backgroundResult.size.width,_backgroundResult.size.height))];
            
        }else{
            //NSLog(@"Chieu cao lon hon");
            [background setFrame:CGRectMake((widthBounds-ratioWidthHeight*(heightBounds-75))/2, 70, ratioWidthHeight*(heightBounds-75), heightBounds-75)];
        }
        [self.view addSubview:background];
    }

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
