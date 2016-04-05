//
//  InputPicBookMark.h
//  ThiepMung
//
//  Created by DatDV on 3/21/16.
//  Copyright (c) 2016 Amobi. All rights reserved.
//

#import <Realm/Realm.h>

@interface InputPicBookMark : RLMObject

@property (nonatomic) NSString *idInputPic;
@property (nonatomic) NSString *dEffect_id;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *require;
@property (nonatomic) NSString *width;
@property (nonatomic) NSString *height;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<InputPicBookMark>
RLM_ARRAY_TYPE(InputPicBookMark)
