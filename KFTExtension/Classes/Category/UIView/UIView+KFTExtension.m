//
//  UIView+KFTExtension.m
//  04-视图切换动画
//
//  Created by 马冰垒 on 16/2/23.
//  Copyright (c) 2016年 马冰垒. All rights reserved.
//

#import "UIView+KFTExtension.h"

@implementation UIView(KFTExtension)

#pragma mark - Shortcuts for the coords

- (CGFloat)kft_top {
    return self.frame.origin.y;
}

- (void)setKft_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)kft_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setKft_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)kft_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setKft_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)kft_left {
    return self.frame.origin.x;
}

- (void)setKft_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)kft_width {
    return self.frame.size.width;
}

- (void)setKft_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)kft_height {
    return self.frame.size.height;
}

- (void)setKft_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)kft_origin {
    return self.frame.origin;
}

- (void)setKft_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)kft_size {
    return self.frame.size;
}

- (void)setKft_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - Shortcuts for positions

- (CGFloat)kft_centerX {
    return self.center.x;
}

- (void)setKft_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)kft_centerY {
    return self.center.y;
}

- (void)setKft_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark - Animation

- (void)addTransitionAnimationWithDuration:(double)duration
                                      type:(MBLTransitionType)transitionType
                             directionType:(MBLTransitionDirection)direction
{
    // 1.创建一个切换动画对象
    CATransition * transition = [CATransition animation];
    // 2.设置动画时间
    transition.duration = duration;
    // 3.设置动画类型
    NSArray * typeArray = @[
                            kCATransitionFade,
                            kCATransitionMoveIn,
                            kCATransitionPush,
                            kCATransitionReveal,
                            @"pageCurl",
                            @"pageUnCurl",
                            @"rippleEffect",
                            @"suckEffect",
                            @"cube",
                            @"oglFlip",
                            @"cameraIrisHollowOpen",
                            @"cameraIrisHollowClose"
                            ];
    transition.type = typeArray[transitionType];
    // 4.设置动画方向
    NSArray *directionarray = @[
                                kCATransitionFromRight,
                                kCATransitionFromLeft,
                                kCATransitionFromTop,
                                kCATransitionFromBottom
                                ];
    transition.subtype = directionarray[direction];
    // 5.添加动画(同时视图控制器的view来调用)
    [self.window.layer addAnimation:transition forKey:nil];
}

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = self.bounds;
    shape.path = rounded.CGPath;
    self.layer.mask = shape;
}

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
               boardWidth:(CGFloat)boardWidth
               boardColor:(UIColor *)boardColor
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = self.bounds;
    shape.path = rounded.CGPath;
    self.layer.mask = shape;
    if (!boardWidth || !boardColor) {
        return;
    } else {
        boardWidth = MAX(boardWidth, 0.5);
//        boardColor = boardColor ? boardColor : Theme_Color_SeparatorLine;
        CAShapeLayer *boardLayer = [CAShapeLayer layer];
        boardLayer.fillColor = [UIColor clearColor].CGColor;
        boardLayer.strokeColor = boardColor.CGColor;
        boardLayer.path = rounded.CGPath;
        boardLayer.lineWidth = boardWidth;
        [self.layer addSublayer:boardLayer];
    }
}

- (void)addCircleWithSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = circle.CGPath;
    maskLayer.frame = rect;
    self.layer.mask = maskLayer;
}

- (void)addCircleWithSize:(CGSize)size
               boardWidth:(CGFloat)boardWidth
               boardColor:(UIColor *)boardColor
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = circle.CGPath;
    maskLayer.frame = rect;
    self.layer.mask = maskLayer;
    if (!boardWidth || !boardColor) {
        return;
    } else {
        boardWidth = MAX(boardWidth, 0.5);
//        boardColor = boardColor ? boardColor : Theme_Color_SeparatorLine;
        CAShapeLayer *boardLayer = [CAShapeLayer layer];
        boardLayer.fillColor = [UIColor clearColor].CGColor;
        boardLayer.strokeColor = boardColor.CGColor;
        boardLayer.path = circle.CGPath;
        boardLayer.lineWidth = boardWidth;
        [self.layer addSublayer:boardLayer];
    }
}

- (CAGradientLayer *)addGradientLayerWithColorArray:(NSArray *)colorArray
                            startPoint:(CGPoint)startPoint
                              endPoint:(CGPoint)endPoint
                                  frame:(CGRect)frame
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.colors = colorArray;
    gradientLayer.frame = frame;
    [self.layer addSublayer:gradientLayer];
    return gradientLayer;
}

/** 截图 */
+ (UIImage *)snapshot:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
