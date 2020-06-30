//
//  UINavigationController+KFTExtension.m
//  KFTPaySDK
//
//  Created by 马冰垒 on 2017/12/28.
//  Copyright © 2017年 马冰垒. All rights reserved.
//

#import "UINavigationController+KFTExtension.h"

@implementation UINavigationController (KFTExtension)

- (void)setupBackgroundImage:(NSString *)image {
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
//    [self.navigationBar setBackgroundImage:kImage_Name(image) forBarMetrics:UIBarMetricsDefault];
}

- (void)setupBackgroundImageDefault {
//    if (kDevice_Is_iPhoneX) {
//        [self setupBackgroundImage:@"icon_navigationBar_iPhoneX"];
//    } else {
//        [self setupBackgroundImage:@"icon_navigationBar"];
//    }
}

- (void)setupNavigationBarClear {
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)reserveTheFirstViewControllerAndTheLastViewController {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *mArray = self.viewControllers.mutableCopy;
        UIViewController *lastViewController = mArray.lastObject;
        UIViewController *firstViewController = mArray.firstObject;
        for (NSObject *vc in self.viewControllers) {
            if (vc != lastViewController && vc != firstViewController ) {
                [mArray removeObject:vc];
            }
        }
        [self setViewControllers:mArray.copy];
    });
}

- (void)popToViewControllerWithClassNames:(NSArray<NSString *> *)classNames
                       fromViewController:(UIViewController *)fromViewController
                                 animated:(BOOL)animated
{
    NSMutableArray *mArray = self.viewControllers.mutableCopy;
    BOOL isHasVC = NO;//是否存在这样的vc
    for (UIViewController *vc in mArray) {
        for (NSString *className in classNames) {
            if ([vc isKindOfClass:NSClassFromString(className)]) {
                isHasVC = YES;
            }
        }
    }
    
    if (!isHasVC) {//只有存在才能继续走下去,不存在就直接pop系统的
        [self popViewControllerAnimated:animated];
        return;
    }
    
    BOOL isFind = NO;
    for (UIViewController *vc in mArray.reverseObjectEnumerator.allObjects) {
        if (vc == fromViewController) {
            continue;
        }
        for (NSString *className in classNames) {
            if ([vc isKindOfClass:NSClassFromString(className)]) {
                isFind = YES;
                break;
            }
        }
        if (isFind) {
            break;
        }
        if (!isFind) {
            [mArray removeObject:vc];
        }
    }
    [self setViewControllers:mArray.copy];
    [self popViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)toViewController
andRemoveFromViewController:(UIViewController *)fromViewController
                  animated:(BOOL)animated
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *mArray = self.viewControllers.mutableCopy;
        [mArray removeObject:fromViewController];
        self.viewControllers = mArray.copy;
    });
    [self pushViewController:toViewController animated:animated];
}

@end
