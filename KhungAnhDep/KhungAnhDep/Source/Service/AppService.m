//
//  AppService.m
//  ThiepMung
//
//  Created by Doan Dat on 3/11/16.
//  Copyright © 2016 Amobi. All rights reserved.
//

#import "AppService.h"

@implementation AppService

+(NSDictionary*)getDicFromUrlString:(NSString *)urlString
{
    NSError *err = nil;
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url options:NSDataReadingMappedAlways error:&err];
    if (err) {
        return nil;
    }
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
    if (err) {
        return nil;
    }
    return dic;
}

+ (NSArray *) getDCategoryFromUrlString:(NSString *)urlString{
    NSMutableArray *arrDCategory = [[NSMutableArray alloc]init];
    NSDictionary *dicDCategory = [self getDicFromUrlString:urlString];
    if (dicDCategory) {
        NSDictionary *dicDCategoryList = [dicDCategory objectForKey:k_category_list];
        if (dicDCategoryList) {
            for (NSDictionary *dicDCateogty1 in dicDCategoryList) {
                DCategory *dCategory = [DCategory new];
                dCategory.dCategory_id = [dicDCateogty1 objectForKey:k_id];
                dCategory.dCategory_name = [dicDCateogty1 objectForKey:k_name];
                [arrDCategory addObject:dCategory];
            }
        }
    }
    
    return arrDCategory;
}

+ (NSArray *) getEffectListWithCategoryId:(NSString *)dCategoryId{
    NSMutableArray *arrDEffect = [[NSMutableArray alloc]init];
    NSString *stringURL =[NSString stringWithFormat:@"%@?%@=%@",URL_GET_EFFECT_LIST,p_category_id,dCategoryId];
    NSLog(@"stringURL:%@",stringURL);
    NSDictionary *dicDEffect = [self getDicFromUrlString:[NSString stringWithFormat:@"%@?%@=%@",URL_GET_EFFECT_LIST,p_category_id,dCategoryId]];
    if (dicDEffect) {
        NSDictionary *dicDEffectList = [dicDEffect objectForKey:k_effect_list];
        if (dicDEffectList) {
            for (NSDictionary *dicDEffect1 in dicDEffectList) {
                DEffect *dEffect = [DEffect new];
                NSDictionary *dicInputLine = [dicDEffect1 objectForKey:k_input_line];
                NSDictionary *dicInputPic = [dicDEffect1 objectForKey:k_input_picture];
//                NSLog(@"dicInputPic:%@",dicInputPic);
                dEffect.dEffect_id = [dicDEffect1 objectForKey:k_id];
                dEffect.label = [dicDEffect1 objectForKey:k_label];
                dEffect.effectDescription = [dicDEffect1 objectForKey:k_description];
                dEffect.function = [dicDEffect1 objectForKey:k_function];
                dEffect.avatar = [dicDEffect1 objectForKey:k_avatar];
                if (dicInputLine) {
                    NSMutableArray *arrInputLine = [[NSMutableArray alloc]init];
                    for (NSDictionary *dicInputLine1 in dicInputLine) {
                        DInputLine *dInputLine = [DInputLine new];
                        dInputLine.type = [dicInputLine1 objectForKey:k_type];
                        if ([dInputLine.type isEqualToString:@""]) {
                            continue;
                        }
                        dInputLine.title = [dicInputLine1 objectForKey:k_title];
                        dInputLine.require = [dicInputLine1 objectForKey:k_require];
                        [arrInputLine addObject:dInputLine];
                    }
                    dEffect.input_line = arrInputLine;
                }
                
                if (dicInputPic) {
                    NSMutableArray *arrInputPic = [[NSMutableArray alloc]init];
                    for (NSDictionary *dicInputPic1 in dicInputPic) {
                        DInputPic *dInputPic = [DInputPic new];
                        dInputPic.type = [dicInputPic1 objectForKey:k_type];
                        NSLog(@"");
                        if ([dInputPic.type isEqualToString:@""]) {
                            continue;
                        }

                        dInputPic.require = [dicInputPic1 objectForKey:k_require];
                        dInputPic.width = [dicInputPic1 objectForKey:k_width];
                        dInputPic.height = [dicInputPic1 objectForKey:k_height];
                        [arrInputPic addObject:dInputPic];
                    }
                    dEffect.input_pic = arrInputPic;
                }
                
                [arrDEffect addObject:dEffect];
                
            }
        }
    }
    return arrDEffect;
}

+ (NSArray *) getEffectListNew{
    NSMutableArray *arrDEffect = [[NSMutableArray alloc]init];
    NSDictionary *dicDEffect = [self getDicFromUrlString:URL_GET_NEWS_LIST];
    if (dicDEffect) {
        NSDictionary *dicDEffectList = [dicDEffect objectForKey:k_effect_list];
        if (dicDEffectList) {
            for (NSDictionary *dicDEffect1 in dicDEffectList) {
                DEffect *dEffect = [DEffect new];
                NSDictionary *dicInputLine = [dicDEffect1 objectForKey:k_input_line];
                NSDictionary *dicInputPic = [dicDEffect1 objectForKey:k_input_picture];
//                NSLog(@"dicInputPic:%@",dicInputPic);
                dEffect.dEffect_id = [dicDEffect1 objectForKey:k_id];
                dEffect.label = [dicDEffect1 objectForKey:k_label];
                dEffect.effectDescription = [dicDEffect1 objectForKey:k_description];
                dEffect.function = [dicDEffect1 objectForKey:k_function];
                dEffect.avatar = [dicDEffect1 objectForKey:k_avatar];
                if (dicInputLine) {
                    NSMutableArray *arrInputLine = [[NSMutableArray alloc]init];
                    for (NSDictionary *dicInputLine1 in dicInputLine) {
                        DInputLine *dInputLine = [DInputLine new];
                        dInputLine.type = [dicInputLine1 objectForKey:k_type];
                        if ([dInputLine.type isEqualToString:@""]) {
                            continue;
                        }
                        dInputLine.title = [dicInputLine1 objectForKey:k_title];
                        dInputLine.require = [dicInputLine1 objectForKey:k_require];
                        [arrInputLine addObject:dInputLine];
                    }
                    dEffect.input_line = arrInputLine;
                }
                
                if (dicInputPic) {
                    NSMutableArray *arrInputPic = [[NSMutableArray alloc]init];
                    for (NSDictionary *dicInputPic1 in dicInputPic) {
                        DInputPic *dInputPic = [DInputPic new];
                        dInputPic.type = [dicInputPic1 objectForKey:k_type];
                        NSLog(@"");
                        if ([dInputPic.type isEqualToString:@""]) {
                            continue;
                        }
                        
                        dInputPic.require = [dicInputPic1 objectForKey:k_require];
                        dInputPic.width = [dicInputPic1 objectForKey:k_width];
                        dInputPic.height = [dicInputPic1 objectForKey:k_height];
                        [arrInputPic addObject:dInputPic];
                    }
                    dEffect.input_pic = arrInputPic;
                }
                
                [arrDEffect addObject:dEffect];
                
            }
        }
    }
    return arrDEffect;
}

+ (NSArray *) getWallPaperList{
    NSMutableArray *arrWallPaper = [[NSMutableArray alloc]init];
    NSDictionary *dicWallPaper = [self getDicFromUrlString:[NSString stringWithFormat:URL_GET_CATEGORY_THEME]];
    if (dicWallPaper) {
        NSDictionary *dicWallPaperList = [dicWallPaper objectForKey:k_category_list];
        if (dicWallPaperList) {
            for (NSDictionary *dicWallPaper1 in dicWallPaperList) {
                DCategoryTheme *categoryTheme = [[DCategoryTheme alloc] init];
                categoryTheme.categoryThemeId = [[dicWallPaper1 objectForKey:k_id] integerValue];
                categoryTheme.name = [dicWallPaper1 objectForKey:k_name];
                categoryTheme.icon =[NSString stringWithFormat:@"http://apipic.yome.vn%@",[dicWallPaper1 objectForKey:k_icon]] ;
                [arrWallPaper addObject:categoryTheme];
                
            }
        }
    }
    return arrWallPaper;
}

+ (NSArray *) getWallPaperSubListWithId:(NSInteger) wallPaperListId page:(NSInteger)page{
    NSMutableArray *arrWallPaper = [[NSMutableArray alloc]init];
    NSDictionary *dicWallPaper = [self getDicFromUrlString:[NSString stringWithFormat:@"%@?page=%tu&category_id=%tu",URL_GET_THEME,page,wallPaperListId]];
    if (dicWallPaper) {
        NSDictionary *dicWallPaperList = [dicWallPaper objectForKey:k_theme_list];
        if (dicWallPaperList) {
            for (NSDictionary *dicWallPaper1 in dicWallPaperList) {
                DTheme *theme = [[DTheme alloc] init];
                theme.categoryTheme = wallPaperListId;
                theme.themeId = [[dicWallPaper1 objectForKey:k_id] integerValue];
                theme.link =[NSString stringWithFormat:@"http://apipic.yome.vn%@", [dicWallPaper1 objectForKey:k_link]];
                theme.thumb =[NSString stringWithFormat:@"http://apipic.yome.vn%@", [dicWallPaper1 objectForKey:k_thumb]];
                [arrWallPaper addObject:theme];
                
            }
        }
    }
    return arrWallPaper;

}

+ (UIImage *) createPictureWithUrlString:(NSString *)urlString bodyRequest:(NSData *)bodyRequest{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    [request setHTTPBody:bodyRequest];
    
    [request setHTTPMethod:@"POST"];
    
    NSURLResponse *response;
    NSError *err;
    UIImage *imageResult;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (!err) {
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error: &err];
        ////NSLog(@"Ket qua tra ve: %@",JSON);
        NSString *urlImageJson = [JSON objectForKey:@"image"];
        
        NSMutableString *urlImage = [[NSMutableString alloc] init];
        [urlImage appendString:@"http://apipic.yome.vn"];
        [urlImage appendString:[NSString stringWithFormat:@"%@",urlImageJson]];
        //
        NSURL *urlImgaeResult = [NSURL URLWithString:urlImage];
        NSURLResponse* urlResponseImage;
        NSError* error;
        NSMutableURLRequest* urlRequestImage = [NSMutableURLRequest requestWithURL:urlImgaeResult cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
        NSData* dataImageResult = [NSURLConnection sendSynchronousRequest:urlRequestImage returningResponse:&urlResponseImage error:&error];
        imageResult = [[UIImage alloc] initWithData:dataImageResult];
    }
    return imageResult;
}

// giảm dung lượng ảnh
- (UIImage *)compressImage:(UIImage *)imageToCompress
{
    int maxSize = 300000; // byte
    NSData *data;
    float k = 1;
    //    do {
    data = UIImageJPEGRepresentation(imageToCompress, k);
    long long imageSize3   = data.length;
    ////////////NSLog(@"size of image in KB: %f ", imageSize3/1024.0);
    
    k *= 0.5;
    //    } while ([data length] > maxSize);
    return [UIImage imageWithData:data];
}
@end
