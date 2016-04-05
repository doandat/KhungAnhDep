//
//  Global.m
//  ARGame
//
//  Created by tranduc on 3/14/14.
//  Copyright (c) 2014 tranduc. All rights reserved.
//

#import "Global.h"
#import "Lib.h"
#import "AppDelegate.h"

static Global *_instance;
@implementation Global
+(Global*)share
{
    if (_instance) {
        return _instance;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[Global alloc] init];
    });
    return _instance;
}
-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}

@end
