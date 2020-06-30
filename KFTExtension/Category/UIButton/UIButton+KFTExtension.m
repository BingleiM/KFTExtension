//
//  UIButton+KFTExtension.m
//  Scale
//
//  Created by 马冰垒 on 2018/1/24.
//  Copyright © 2018年 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import "UIButton+KFTExtension.h"

@implementation UIButton (KFTExtension)

- (void)startTime:(NSInteger )timeout
            title:(NSString *)title
        waitTitle:(NSString *)waitTitle
{
    __block NSInteger timeOut = timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示 根据自己需求设置
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeOut % 60;
            if (seconds > 0) {
                NSString *timeString = [NSString stringWithFormat:@"%d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 设置界面的按钮显示, 根据自己需求设置
                    [self setTitle:[NSString stringWithFormat:@"%@(%@)", waitTitle, timeString] forState:UIControlStateNormal];
                    self.userInteractionEnabled = NO;
                    
                });
            }
            timeOut --;
        }
    });
    dispatch_resume(_timer);
}

- (void)startTime:(NSInteger)timeout
            title:(NSString *)title
        waitTitle:(NSString *)waitTitle
    timeEndHandle:(void (^)(void))timeEndHandle
{
    __block NSInteger timeOut = timeout; // 倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); // 每秒执行一次
    dispatch_source_set_event_handler(_timer, ^{
        if (timeOut <= 0) { // 倒计时结束,关闭定时器
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示 根据自己需求设置
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                if (timeEndHandle) { // 添加倒计时结束回到函数
                    timeEndHandle();
                }
            });
        } else {
            int seconds = timeOut % 60;
            if (seconds > 0) {
                NSString *timeString = [NSString stringWithFormat:@"%d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 设置界面的按钮显示, 根据自己需求设置
                    [self setTitle:[NSString stringWithFormat:@"%@(%@)", waitTitle, timeString] forState:UIControlStateNormal];
                    self.userInteractionEnabled = NO;
                });
            }
            timeOut --;
        }
    });
    dispatch_resume(_timer); // 启动定时器
}

- (void)resetButtonEnabledStatus:(BOOL)enabledStatus {
    self.alpha = enabledStatus ? 1 : 0.5;
    self.userInteractionEnabled = enabledStatus;
}

@end
