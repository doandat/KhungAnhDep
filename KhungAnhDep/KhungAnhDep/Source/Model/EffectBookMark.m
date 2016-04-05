//
//  EffectBookMark.m
//  ThiepMung
//
//  Created by DatDV on 3/21/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import "EffectBookMark.h"

@implementation EffectBookMark

+ (NSString *)primaryKey
{
    return @"dEffect_id";
}

+ (NSArray *)indexedProperties {
    return @[@"dEffect_id"];
}


@end
