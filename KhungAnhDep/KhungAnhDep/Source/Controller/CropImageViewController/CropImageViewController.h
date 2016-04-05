//
//  CropImageViewController.h
//  ThiepMung
//
//  Created by DatDV on 3/10/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class CropImageViewController;
@protocol CropImageDelegate <NSObject>

@required
- (void)cropImageButtonDonePress:(CropImageViewController*)cropImageVC image:(UIImage *)image tag:(NSInteger)tag;

@end

@interface CropImageViewController : BaseViewController
@property (weak, nonatomic) UIImage *imageTest;
@property (nonatomic) CGFloat sizeWidth;
@property (nonatomic) CGFloat sizeHeight;
@property (nonatomic) NSInteger tagImage;

@property (nonatomic, weak) id<CropImageDelegate> delegate;
+(CropImageViewController *)cropImageVC;

@end
