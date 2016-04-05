//
//  CropImageViewController.m
//  ThiepMung
//
//  Created by DatDV on 3/10/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "CropImageViewController.h"
#import "Cropper.h"

@interface CropImageViewController (){
    UIImageView *uiViewCrop;
    CGFloat widthBounds;
    CGFloat heightBounds;
}

@property (strong, nonatomic) Cropper *cropper;

@end

@implementation CropImageViewController

+(CropImageViewController *)cropImageVC{
    return [[CropImageViewController alloc] initWithNibName:@"CropImageViewController" bundle:[NSBundle bundleForClass:self.class]];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:MU_RGB(108, 46, 184)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(itemBack:)];
    self.navigationItem.leftBarButtonItem = btnBack;
    self.navigationItem.title = @"Crop Image";
    
    widthBounds = [UIScreen mainScreen].bounds.size.width;
    heightBounds = [UIScreen mainScreen].bounds.size.height;
    
    
    uiViewCrop = [[UIImageView alloc] initWithImage:_imageTest];
    float ratioWidthHeight = _imageTest.size.width/_imageTest.size.height;
    float ratioHeightWidth = _imageTest.size.height/_imageTest.size.width;
    float originYButonCrop;
    //NSLog(@"widthBounds: %f, %f",ratioWidthHeight,ratioHeightWidth);
    if (ratioHeightWidth< (heightBounds-115-70)/widthBounds) {
        [uiViewCrop setFrame:CGRectMake(0, 65+(heightBounds-65-ratioHeightWidth*widthBounds)/2, widthBounds, ratioHeightWidth*widthBounds)];
        originYButonCrop = uiViewCrop.frame.origin.y+uiViewCrop.frame.size.height+20;
    }else{
        
        [uiViewCrop setFrame:CGRectMake((widthBounds-ratioWidthHeight*(heightBounds-115))/2, 65, ratioWidthHeight*(heightBounds-115), heightBounds-115)];
        originYButonCrop = uiViewCrop.frame.origin.y+uiViewCrop.frame.size.height+5;
    }

    UIButton *crop1 = [[UIButton alloc]init];
    [crop1 setFrame:CGRectMake(widthBounds/2-110, originYButonCrop,100 , 40)];
    [crop1 addTarget:self action:@selector(crop1:) forControlEvents:UIControlEventTouchUpInside];
    [crop1 setTitle:@"Crop" forState:UIControlStateNormal];
    [crop1 setBackgroundColor:MU_RGB(108, 46, 184)];
    [crop1 setBackgroundImage:[Helper imageWithColor:[UIColor blackColor]] forState:UIControlStateHighlighted];
    [crop1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [crop1 setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    crop1.layer.cornerRadius = 10.0f;
    crop1.layer.borderColor = [UIColor whiteColor].CGColor;
    crop1.clipsToBounds = YES;
    [crop1.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    UIButton *cancel = [[UIButton alloc]init];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel setFrame:CGRectMake(widthBounds/2+10, originYButonCrop, 100 , 40)];
    [cancel addTarget:self action:@selector(cancel1:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setBackgroundColor:MU_RGB(108, 64, 184)];
    [cancel setBackgroundImage:[Helper imageWithColor:[UIColor blackColor]] forState:UIControlStateHighlighted];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    cancel.layer.cornerRadius = 10.0f;
    cancel.layer.borderColor = [UIColor whiteColor].CGColor;
    cancel.clipsToBounds = YES;
    [cancel.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    [self.view setBackgroundColor:MU_RGBA(255, 255, 255,0.8)];
    
    [self.view addSubview:uiViewCrop];
    [self.view addSubview:crop1];
    [self.view addSubview:cancel];
//    
//    CGFloat sizeWidth1;
//    CGFloat sizeHeight1;
    
    if ((_sizeWidth ==0) || (_sizeHeight == 0)) {
        _sizeWidth = _sizeHeight = 300;
    }
    
//    if (widthBounds<768) {
//        NSLog(@"widthBounds>=768 ipad");
//        if (_sizeWidth >_sizeHeight) {
//            CGFloat ratio = _sizeWidth/_sizeHeight;
//            sizeHeight1 = 200;
//            sizeWidth1 = sizeHeight1*ratio;
//        }else{
//            CGFloat ratio = _sizeHeight/_sizeWidth;
//            sizeWidth1 = 200;
//            sizeHeight1 = sizeWidth1*ratio;
//        }
//    }else{
//        NSLog(@"widthBounds>=768 iphone");
//        if (_sizeWidth >_sizeHeight) {
//            CGFloat ratio = _sizeWidth/_sizeHeight;
//            sizeHeight1 = 400;
//            sizeWidth1 = sizeHeight1*ratio;
//        }else{
//            CGFloat ratio = _sizeHeight/_sizeWidth;
//            sizeWidth1 = 400;
//            sizeHeight1 = sizeWidth1*ratio;
//        }
//    }
    CGFloat with = _sizeWidth;
    CGFloat height = _sizeHeight;
//    self.cropper = [[Cropper alloc] initWithImageView:uiViewCrop InitialCroppingRect:70 y:70 w:sizeWidth1 h:sizeHeight1];
    self.cropper = [[Cropper alloc] initWithImageView:uiViewCrop InitialCroppingRect:70 y:70 w:with h:height];

    NSInteger tagInput = _tagImage;
    __weak CropImageViewController *_self = self;
    _cropper.cropAction = ^(CropperAction action, UIImage *image){
        //        [_self.cropper removeFromSuperview];
        
        //sự kiện khi click vào button cắt ảnh.(đã chọn được vùng cắt)
        if( action == CropperActionDidCrop )
        {
            
            CGRect rect = CGRectMake(0.0, 0.0, with, height);
            UIGraphicsBeginImageContext(rect.size);
            [image drawInRect:rect];
            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
            NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
            UIGraphicsEndImageContext();
            UIImage *image11 = [UIImage imageWithData:imageData];
            [[_self delegate] cropImageButtonDonePress:_self image:image11 tag:tagInput];
            [_self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            
        }
        ////////NSLog(@"aaa 2");
        
        //        [_self.cropButton setEnabled:YES];
    };
    //        [self.navigationController popViewControllerAnimated:YES];
    ////////NSLog(@"aaa 3");
}



- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)crop1:(id)sender
{
    if( self.cropper.cropAction )
    {
        UIImage *image = [self.cropper generateCroppedImage];
        self.cropper.cropAction(CropperActionDidCrop, image);
        //        [self.cropper finishCropper];
    }
}

- (void)cancel1:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)itemBack:(UIButton*)button {
    [self.navigationController dismissViewControllerAnimated:YES
 completion:nil];
}
@end
