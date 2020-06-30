//
//  UIColor+KFTExtension.h
//  KFTPaySDK
//
//  Created by 马冰垒 on 2017/11/13.
//  Copyright © 2017年 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KFTExtension)

+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

/**
 *  16进制转uicolor
 *
 *  @param color @"#FFFFFF" ,@"OXFFFFFF" ,@"FFFFFF"
 *
 *  @return uicolor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 16进制转uicolor
 
 @param color @"#FFFFFF" ,@"OXFFFFFF" ,@"FFFFFF"
 @param alpha 0~1
 @return uicolor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
