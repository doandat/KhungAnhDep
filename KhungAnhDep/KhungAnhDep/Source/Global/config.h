//
//  config.h
//  ThiepMung
//
//  Created by Doan Dat on 3/11/16.
//  Copyright © 2016 Amobi. All rights reserved.
//

#ifndef config_h
#define config_h

#define URL_GET_CATEGORY @"http://apipic.yome.vn/api/picture-v2/get-category-list"
#define URL_GET_EFFECT_LIST @"http://apipic.yome.vn/api/picture-v2/get-effect-list"
#define URL_GET_NEWS_LIST @"http://apipic.yome.vn/api/picture-v2/get-new-list"
#define URL_GET_HOT_LIST @"http://pic.yome.vn/api/picture-v2/get-hot-list"

#define URL_CREATE_PICTURE @"http://apipic.yome.vn/api/picture-v2/create-picture?"
#define URL_GET_CATEGORY_THEME @"http://apipic.yome.vn/api/theme/get-category-list"
#define URL_GET_MORE_APP @"http://apipic.yome.vn/api/get-game-list/v1"
#define URL_GET_THEME @"http://apipic.yome.vn/api/theme/get-theme-list"

// parameters
#define p_category_id @"category_id"


#define PAR_FUNCTION @"function"
#define LINE_1 @"line_1"
#define LINE_2 @"line_2"
#define LINE_3 @"line_3"
#define LINE_4 @"line_4"
#define LINE_5 @"line_5"
#define LINE_6 @"line_6"
#define LINE_7 @"line_7"
#define LINE_8 @"line_8"
#define LINE_9 @"line_9"
#define LINE_10 @"line_10"
#define PICTURE_1 @"picture_1"
#define PICTURE_2 @"picture_2"
#define PICTURE_3 @"picture_3"
#define PICTURE_4 @"picture_4"
#define PICTURE_5 @"picture_5"
#define PICTURE_6 @"picture_6"
#define PICTURE_7 @"picture_7"
#define PICTURE_8 @"picture_8"
#define PICTURE_9 @"picture_9"
#define PICTURE_10 @"picture_10"




#define PAR_PAGE @"page"
#define PAR_NUMBER @"number"
#define PAR_ID @"id"

// keys
#define k_category_list @"category_list"
#define k_id @"id"
#define k_name @"name"
#define k_effect_list @"effect_list"
#define k_label @"label"
#define k_description @"description"
#define k_function @"function"
#define k_avatar @"avatar"
#define k_input_line @"input_line"
#define k_type @"type"
#define k_title @"title"
#define k_require @"require"
#define k_input_picture @"input_picture"
#define k_width @"width"
#define k_height @"height"
#define k_icon @"icon"
#define k_link @"link"
#define k_thumb @"thumb"
#define k_theme_list @"theme_list"


//backgroudcolor
#define NAVIGATIONBAR_COLOR  [UIColor colorWithRed:2/255.0 green:136/255.0 blue:209/255.0 alpha:1.0f]
#define VIEW_COLOR  [UIColor colorWithRed:3/255.0 green:169/255.0 blue:245/255.0 alpha:1.0f]
#define SELECTED_COLOR  [UIColor colorWithRed:40/255.0 green:169/255.0 blue:245/255.0 alpha:1.0f]

#define SEPARATOR_COLOR  [UIColor colorWithRed:27/255.0f green:156/255.0f blue:222/255.0f alpha:1.0f]

//image
#define IMAGE_BACK                  [UIImage imageNamed:@"btn_back.png"]
#define IMAGE_CLOSE                 [UIImage imageNamed:@"close.png"]
#define IMAGE_FAVORITE              [UIImage imageNamed:@"favorite.png"]
#define IMAGE_FAVORITED             [UIImage imageNamed:@"favorited.png"]
#define IMAGE_CAMERA                [UIImage imageNamed:@"camera.png"]
#define IMAGE_ICON_DEFAUL           [UIImage imageNamed:@"icon_defaul.png"]
#define IMAGE_ADD_PICTURE           [UIImage imageNamed:@"addpicture.png"]
#define IMAGE_LIBRARY               [UIImage imageNamed:@"library.png"]
#define IMAGE_RELOAD                [UIImage imageNamed:@"reload.png"]
//#define IMAGE_BUTTON_TAKE_NOW_RESET [UIImage imageNamed:@"btn_reset_1"]
//#define IMAGE_ICON_CALENDAR_WHITE   [UIImage imageNamed:@"icon_calendar_white"]
//#define IMAGE_ICON_PILL_WHITE       [UIImage imageNamed:@"icon_pill_white"]
//#define IMAGE_ICON_NOTIFICATION     [UIImage imageNamed:@"icon_notification"]

//FONT
#define FONT_ROBOTO_MEDIUM(z)  [UIFont fontWithName:@"Roboto-Medium" size:(z)]
#define FONT_ROBOTO_REGULAR(z)  [UIFont fontWithName:@"Roboto-Regular" size:(z)]


#endif /* config_h */
