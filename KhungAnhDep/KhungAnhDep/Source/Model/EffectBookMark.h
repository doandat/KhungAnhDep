//
//  EffectBookMark.h
//  ThiepMung
//
//  Created by DatDV on 3/21/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import <Realm/Realm.h>

@interface EffectBookMark : RLMObject
@property (nonatomic) NSString *dEffect_id;
@property (nonatomic) NSString *label;
@property (nonatomic) NSString *effectDescription;
@property (nonatomic) NSString *function;
@property (nonatomic) NSString *avatar;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<EffectBookMark>
RLM_ARRAY_TYPE(EffectBookMark)
