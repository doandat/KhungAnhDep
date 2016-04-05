//
//  InputLineBookMark.h
//  ThiepMung
//
//  Created by DatDV on 3/21/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import <Realm/Realm.h>

@interface InputLineBookMark : RLMObject

@property (nonatomic) NSString *idInputLine;
@property (nonatomic) NSString *dEffect_id;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *require;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<InputLineBookMark>
RLM_ARRAY_TYPE(InputLineBookMark)
