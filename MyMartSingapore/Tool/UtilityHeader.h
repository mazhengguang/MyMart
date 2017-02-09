//
//  UtilityHeader.h
//  lifangti
//
//  Created by xthink4 on 16/6/20.
//  Copyright © 2016年 xthink. All rights reserved.
//
#pragma mark ——————     工具类头文件     ——————
#pragma mark ——————     宏定义的小空间     ——————

#define _S_Width [[UIScreen mainScreen] bounds].size.width
#define _S_Height [[UIScreen mainScreen] bounds].size.height
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
#define RGB2(r, g, b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define ViewCenterPoint  CGPointMake(_S_Width/2, _S_Height/2)
#define STR(a) [NSString stringWithFormat:@"%@",a]
#define STRD(a) [NSString stringWithFormat:@"%.2f",a]


//正式服
#define QNURL(a,w,h)[NSString stringWithFormat:@"%@%@?imageView2/1/w/%@/h/%@",[Utility sharedUtility].config.qiniu.bucketBaseUrl?[Utility sharedUtility].config.qiniu.bucketBaseUrl:@"http://of6aq7ksp.bkt.clouddn.com/",a,w,h]

//测试服
//#define QNURL(a,w,h)[NSString stringWithFormat:@"%@%@?imageView2/1/w/%@/h/%@",[Utility sharedUtility].config.qiniu.bucketBaseUrl?[Utility sharedUtility].config.qiniu.bucketBaseUrl:@"http://o9ktcl7j4.bkt.clouddn.com/",a,w,h]

#define PS_W 750.0f
#define PS_H 1334.0f
#define AUTO_H(a) (a/PS_H)*_S_Height
#define AUTO_W(a) (a/PS_W)*_S_Width
#define w_Self __weak typeof(self) weakSelf = self
#ifdef DEBUG
#   define DTLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
#   define DTLog(...)
#endif


#define SHOW_ALERT(_msg_)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[UtilityLanguage NSloca:@"提示"] message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:[UtilityLanguage NSloca:@"确定"], nil];\
[alert show];


#define SHOW_MSG_ALERY(_msg_)   SCLAlertView *alert = [[SCLAlertView alloc] init];\
alert.backgroundType = Blur;\
alert.showAnimationType = FadeIn;\
[alert showNotice:self title:[UtilityLanguage NSloca:@"亲"] subTitle:_msg_ closeButtonTitle:[UtilityLanguage NSloca:@"确定"] duration:0.0f];\

#define ESTagBg [UIColor colorWithHexString:@"65dadb"]
#define ESTagFont [UIFont systemFontOfSize:14]
#define ESFUNC NSLog(@"%s",__func__);

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])

//AppDelegate
#define APPDELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate
///block

typedef void (^IndexPathBlock)  (NSIndexPath *Index);
typedef void (^ArrayBlock)      (NSArray *parse);
typedef void (^StringBlock)     (NSString *parse);
typedef void (^errorBlock)      (NSError *parse);
typedef void (^VoidBlock)       ();
typedef void (^DictionaryBlock) (NSDictionary *parse);
typedef void (^DataBlock)       (NSData *parse);
typedef void (^IdObjcBlock)     (id parse);
typedef void (^ImageBlock)      (UIImage *parse);
//typedef void (^BoolBlock)       (BOOL parse);
typedef void (^FloatBlock)      (double parse);
typedef void (^IntBlock)        (NSInteger parse);




@interface UtilityHeader : NSObject

@end
