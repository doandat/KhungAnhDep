//
//  Lib.h
//  ARGame
//
//  Created by tranduc on 3/14/14.
//  Copyright (c) 2014 tranduc. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *OMLang(NSString *key);
//replace "{KEY}" by "VALUE"
NSString *OMLangDict(NSString *key, NSDictionary *dict);

@interface Lib : NSObject
+(void)setValue:(id)value forKey:(NSString*)key;
+(id)valueForkey:(NSString*)key;
+(id)valueForkey:(NSString*)key defaultValue:(id)value;
@end
