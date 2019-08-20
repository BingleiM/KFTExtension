//
//  UIView+KFTExtension.h
//  视图切换动画
//
//  Created by 马冰垒 on 16/2/23.
//  Copyright (c) 2016年 马冰垒. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MBLTransitionType) {
    MBLTransitionFade, //交叉淡化过渡
    MBLTransitionMoveIn, //新视图移到旧视图上面
    MBLTransitionPush, //新视图把旧视图推出去
    MBLTransitionReveal, //将旧视图移开,显示下面的新视图
    MBLTransitionPageCurl, //向上翻一页
    MBLTransitionPageUnCurl, //向下翻一页
    MBLTransitionRippleEffect, //滴水效果
    MBLTransitionSuckEffect, //收缩效果,如一块布被抽走
    MBLTransitionCube, //立方体效果
    MBLTransitionOglFlip, // 上下翻转效果
    MBLTransitionCameraIrisHollowOpen, //照相机打开效果
    MBLTransitionCameraIrisHollowClose, //照相机关闭效果
};

typedef NS_ENUM(NSUInteger, MBLTransitionDirection) {
    MBLTransitionFromRight,
    MBLTransitionFromLeft,
    MBLTransitionFromTop,
    MBLransitionFromBottom,
};

@interface UIView(KFTExtension)


@property (nonatomic, assign) CGPoint kft_origin;
@property (nonatomic, assign) CGSize kft_size;

@property (nonatomic) CGFloat kft_centerX;
@property (nonatomic) CGFloat kft_centerY;

@property (nonatomic) CGFloat kft_top;
@property (nonatomic) CGFloat kft_bottom;
@property (nonatomic) CGFloat kft_right;
@property (nonatomic) CGFloat kft_left;

@property (nonatomic) CGFloat kft_width;
@property (nonatomic) CGFloat kft_height;

/**
 添加模态动画

 @param duration 动画时间
 @param transitionType 动画类型
 @param direction 动画起始方向
 */
- (void)addTransitionAnimationWithDuration:(double)duration
                                      type:(MBLTransitionType)transitionType
                             directionType:(MBLTransitionDirection)direction;

/**
 添加圆角

 @param corners 圆角位置
 @param radii 圆角弧度
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;

/**
 添加圆角和边框

 @param corners 圆角位置
 @param radii 圆角弧度
 @param boardWidth 边框线宽
 @param boardColor 边框颜色
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
               boardWidth:(CGFloat)boardWidth
               boardColor:(UIColor *)boardColor;

/**
 切圆

 @param size 圆直径
 */
- (void)addCircleWithSize:(CGSize)size;

/**
 切圆带边框

 @param size 圆直径
 @param boardWidth 边框线宽
 @param boardColor 边框颜色
 */
- (void)addCircleWithSize:(CGSize)size
               boardWidth:(CGFloat)boardWidth
               boardColor:(UIColor *)boardColor;

/**
 添加渐变效果

 @param colorArray 颜色数组(CGColorRef)
 @param startPoint 起始位置 (0, 0) ~ (1, 1)
 @param endPoint 结束位置 (0, 0) ~ (1, 1)
 @param frame 渐变图层位置以及大小
 */
- (CAGradientLayer *)addGradientLayerWithColorArray:(NSArray *)colorArray
                            startPoint:(CGPoint)startPoint
                              endPoint:(CGPoint)endPoint
                                  frame:(CGRect)frame;

/** 截取某个视图的快照 */
+ (UIImage *)snapshot:(UIView *)view;

@end
