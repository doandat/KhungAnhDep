//
//  Helper.h
//  MedisafeRD
//
//  Created by Exlinct on 1/26/16.
//  Copyright © 2016 Ominext. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject


+ (void)showViewController:(UIViewController *)dialogViewController inViewController:(UIViewController *)aViewController withSize:(CGSize)size;
+ (void)showViewController:(UIViewController *)dialogViewController inViewController:(UIViewController *)aViewController withFrame:(CGRect )frame;
+ (void)showViewController:(UIViewController *)dialogViewController withTag:(NSInteger)tag inViewController:(UIViewController *)aViewController withFrame:(CGRect )frame;


+ (void)showViewController:(UIViewController *)dialogViewController inViewController:(UIViewController *)aViewController;
+ (void)showViewController:(UIViewController*)dialogViewController inViewController:(UIViewController*)aViewController marginX:(int)margin_x marginY:(int)margin_y;
+ (void)removeDialogViewController:(UIViewController*)superViewController;
+ (void)removeDialogViewController:(UIViewController*)superViewController withTagDialogViewController:(NSInteger)tagDialogVC;

+ (void)showViewControllerNoMargrinY:(UIViewController*)dialogViewController inViewController:(UIViewController*)aViewController marginX:(int)margin_x ;


+ (NSString *)encodeDataFromDictionary:(NSDictionary *)dic;
//chuyển ảnh sang text dạng base64
+ (NSString *)encodeToBase64String:(UIImage *)imageToEncode;
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
