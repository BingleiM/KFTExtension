//
//  UIButton+KFTExtension.h
//  Scale
//
//  Created by 马冰垒 on 2018/1/24.
//  Copyright © 2018年 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KFTExtension)

/**
 按钮倒计时
 
 @param timeout 倒计时总时间
 @param title 倒计时完成后的标题
 @param waitTitle 倒计时正在进行中的标题
 */
- (void)startTime:(NSInteger)timeout
            title:(NSString *)title
        waitTitle:(NSString *)waitTitle;

/**
 按钮倒计时

 @param timeout 倒计时总时间
 @param title 倒计时完成后的标题
 @param waitTitle 倒计时正在进行中的标题
 @param timeEndHandle 倒计时结束后回调
 */
- (void)startTime:(NSInteger)timeout
            title:(NSString *)title
        waitTitle:(NSString *)waitTitle
    timeEndHandle:(void(^)(void))timeEndHandle;

/**
 按钮倒计时

 @param timeout 倒计时总时间
 @param title 倒计时完成后的标题
 @param waitTitle 倒计时正在进行中的标题
 @param timeEndHandle 倒计时结束后回调
 */
- (void)startTime:(NSInteger)timeout
            title:(NSString *)title
        time:(NSString *)waitTitle
    timeEndHandle:(void(^)(void))timeEndHandle;

/**
 按钮倒计时

 @param timeout 倒计时总时间
 @param title 倒计时完成后的标题
 @param timeRunningHandle 计时器运行中回调，可以在这个回调中添加自定义的任务事件，回调默认在主线程中
 @param timeEndHandle 倒计时结束后回调
 */
- (void)startTime:(NSInteger)timeout
            title:(NSString *)title
        timeRunningHandle:(void (^)(NSInteger timeRemain))timeRunningHandle
    timeEndHandle:(void (^)(void))timeEndHandle;

/**
 重置 button 可用状态

 @param enabledStatus 是否可用
 */
- (void)resetButtonEnabledStatus:(BOOL)enabledStatus;

@end
