//
//  Lib.m
//  ARGame
//
//  Created by tranduc on 3/14/14.
//  Copyright (c) 2014 tranduc. All rights reserved.
//

#import "Lib.h"
NSString *OMLang(NSString *key)
{
    return NSLocalizedString(key, key);
}
//replace "{KEY}" by "VALUE"
NSString *OMLangDict(NSString *key, NSDictionary *dict)
{
    NSString *str = NSLocalizedString(key, key);
    for (NSString *k in dict) {
        NSString *kPattern = [NSString stringWithFormat:@"{%@}", k];
        str = [str stringByReplacingOccurrencesOfString:kPattern
                                             withString:dict[k]];
    }
    return str;
}

@implementation Lib
+(void)setValue:(id)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(id)valueForkey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
+(id)valueForkey:(NSString*)key defaultValue:(id)value
{
    id val = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    if (val) {
        return val;
    }
    return value;
}
@end
