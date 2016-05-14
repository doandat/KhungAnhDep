//
//  ResultViewController.m
//  ThiepMung
//
//  Created by DatDV on 3/11/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "ResultViewController.h"
#import "CustomNavigationBar.h"

@interface ResultViewController (){
    CGFloat widthBounds;
    CGFloat heightBounds;
    UIImageView *imageView;
}

@property (weak, nonatomic) IBOutlet CustomNavigationBar *customNavigationBar;
@property (weak, nonatomic) IBOutlet UIView *viewContain;


@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self.customNavigationBar.btnMenu addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.btnMenu setImage:IMAGE_BACK forState:UIControlStateNormal];
    [self.customNavigationBar.btnReload setImage:IMAGE_CLOSE forState:UIControlStateNormal];
    [self.customNavigationBar.btnReload addTarget:self action:@selector(btnDone:) forControlEvents:UIControlEventTouchUpInside];

    [self.customNavigationBar.lbTitle setText:@"Result"];
    [self.customNavigationBar.lbTitle setFont:FONT_ROBOTO_MEDIUM(20)];
    
    widthBounds = [UIScreen mainScreen].bounds.size.width;
    heightBounds = [UIScreen mainScreen].bounds.size.height;
    
    imageView = [[UIImageView alloc] initWithImage:self.imageResult];
    float ratioWidthHeight = self.imageResult.size.width/self.imageResult.size.height;
    float ratioHeightWidth = self.imageResult.size.height/self.imageResult.size.width;
    float originYButonCrop;
    //NSLog(@"widthBounds: %f, %f",ratioWidthHeight,ratioHeightWidth);
    if (ratioHeightWidth< (heightBounds-115-70)/widthBounds) {
        NSLog(@"widthBoundswidthBounds");
        [imageView setFrame:CGRectMake(0, 0+(heightBounds-65-ratioHeightWidth*widthBounds)/2, widthBounds, ratioHeightWidth*widthBounds)];
        originYButonCrop = imageView.frame.origin.y+imageView.frame.size.height+20;
    }else{
        
        [imageView setFrame:CGRectMake((widthBounds-ratioWidthHeight*(heightBounds-115))/2, 0, ratioWidthHeight*(heightBounds-115), heightBounds-115)];
        originYButonCrop = imageView.frame.origin.y+imageView.frame.size.height+5;
    }
    
    [imageView setImage:self.imageResult];
    
    UIButton *btnShare = [[UIButton alloc]init];
    [btnShare setFrame:CGRectMake(widthBounds/2-110, originYButonCrop,100 , 40)];
    [btnShare addTarget:self action:@selector(btnShare:) forControlEvents:UIControlEventTouchUpInside];
    [btnShare setTitle:@"Share" forState:UIControlStateNormal];
    [btnShare setBackgroundColor:NAVIGATIONBAR_COLOR];
    [btnShare setBackgroundImage:[Helper imageWithColor:[UIColor blackColor]] forState:UIControlStateHighlighted];
    [btnShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [crop1 setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    btnShare.layer.cornerRadius = 10.0f;
    btnShare.layer.borderColor = [UIColor whiteColor].CGColor;
    btnShare.clipsToBounds = YES;
    [btnShare.titleLabel setFont:FONT_ROBOTO_MEDIUM(20)];
    
    UIButton *btnSave = [[UIButton alloc]init];
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    [btnSave setFrame:CGRectMake(widthBounds/2+10, originYButonCrop, 100 , 40)];
    [btnSave addTarget:self action:@selector(btnSave:) forControlEvents:UIControlEventTouchUpInside];
    [btnSave setBackgroundColor:NAVIGATIONBAR_COLOR];
    [btnSave setBackgroundImage:[Helper imageWithColor:[UIColor blackColor]] forState:UIControlStateHighlighted];
    [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    btnSave.layer.cornerRadius = 10.0f;
    btnSave.layer.borderColor = [UIColor whiteColor].CGColor;
    btnSave.clipsToBounds = YES;
    [btnSave.titleLabel setFont:FONT_ROBOTO_MEDIUM(20)];
    
    [self.viewContain setBackgroundColor:MU_RGBA(255, 255, 255, 0.8)];
    
    [self.viewContain addSubview:imageView];
    [self.viewContain addSubview:btnShare];
    [self.viewContain addSubview:btnSave];
    
}

-(void)btnSave:(id) sender{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(self.imageResult, nil, nil, nil);
        NSLog(@"image saved");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"Saved image"];
        });
    });
}

-(void)btnShare:(id) sender{
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[self.imageResult]
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
