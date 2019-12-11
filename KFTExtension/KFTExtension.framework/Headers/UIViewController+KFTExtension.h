//
//  UIViewController+KFTExtension.h
//  WTRecordDemo
//
//  Created by 马冰垒 on 2017/12/28.
//  Copyright © 2017年 马冰垒. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KFTExtension)

/**
 添加导航栏文字按钮

 @param title 按钮标题
 @param target target
 @param action action
 @param isLeft 左/右按钮
 */
- (void)addBarButtonItemWithTitle:(NSString *)title
                  target:(id)target
                  action:(SEL)action
                  isLeft:(BOOL)isLeft;

/**
 添加导航栏图片按钮

 @param image image
 @param target target description
 @param action action description
 @param isLeft isLeft description
 */
- (void)addBarButtonItemWithImage:(UIImage *)image
                           target:(id)target
                           action:(SEL)action
                           isLeft:(BOOL)isLeft;

- (void)deallocCurrentViewController;

@end

NS_ASSUME_NONNULL_END

