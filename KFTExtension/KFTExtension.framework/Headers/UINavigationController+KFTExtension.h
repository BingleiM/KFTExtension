//
//  UINavigationController+KFTExtension.h
//  KFTPaySDK
//
//  Created by 马冰垒 on 2017/12/28.
//  Copyright © 2017年 马冰垒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (KFTExtension)

- (void)setupBackgroundImage:(NSString *)image;
- (void)setupBackgroundImageDefault;
- (void)setupNavigationBarClear;

/// 保留栈中第一个和最后一个 viewController
- (void)reserveTheFirstViewControllerAndTheLastViewController;

/// 保留到指定的vc
/// @param classNames 指定的vc数组，先碰到谁就pop到谁那里
/// @param fromViewController 从那个VC开始pop
/// @param animated 是否有动画
- (void)popToViewControllerWithClassNames:(NSArray<NSString *> *)classNames
                       fromViewController:(UIViewController *)fromViewController
                                 animated:(BOOL)animated;

/// 从堆栈中移除formViewController
- (void)pushViewController:(UIViewController *)toViewController
andRemoveFromViewController:(UIViewController *)fromViewController
                  animated:(BOOL)animated;
@end
