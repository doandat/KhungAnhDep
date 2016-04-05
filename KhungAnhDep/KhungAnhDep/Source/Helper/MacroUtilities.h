//
//  MacroUtilities.h
//  MKNetworkKitExtend
//
//  Created by Huy on 8/1/14.
//  Copyright (c) 2014 Ominext. All rights reserved.
//

/************************ Enable hoac disable cac nhom macro ************************/

//Comment dong duoi de disable chuc nang show log
//#define MU_DEBUG

/************************ Khai bao cac macro ************************/

/*
 * Macro duong dan thu muc dac biet
 */

#ifndef MU_DOCUMENT_DIRECTORY_PATH
#   define MU_DOCUMENT_DIRECTORY_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#endif

#ifndef MU_LIBRARY_DIRECTORY_PATH
#   define MU_LIBRARY_DIRECTORY_PATH [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#endif

#ifndef MU_RESOURCE_DIRECTORY_PATH
#   define MU_RESOURCE_DIRECTORY_PATH [[NSBundle mainBundle] resourcePath]
#endif

#ifndef MU_TMP_DIRECTORY_PATH
#   define MU_TMP_DIRECTORY_PATH NSTemporaryDirectory()
#endif

/*
 * Generate Unique ID
 */
#ifndef MU_CREATE_UUID
#   define MU_CREATE_UUID(string) {\
CFUUIDRef theUUID = CFUUIDCreate(NULL);\
CFStringRef stringUUID = CFUUIDCreateString(NULL, theUUID);\
CFRelease(theUUID);\
string = (__bridge_transfer NSString *) stringUUID; \
}
#endif

/*
 * Check NSString is empty or not
 */
#ifndef MU_STRING_IS_EMPTY
#   define MU_STRING_IS_EMPTY(str)\
(!(str) || ![(str) isKindOfClass:NSString.class] || [(str) length] == 0)
#endif

#ifndef MU_STRING_IS_NOT_EMPTY
#   define MU_STRING_IS_NOT_EMPTY(str)\
((str) && [(str) isKindOfClass:NSString.class] && [(str) length] > 0)
#endif

/*
 *  Macro for determine type of NSNumber
 */
#ifndef MU_NSNUMBER_IS_BOOLEAN
#   define MU_NSNUMBER_IS_BOOLEAN(v) (strcmp([v objCType], @encode(BOOL)) == 0)
#endif

#ifndef MU_NSNUMBER_IS_INTERGER
#   define MU_NSNUMBER_IS_INTERGER(v) (strcmp([v objCType], @encode(NSInteger)) == 0)
#endif

#ifndef MU_NSNUMBER_IS_DOUBLE
#   define MU_NSNUMBER_IS_DOUBLE(v) (strcmp([v objCType], @encode(double)) == 0)
#endif

#ifndef MU_NSNUMBER_IS_FLOAT
#   define MU_NSNUMBER_IS_FLOAT(v) (strcmp([v objCType], @encode(float)) == 0)
#endif

/*
 *  Macro using for debug
 */

#ifdef MU_DEBUG
#   ifndef MU_DLog
#       define MU_DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   endif
#   ifndef MU_ELog
#       define MU_ELog(err) {if(err) MU_DLog(@"%@", err)}
#   endif
#else
#   ifndef MU_DLog
#       define MU_DLog(...)
#   endif
#   ifndef MU_ELog
#       define MU_ELog(err)
#   endif
#endif


/*
 *  System Versioning Preprocessor Macros
 */
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#ifndef MU_SYSTEM_VERSION_EQUAL_TO
#   define MU_SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#endif

#ifndef MU_SYSTEM_VERSION_GREATER_THAN
#   define MU_SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#endif

#ifndef MU_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO
#   define MU_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version_string) ([[[UIDevice currentDevice] systemVersion] compare:version_string options:NSNumericSearch] != NSOrderedAscending)
#endif

#ifndef MU_SYSTEM_VERSION_LESS_THAN
#   define MU_SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#endif

#ifndef MU_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO
#   define MU_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#endif

/*
 *  Singleton Pattern Preprocessor Macros
 */

#ifndef MU_SINGLETON_INTERFACE_PATTERN
#   define MU_SINGLETON_INTERFACE_PATTERN(class_name) \
+ (class_name *) shared;\
+ (BOOL) isInitialize;
#endif

#ifndef MU_SINGLETON_IMPLEMENTATION_PATTERN
#   define MU_SINGLETON_IMPLEMENTATION_PATTERN(class_name) \
static class_name *_instance = nil;\
static BOOL _isInitialize;\
+ (class_name *) shared\
{\
@synchronized([class_name class])\
{\
if (!_instance)\
{\
_instance = [[self alloc] init];\
_isInitialize = TRUE;\
}\
\
return _instance;\
}\
\
return nil;\
}\
+ (id) alloc\
{\
@synchronized([class_name class])\
{\
NSAssert(_instance == nil, @"Attempted to allocate a second instance of a singleton.");\
_instance = [super alloc];\
return _instance;\
}\
return nil;\
}\
+ (BOOL)isInitialize{\
return _isInitialize;\
}
#endif

/*
 *  Macros cho phep so sanh
 */

#ifndef AND
#   define AND &&
#endif

#ifndef OR
#   define OR ||
#endif

#ifndef EQUALS
#   define EQUALS ==
#endif

/*
 *  Macros Leap Year
 */
#ifndef MU_IS_LEAP_YEAR
#   define MU_IS_LEAP_YEAR(year) (((y % 4 == 0) && (y % 100 != 0)) || (y % 400 == 0))
#endif


/*
 *  Macros checking device is iPad or iPhone
 */
#ifndef MU_DEVICE_IS_IPAD
#   define MU_DEVICE_IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#endif

#ifndef MU_DEVICE_IS_IPHONE
#   define MU_DEVICE_IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#endif

/*
 *  Checking orientation of device
 */
#ifndef MU_DEVICE_ON_PORTRAIT
#   define MU_DEVICE_ON_PORTRAIT (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
#endif

#ifndef MU_DEVICE_ON_LANDSCAPE
#   define MU_DEVICE_ON_LANDSCAPE (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
#endif

/*
 *  Checking iPhone 3.5 inch, 4.0 inch, 4.7 inch, 5.5 inch
 */
#ifndef MU_DEVICE_IS_IPHONE_3_5_INCH
#   define MU_DEVICE_IS_IPHONE_3_5_INCH ([[UIScreen mainScreen] bounds].size.height == 480.0)
#endif

#ifndef MU_DEVICE_IS_IPHONE_4_0_INCH
#   define MU_DEVICE_IS_IPHONE_4_0_INCH ([[UIScreen mainScreen] bounds].size.height == 568.0)
#endif

#ifndef MU_DEVICE_IS_IPHONE_4_7_INCH
#   define MU_DEVICE_IS_IPHONE_4_7_INCH ([[UIScreen mainScreen] bounds].size.height == 667.0)
#endif

#ifndef MU_DEVICE_IS_IPHONE_5_5_INCH
#   define MU_DEVICE_IS_IPHONE_5_5_INCH ([[UIScreen mainScreen] bounds].size.height == 736.0)
#endif

/*
 *  Get screen size
 */
#ifndef MU_DEVICE_SCREEN_SIZE
#   define MU_DEVICE_SCREEN_SIZE ([UIScreen mainScreen].bounds.size)
#endif

/*
 *  Macros show alert
 */
#ifndef MU_ALERT
#define MU_ALERT(title, content) \
UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];\
[alertView setAccessibilityLabel:@"Alert"];\
[alertView show];
#endif

/*
 *  Macros get current app version
 */
#ifndef MU_CURRENT_APP_VERSION
#   define MU_CURRENT_APP_VERSION \
[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] floatValue];
#endif

/*
 *  Macros random float: 0.0f->1.0f
 */
#ifndef MU_RANDOM_FLOAT
#   define MU_RANDOM_FLOAT \
((float)arc4random() / 0x100000000)
#endif

/*
 *  Macros random int: min->max
 */
#ifndef MU_RANDOM_INT
#   define MU_RANDOM_INT(min,max) \
((arc4random() % (max-min + 1)) + min)
#endif

/*
 *  Macros random color
 */
#ifndef MU_RANDOM_COLOR
#   define MU_RANDOM_COLOR \
[UIColor colorWithRed:MU_RANDOM_FLOAT green:MU_RANDOM_FLOAT blue:MU_RANDOM_FLOAT alpha:1.0]
#endif

/*
 *  Create UIColor from RBG value
 */
#ifndef MU_UIColorFromRGB
#   define MU_UIColorFromRGB(r,g,b) \
[UIColor colorWithRed:((float)r)/255.0 green:((float)g)/255.0 blue:((float)b)/255.0 alpha:1.0]
#endif

/*
 *  Create UIColor from Hex with alpha
 */
#ifndef MU_UIColorFromHexWithAlpha
#   define MU_UIColorFromHexWithAlpha(hexValue,a) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#endif

/*
 *  Create UIColor from Hex
 */
#ifndef MU_UIColorFromHex
#   define MU_UIColorFromHex(hexValue) \
UIColorFromHexWithAlpha(hexValue,1.0)
#endif

/*
 *  Create UIColor from RBG value with alpha
 */
#ifndef MU_UIColorFromRGBA
#   define MU_UIColorFromRGBA(r,g,b,a) \
[UIColor colorWithRed:((float)r)/255.0 green:((float)g)/255.0 blue:((float)b)/255.0 alpha:a]
#endif


/*
 *  Macros for getting keyboard height, word on both virtual keyboard and external keyboard
 */
#ifndef MU_KEYBOARD_HEIGHT
#   define MU_KEYBOARD_HEIGHT(keyboard_notification,param_keyboard_height) {\
NSValue* aKeyboardValue = [[keyboard_notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];\
CGRect keyboardRect = [aKeyboardValue CGRectValue];\
if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait){\
param_keyboard_height = [UIScreen mainScreen].bounds.size.height - keyboardRect.origin.y;\
}\
else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown){\
param_keyboard_height = keyboardRect.size.height + keyboardRect.origin.y;\
}\
else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft){\
param_keyboard_height = [UIScreen mainScreen].bounds.size.width - keyboardRect.origin.x;\
}\
else{\
param_keyboard_height = keyboardRect.size.width + keyboardRect.origin.x;\
}\
}
#endif

/*
 *  Macros Built-in font name in ios
 */
#ifndef MU_FONT_HiraKakuProN_W3
#   define MU_FONT_HiraKakuProN_W3 \
@"HiraKakuProN-W3"
#endif

#ifndef MU_FONT_Courier
#   define MU_FONT_Courier \
@"Courier"
#endif

#ifndef MU_FONT_Courier_BoldOblique
#   define MU_FONT_Courier_BoldOblique \
@"Courier-BoldOblique"
#endif

#ifndef MU_FONT_Courier_Oblique
#   define MU_FONT_Courier_Oblique \
@"Courier-Oblique"
#endif

#ifndef MU_FONT_Courier_Bold
#   define MU_FONT_Courier_Bold \
@"Courier-Bold"
#endif

#ifndef MU_FONT_ArialMT
#   define MU_FONT_ArialMT \
@"ArialMT"
#endif

#ifndef MU_FONT_Arial_BoldMT
#   define MU_FONT_Arial_BoldMT \
@"Arial-BoldMT"
#endif

#ifndef MU_FONT_Arial_BoldItalicMT
#   define MU_FONT_Arial_BoldItalicMT \
@"Arial-BoldItalicMT"
#endif

#ifndef MU_FONT_Arial_ItalicMT
#   define MU_FONT_Arial_ItalicMT \
@"Arial-ItalicMT"
#endif

#ifndef MU_FONT_STHeitiTC_Light
#   define MU_FONT_STHeitiTC_Light \
@"STHeitiTC-Light"
#endif

#ifndef MU_FONT_STHeitiTC_Medium
#   define MU_FONT_STHeitiTC_Medium \
@"STHeitiTC-Medium"
#endif

#ifndef MU_FONT_AppleGothic
#   define MU_FONT_AppleGothic \
@"AppleGothic"
#endif

#ifndef MU_FONT_CourierNewPS_BoldMT
#   define MU_FONT_CourierNewPS_BoldMT \
@"CourierNewPS-BoldMT"
#endif

#ifndef MU_FONT_CourierNewPS_ItalicMT
#   define MU_FONT_CourierNewPS_ItalicMT \
@"CourierNewPS-ItalicMT"
#endif

#ifndef MU_FONT_CourierNewPS_BoldItalicMT
#   define MU_FONT_CourierNewPS_BoldItalicMT \
@"CourierNewPS-BoldItalicMT"
#endif

#ifndef MU_FONT_CourierNewPSMT
#   define MU_FONT_CourierNewPSMT \
@"CourierNewPSMT"
#endif

#ifndef MU_FONT_Zapfino
#   define MU_FONT_Zapfino \
@"Zapfino"
#endif

#ifndef MU_FONT_HiraKakuProN_W6
#   define MU_FONT_HiraKakuProN_W6 \
@"HiraKakuProN-W6"
#endif

#ifndef MU_FONT_ArialUnicodeMS
#   define MU_FONT_ArialUnicodeMS \
@"ArialUnicodeMS"
#endif

#ifndef MU_FONT_STHeitiSC_Medium
#   define MU_FONT_STHeitiSC_Medium \
@"STHeitiSC-Medium"
#endif

#ifndef MU_FONT_STHeitiSC_Light
#   define MU_FONT_STHeitiSC_Light \
@"STHeitiSC-Light"
#endif

#ifndef MU_FONT_AmericanTypewriter
#   define MU_FONT_AmericanTypewriter \
@"AmericanTypewriter"
#endif

#ifndef MU_FONT_AmericanTypewriter_Bold
#   define MU_FONT_AmericanTypewriter_Bold \
@"AmericanTypewriter-Bold"
#endif

#ifndef MU_FONT_Helvetica_Oblique
#   define MU_FONT_Helvetica_Oblique \
@"Helvetica-Oblique"
#endif

#ifndef MU_FONT_Helvetica_BoldOblique
#   define MU_FONT_Helvetica_BoldOblique \
@"Helvetica-BoldOblique"
#endif

#ifndef MU_FONT_Helvetica
#   define MU_FONT_Helvetica \
@"Helvetica"
#endif

#ifndef MU_FONT_Helvetica_Bold
#   define MU_FONT_Helvetica_Bold \
@"Helvetica-Bold"
#endif

#ifndef MU_FONT_MarkerFelt_Thin
#   define MU_FONT_MarkerFelt_Thin \
@"MarkerFelt-Thin"
#endif

#ifndef MU_FONT_HelveticaNeue
#   define MU_FONT_HelveticaNeue \
@"HelveticaNeue"
#endif

#ifndef MU_FONT_HelveticaNeue_Bold
#   define MU_FONT_HelveticaNeue_Bold \
@"HelveticaNeue-Bold"
#endif

#ifndef MU_FONT_DBLCDTempBlack
#   define MU_FONT_DBLCDTempBlack \
@"DBLCDTempBlack"
#endif

#ifndef MU_FONT_DBLCDTempBlack
#   define MU_FONT_DBLCDTempBlack \
@"DBLCDTempBlack"
#endif

#ifndef MU_FONT_Verdana_Bold
#   define MU_FONT_Verdana_Bold \
@"Verdana-Bold"
#endif

#ifndef MU_FONT_Verdana_BoldItalic
#   define MU_FONT_Verdana_BoldItalic \
@"Verdana-BoldItalic"
#endif

#ifndef MU_FONT_Verdana
#   define MU_FONT_Verdana \
@"Verdana"
#endif

#ifndef MU_FONT_Verdana_Italic
#   define MU_FONT_Verdana_Italic \
@"Verdana-Italic"
#endif

#ifndef MU_FONT_TimesNewRomanPSMT
#   define MU_FONT_TimesNewRomanPSMT \
@"TimesNewRomanPSMT"
#endif

#ifndef MU_FONT_TimesNewRomanPS_BoldMT
#   define MU_FONT_TimesNewRomanPS_BoldMT \
@"TimesNewRomanPS-BoldMT"
#endif

#ifndef MU_FONT_TimesNewRomanPS_BoldItalicMT
#   define MU_FONT_TimesNewRomanPS_BoldItalicMT \
@"TimesNewRomanPS-BoldItalicMT"
#endif

#ifndef MU_FONT_TimesNewRomanPS_ItalicMT
#   define MU_FONT_TimesNewRomanPS_ItalicMT \
@"TimesNewRomanPS-ItalicMT"
#endif

#ifndef MU_FONT_Georgia_Bold
#   define MU_FONT_Georgia_Bold \
@"Georgia-Bold"
#endif

#ifndef MU_FONT_Georgia
#   define MU_FONT_Georgia \
@"Georgia"
#endif

#ifndef MU_FONT_Georgia_BoldItalic
#   define MU_FONT_Georgia_BoldItalic \
@"Georgia-BoldItalic"
#endif

#ifndef MU_FONT_Georgia_Italic
#   define MU_FONT_Georgia_Italic \
@"Georgia-Italic"
#endif

#ifndef MU_FONT_STHeitiJ_Medium
#   define MU_FONT_STHeitiJ_Medium \
@"STHeitiJ-Medium"
#endif

#ifndef MU_FONT_STHeitiJ_Light
#   define MU_FONT_STHeitiJ_Light \
@"STHeitiJ-Light"
#endif

#ifndef MU_FONT_ArialRoundedMTBold
#   define MU_FONT_ArialRoundedMTBold \
@"ArialRoundedMTBold"
#endif

#ifndef MU_FONT_ArialRoundedMTBold
#   define MU_FONT_ArialRoundedMTBold \
@"ArialRoundedMTBold"
#endif

#ifndef MU_FONT_TrebuchetMS_Italic
#   define MU_FONT_TrebuchetMS_Italic \
@"TrebuchetMS-Italic"
#endif

#ifndef MU_FONT_TrebuchetMS
#   define MU_FONT_TrebuchetMS \
@"TrebuchetMS"
#endif

#ifndef MU_FONT_Trebuchet_BoldItalic
#   define MU_FONT_Trebuchet_BoldItalic \
@"Trebuchet-BoldItalic"
#endif

#ifndef MU_FONT_TrebuchetMS_Bold
#   define MU_FONT_TrebuchetMS_Bold \
@"TrebuchetMS-Bold"
#endif

#ifndef MU_FONT_STHeitiK_Medium
#   define MU_FONT_STHeitiK_Medium \
@"STHeitiK-Medium"
#endif

#ifndef MU_FONT_STHeitiK_Light
#   define MU_FONT_STHeitiK_Light \
@"STHeitiK-Light"
#endif

/*
 *  Macros Null Safe in Objective C
 */
#ifndef MU_NULL_SAFE_ADD_OBJECT_TO_ARRAY
#   define MU_NULL_SAFE_ADD_OBJECT_TO_ARRAY(array, object) \
if (array == NULL){\
NSLog(@"Can not add %@ into array, because the array is NULL", object);\
}else{\
if (object != NULL) {\
[array addObject:object];\
}else{\
NSLog(@"Can not add object into %@, because the object is NULL", array);\
}\
}
#endif

/*
 *  Macros Regular Expression
 */
#ifndef MU_RegExp_Match_IPAddress
#   define MU_RegExp_Match_IPAddress(string) \
(string != NULL && [[NSRegularExpression regularExpressionWithPattern:@"^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$" options:NSRegularExpressionCaseInsensitive error:NULL] numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)] == 1)
#endif

#ifndef MU_RegExp_Match_Email
#   define MU_RegExp_Match_Email(string) \
([[NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:NSRegularExpressionCaseInsensitive error:NULL] numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)] == 1)
#endif

/*
 *  Geometry
 */

#ifndef MU_Degree_2_Radian
#   define MU_Degree_2_Radian(string) \
((degrees) * M_PI / 180.0)
#endif

#ifndef MU_Radian_2_Degree
#   define MU_Radian_2_Degree(radians) \
((radians) * 180.0 / M_PI)
#endif

/*
 *  Throw Exception
 */
#define kMU_ArgumentException @"ArgumentException"
#define kMU_ArgumentNilException @"ArgumentNilException"
#define kMU_ArgumentNilOrEmptyException @"ArgumentNilOrEmptyException"
#define kMU_NilObjectException @"NilObjectException"
#define kMU_InvalidOperationException @"InvalidOperationException"
#define kMU_InvalidObjectTypeException @"InvalidObjectTypeException"
#define kMU_NotImplementedException @"NotImplementedException"
#define kMU_OutOfRangeException @"OutOfRangeException"

#ifndef MU_THROW_NOT_IMPLEMENTED_EXCEPTION
#   define MU_THROW_NOT_IMPLEMENTED_EXCEPTION \
@throw [NSException exceptionWithName:kMU_NotImplementedException reason:[NSString stringWithFormat:@"%s -> the method is not implemented.", __FUNCTION__] userInfo:nil];
#endif


/*
 * TODO
 */
#ifndef TODO
#   define TODO MU_ALERT(@"TODO", @"Not implementation");
#endif


/*
 * Fix Deprecated Function
 */

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
#define MU_LabelAlignmentCenter NSTextAlignmentCenter
#else
#define MU_LabelAlignmentCenter UITextAlignmentCenter
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MU_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define MU_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

/*
 *RGB
 */

#define MU_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


/*
 *RGBA
 */

#define MU_RGBA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


/*
 *Get Origin
 */

#define MU_GET_Y(p) p.frame.origin.x
#define MU_GET_X(p) p.frame.origin.y


/*
 *Get Width Height
 */

#define MU_GET_WIDTH(p) p.frame.size.width
#define MU_GET_HEIGHT(p) p.frame.size.height

/*
 * Get next point
 */

#define MU_GET_RELATIVE_X(p) p.frame.origin.x + p.frame.size.width
#define MU_GET_RELATIVE_Y(p) p.frame.origin.y + p.frame.size.height


/*
 *Screen bounds
 */

#define MU_SCREEN_BOUNDS ([UIScreen mainScreen].bounds.size)


/*
 *User default
 */

#define MU_USER_DEFAULT [NSUserDefaults standardUserDefaults]

/*
 *Draw border
*/
#ifndef MU_DRAW_BORDER
#   define MU_DRAW_BORDER(object) object.layer.borderWidth = 2.0f; object.layer.borderColor = [UIColor redColor].CGColor;
#endif

/*
 *ComparisonResult
*/
#ifndef MU_Comparison_Result
#define MU_Comparison_Result(obj1,obj2) [[NSNumber numberWithInt:obj1] compare:[NSNumber numberWithInt:obj2]]
#endif