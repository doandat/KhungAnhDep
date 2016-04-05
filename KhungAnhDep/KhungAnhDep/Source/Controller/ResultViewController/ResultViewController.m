//
//  ResultViewController.m
//  ThiepMung
//
//  Created by DatDV on 3/11/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController (){
    CGFloat widthBounds;
    CGFloat heightBounds;
    UIImageView *imageView;
}

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:108/255.0f green:46/255.0f blue:184/255.0f alpha:1.0f]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBack:)];
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnDone:)];
    self.navigationItem.leftBarButtonItem = btnBack;
    self.navigationItem.rightBarButtonItem = btnDone;
    self.navigationItem.title = @"Result";
    
    widthBounds = [UIScreen mainScreen].bounds.size.width;
    heightBounds = [UIScreen mainScreen].bounds.size.height;
    
    imageView = [[UIImageView alloc] initWithImage:_imageResult];
    float ratioWidthHeight = _imageResult.size.width/_imageResult.size.height;
    float ratioHeightWidth = _imageResult.size.height/_imageResult.size.width;
    float originYButonCrop;
    //NSLog(@"widthBounds: %f, %f",ratioWidthHeight,ratioHeightWidth);
    if (ratioHeightWidth< (heightBounds-115-70)/widthBounds) {
        NSLog(@"widthBoundswidthBounds");
        [imageView setFrame:CGRectMake(0, 65+(heightBounds-65-ratioHeightWidth*widthBounds)/2, widthBounds, ratioHeightWidth*widthBounds)];
        originYButonCrop = imageView.frame.origin.y+imageView.frame.size.height+20;
    }else{
        
        [imageView setFrame:CGRectMake((widthBounds-ratioWidthHeight*(heightBounds-115))/2, 65, ratioWidthHeight*(heightBounds-115), heightBounds-115)];
        originYButonCrop = imageView.frame.origin.y+imageView.frame.size.height+5;
    }
    
    [imageView setImage:_imageResult];
    
    UIButton *btnShare = [[UIButton alloc]init];
    [btnShare setFrame:CGRectMake(widthBounds/2-110, originYButonCrop,100 , 40)];
    [btnShare addTarget:self action:@selector(btnShare:) forControlEvents:UIControlEventTouchUpInside];
    [btnShare setTitle:@"Share" forState:UIControlStateNormal];
    [btnShare setBackgroundColor:MU_RGB(108, 64, 184)];
    [btnShare setBackgroundImage:[Helper imageWithColor:[UIColor blackColor]] forState:UIControlStateHighlighted];
    [btnShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [crop1 setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    btnShare.layer.cornerRadius = 10.0f;
    btnShare.layer.borderColor = [UIColor whiteColor].CGColor;
    btnShare.clipsToBounds = YES;
    [btnShare.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    UIButton *btnSave = [[UIButton alloc]init];
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    [btnSave setFrame:CGRectMake(widthBounds/2+10, originYButonCrop, 100 , 40)];
    [btnSave addTarget:self action:@selector(btnSave:) forControlEvents:UIControlEventTouchUpInside];
    [btnSave setBackgroundColor:MU_RGB(108, 64, 184)];
    [btnSave setBackgroundImage:[Helper imageWithColor:[UIColor blackColor]] forState:UIControlStateHighlighted];
    [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    btnSave.layer.cornerRadius = 10.0f;
    btnSave.layer.borderColor = [UIColor whiteColor].CGColor;
    btnSave.clipsToBounds = YES;
    [btnSave.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    [self.view setBackgroundColor:MU_RGBA(255, 255, 255, 0.8)];
    
    [self.view addSubview:imageView];
    [self.view addSubview:btnShare];
    [self.view addSubview:btnSave];
    
}

-(void)btnSave:(id) sender{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(_imageResult, nil, nil, nil);
        NSLog(@"image saved");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"Saved image"];
        });
    });
}

-(void)btnShare:(id) sender{
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[_imageResult]
     applicationActivities:nil];
    
    controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypeMessage,
                                         UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)btnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnDone:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
