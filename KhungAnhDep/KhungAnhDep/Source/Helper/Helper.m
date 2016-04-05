//
//  Helper.m
//  MedisafeRD
//
//  Created by Exlinct on 1/26/16.
//  Copyright © 2016 Ominext. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (void)showViewController:(UIViewController *)dialogViewController inViewController:(UIViewController *)aViewController withSize:(CGSize)size{
    UIViewController *loadingViewController = [[UIViewController alloc]init];
    loadingViewController.view.frame = CGRectMake(0, 0, aViewController.view.bounds.size.width, aViewController.view.bounds.size.height);
    loadingViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    loadingViewController.view.tag = 1000;
    
    
    CGRect frameChildView = dialogViewController.view.frame;
    CGRect frameFatherView = aViewController.view.frame;
    //    frame.origin.x = (aViewController.view.frame.size.width - frame.size.width)/2;
    //    frame.origin.y = (aViewController.view.frame.size.height - frame.size.height)/2;
    frameChildView = CGRectMake((frameFatherView.size.width - size.width)/2, (frameFatherView.size.height - size.height)/2, size.width , size.height);
    //    frameChildView = CGRectMake(margin_x, margin_y, dialogViewController.view.frame.size.width, dialogViewController.view.frame.size.height);
    dialogViewController.view.center = loadingViewController.view.center;
    dialogViewController.view.frame = frameChildView;
    [loadingViewController addChildViewController:dialogViewController];
    [loadingViewController.view addSubview:dialogViewController.view];
    [aViewController addChildViewController:loadingViewController];
    [aViewController.view addSubview:loadingViewController.view];
}

+ (void)showViewController:(UIViewController *)dialogViewController inViewController:(UIViewController *)aViewController withFrame:(CGRect )frame{
    UIViewController *loadingViewController = [[UIViewController alloc]init];
    loadingViewController.view.frame = CGRectMake(0, 0, aViewController.view.bounds.size.width, aViewController.view.bounds.size.height);
    loadingViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.08];
    loadingViewController.view.tag = 1000;
    
    
    CGRect frameChildView = dialogViewController.view.frame;
    __unused CGRect frameFatherView = aViewController.view.frame;
    //    frame.origin.x = (aViewController.view.frame.size.width - frame.size.width)/2;
    //    frame.origin.y = (aViewController.view.frame.size.height - frame.size.height)/2;
    
    frameChildView = frame;
    
    dialogViewController.view.center = loadingViewController.view.center;
    dialogViewController.view.frame = frameChildView;
    dialogViewController.view.tag = 1001;
    [loadingViewController addChildViewController:dialogViewController];
    [loadingViewController.view addSubview:dialogViewController.view];
    [aViewController addChildViewController:loadingViewController];
    [aViewController.view addSubview:loadingViewController.view];
}

+ (void)showViewController:(UIViewController *)dialogViewController withTag:(NSInteger)tag inViewController:(UIViewController *)aViewController withFrame:(CGRect )frame{
    UIViewController *loadingViewController = [[UIViewController alloc]init];
    loadingViewController.view.frame = CGRectMake(0, 0, aViewController.view.bounds.size.width, aViewController.view.bounds.size.height);
    loadingViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.08];
    loadingViewController.view.tag = tag;
    
    
    CGRect frameChildView = dialogViewController.view.frame;
    __unused CGRect frameFatherView = aViewController.view.frame;
    //    frame.origin.x = (aViewController.view.frame.size.width - frame.size.width)/2;
    //    frame.origin.y = (aViewController.view.frame.size.height - frame.size.height)/2;
    
    frameChildView = frame;
    
    dialogViewController.view.center = loadingViewController.view.center;
    dialogViewController.view.frame = frameChildView;
    dialogViewController.view.tag = tag+1;
    [loadingViewController addChildViewController:dialogViewController];
    [loadingViewController.view addSubview:dialogViewController.view];
    [aViewController addChildViewController:loadingViewController];
    [aViewController.view addSubview:loadingViewController.view];
}

+(void)showViewController:(UIViewController *)dialogViewController inViewController:(UIViewController *)aViewController{
    UIViewController *loadingViewController = [[UIViewController alloc]init];
    loadingViewController.view.frame = CGRectMake(0, 0, aViewController.view.bounds.size.width, aViewController.view.bounds.size.height);
    loadingViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    loadingViewController.view.tag = 1000;
    
    CGRect frameChildView = dialogViewController.view.frame;
    CGRect frameFatherView = aViewController.view.frame;
    //    frame.origin.x = (aViewController.view.frame.size.width - frame.size.width)/2;
    //    frame.origin.y = (aViewController.view.frame.size.height - frame.size.height)/2;
    frameChildView = CGRectMake(0, 0, frameFatherView.size.width , frameFatherView.size.height);
    //    frameChildView = CGRectMake(margin_x, margin_y, dialogViewController.view.frame.size.width, dialogViewController.view.frame.size.height);
    //    dialogViewController.view.center = loadingViewController.view.center;
    dialogViewController.view.frame = frameChildView;
    [loadingViewController addChildViewController:dialogViewController];
    [loadingViewController.view addSubview:dialogViewController.view];
    [aViewController addChildViewController:loadingViewController];
    [aViewController.view addSubview:loadingViewController.view];
}

+ (void)showViewController:(UIViewController*)dialogViewController inViewController:(UIViewController*)aViewController marginX:(int)margin_x marginY:(int)margin_y{
    UIViewController *loadingViewController = [[UIViewController alloc]init];
    loadingViewController.view.frame = CGRectMake(0, 0, aViewController.view.bounds.size.width, aViewController.view.bounds.size.height);
    loadingViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    loadingViewController.view.tag = 1000;
    
    
    CGRect frameChildView = dialogViewController.view.frame;
    __unused CGRect frameFatherView = aViewController.view.frame;
    //    frame.origin.x = (aViewController.view.frame.size.width - frame.size.width)/2;
    //    frame.origin.y = (aViewController.view.frame.size.height - frame.size.height)/2;
    
    frameChildView = CGRectMake(margin_x, margin_y, aViewController.view.frame.size.width - 2*margin_x, aViewController.view.frame.size.height - 2*margin_y);
    
    dialogViewController.view.center = loadingViewController.view.center;
    dialogViewController.view.frame = frameChildView;
    [loadingViewController addChildViewController:dialogViewController];
    [loadingViewController.view addSubview:dialogViewController.view];
    [aViewController addChildViewController:loadingViewController];
    [aViewController.view addSubview:loadingViewController.view];
}

+ (void)showViewControllerNoMargrinY:(UIViewController*)dialogViewController inViewController:(UIViewController*)aViewController marginX:(int)margin_x {
    
    UIViewController *loadingViewController = [[UIViewController alloc]init];
    loadingViewController.view.frame = CGRectMake(0, 0, aViewController.view.bounds.size.width, aViewController.view.bounds.size.height);
    loadingViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    loadingViewController.view.tag = 1000;
    
    
    CGRect frameChildView = dialogViewController.view.frame;
    __unused CGRect frameFatherView = aViewController.view.frame;
    //    frame.origin.x = (aViewController.view.frame.size.width - frame.size.width)/2;
    //    frame.origin.y = (aViewController.view.frame.size.height - frame.size.height)/2;
    
    frameChildView = CGRectMake(margin_x, (aViewController.view.frame.size.width - 200)*1.25 , aViewController.view.frame.size.width - 2*margin_x, 210);
    
    dialogViewController.view.center = loadingViewController.view.center;
    dialogViewController.view.frame = frameChildView;
    [loadingViewController addChildViewController:dialogViewController];
    [loadingViewController.view addSubview:dialogViewController.view];
    [aViewController addChildViewController:loadingViewController];
    [aViewController.view addSubview:loadingViewController.view];
    
    
}

+ (void)removeDialogViewController:(UIViewController*)superViewController{
    for (UIViewController *aViewController in superViewController.childViewControllers) {
        if (aViewController.view.tag == 1000 && [aViewController isKindOfClass:[UIViewController class]]) {
            [aViewController removeFromParentViewController];
            [aViewController.view removeFromSuperview];
        }
    }
}

+ (void)removeDialogViewController:(UIViewController*)superViewController withTagDialogViewController:(NSInteger)tagDialogVC{
    for (UIViewController *aViewController in superViewController.childViewControllers) {
        if (aViewController.view.tag == tagDialogVC && [aViewController isKindOfClass:[UIViewController class]]) {
            [aViewController removeFromParentViewController];
            [aViewController.view removeFromSuperview];
        }
    }
}

+ (NSString *)encodeDataFromDictionary:(NSDictionary *)dic{
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dic) {
        
        NSString *encodedValue = [dic objectForKey:key];
        NSString *encodedString1 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                         NULL,
                                                                                                         (CFStringRef)encodedValue,
                                                                                                         NULL,
                                                                                                         (CFStringRef)@"!*'&();:@+$,/?%#[]",
                                                                                                         kCFStringEncodingUTF8 ));
        NSString *encodedKey = key;
        NSString *encodedString2 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                         NULL,
                                                                                                         (CFStringRef)encodedKey,
                                                                                                         NULL,
                                                                                                         (CFStringRef)@"!*'&();:@+$,/?%#[]",
                                                                                                         kCFStringEncodingUTF8 ));
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedString2, encodedString1];
        [parts addObject:part];
    }
    
    return [parts componentsJoinedByString:@"&"];
}

//chuyển ảnh sang text dạng base64
+ (NSString *)encodeToBase64String:(UIImage *)imageToEncode {
    return [UIImagePNGRepresentation(imageToEncode) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
