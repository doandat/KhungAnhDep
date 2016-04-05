//
//  DEffect.h
//  ThiepMung
//
//  Created by Doan Dat on 3/11/16.
//  Copyright © 2016 Amobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DEffect : NSObject

@property (nonatomic) NSString *dEffect_id;
@property (nonatomic) NSString *label;
@property (nonatomic) NSString *effectDescription;
@property (nonatomic) NSString *function;
@property (nonatomic) NSString *avatar;
@property (nonatomic) NSArray *input_line;
@property (nonatomic) NSArray *input_pic;

@end
