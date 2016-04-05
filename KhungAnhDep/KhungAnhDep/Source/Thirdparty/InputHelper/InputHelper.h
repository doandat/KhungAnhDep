//
//  InputHelper.h
//  ThiepMung
//
//  Created by DatDV on 3/15/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InputHelperDismissType) {
    
    InputHelperDismissTypeNone = 0,
    InputHelperDismissTypeCleanMaskView,
    InputHelperDismissTypeTapGusture
};

@interface InputHelper : NSObject

+ (InputHelper *)sharedInputHelper;
- (void)dismissInputHelper;
- (void)setupInputHelperForView:(UIView *)view withDismissType:(InputHelperDismissType)dismissType;


@end


#define inputHelper [InputHelper sharedInputHelper]
