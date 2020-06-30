//
//  UIViewController+KFTExtension.m
//  WTRecordDemo
//
//  Created by 马冰垒 on 2017/12/28.
//  Copyright © 2017年 马冰垒. All rights reserved.
//

#import "UIViewController+KFTExtension.h"

@implementation UIViewController (KFTExtension)

- (void)addBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action isLeft:(BOOL)isLeft {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = barButtonItem;
    } else {
        self.navigationItem.rightBarButtonItem = barButtonItem;
    }
}

- (void)addBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action isLeft:(BOOL)isLeft {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = barButtonItem;
    } else {
        self.navigationItem.rightBarButtonItem = barButtonItem;
    }
}

- (void)deallocCurrentViewControllerAnimated:(BOOL)flag {
    if (self.presentingViewController) {
        if ([self.navigationController.viewControllers containsObject:self]) {
            [self removeSelfFromNavigationControllers:flag];
        } else {
            [self dismissViewControllerAnimated:flag completion:nil];
        }
    } else if (self.navigationController) {
        [self removeSelfFromNavigationControllers:flag];
    }
}

- (void)removeSelfFromNavigationControllers:(BOOL)flag {
    if (self.navigationController.viewControllers.count == 1) {
        if (self.navigationController.presentingViewController) {
            [self dismissViewControllerAnimated:flag completion:nil];
        } else {
            [self.navigationController setViewControllers:@[] animated:flag];
        }
    } else if (self.navigationController.viewControllers.count > 1) {
        NSMutableArray *viewControllers = self.navigationController.viewControllers.mutableCopy;
        [viewControllers removeObject:self];
        [self.navigationController setViewControllers:viewControllers animated:flag];
    }
}

+ (UIViewController *)fetchRootViewController:(UIViewController *)viewController {
    UIViewController *rootVC = viewController;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        rootVC = ((UINavigationController *)viewController).topViewController;
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedVC = ((UITabBarController *)viewController).selectedViewController;
        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
            rootVC = ((UINavigationController *)selectedVC).topViewController;
        } else {
            rootVC = selectedVC;
        }
    }
    return rootVC;
}

@end
