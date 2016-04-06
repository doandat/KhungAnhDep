//
//  AppService.h
//  ThiepMung
//
//  Created by Doan Dat on 3/11/16.
//  Copyright © 2016 Amobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "config.h"
#import "DCategory.h"
#import "DEffect.h"
#import "DInputLine.h"
#import "DInputPic.h"
#import "DCategoryTheme.h"
#import "DTheme.h"

@interface AppService : NSObject

+ (NSDictionary*) getDicFromUrlString:(NSString*)urlString;
+ (NSArray *) getDCategoryFromUrlString:(NSString *)urlString;
+ (NSArray *) getEffectListWithCategoryId:(NSString *)dCategoryId;
+ (NSArray *) getEffectListNew;
+ (NSArray *) getWallPaperList;
+ (NSArray *) getWallPaperSubListWithId:(NSInteger) wallPaperListId page:(NSInteger)page;
+ (UIImage *) createPictureWithUrlString:(NSString *)urlString bodyRequest:(NSData *)bodyRequest;
@end

