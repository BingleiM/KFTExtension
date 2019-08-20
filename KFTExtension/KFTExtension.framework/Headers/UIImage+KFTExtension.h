//
//  UIImage+KFTExtension.h
//  KFTPaySDK
//
//  Created by 马冰垒 on 2018/7/23.
//  Copyright © 2018 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KFTExtension)

/** 从图片中按指定的位置大小截取图片的一部分 */
+ (UIImage *_Nullable)imageCrop:(UIImage *_Nullable)image inRect:(CGRect)rect;

/** 传入图片：xx.png xx.jpg */
+ (nullable UIImage *)drawImageWithImageNamed:(nullable NSString *)name;

/** 添加图片水印 */
+ (nullable UIImage *)waterImageWithImage:(nullable UIImage *)image waterImage:(nullable UIImage *)waterImage waterImageRect:(CGRect)rect;

/** 添加文字水印 */
+ (nullable UIImage *)waterImageWithImage:(nullable UIImage *)image text:(nullable NSString *)text textPoint:(CGPoint)point attributedString:(nullable NSDictionary< NSString *, id> *)attributed;

/** 裁剪圆形图片 */
+ (nullable UIImage *)clipCircleImageWithImage:(nullable UIImage *)image circleRect:(CGRect)rect;

/** 裁剪圆形图片并设置边框大小和颜色 */
+ (nullable UIImage *)clipCircleImageWithImage:(nullable UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:(nullable UIColor *)borderColor;

/** 对View进行截屏 */
+ (void)cutScreenWithView:(nullable UIView *)view successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block;

/** 对view的某一部分进行裁剪 */
+ (void)cutScreenWithView:(nullable UIView *)view cutFrame:(CGRect)frame successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block;

/** 传入一个ImageView，添加向下透明区域 */
- (nullable UIImage *)wipeImageWithView:(nullable UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size;

/**
 压缩图片方法(先压缩质量再压缩尺寸,压缩到指定尺寸以下单位如：1 * 1024 Kb)-最佳方法,只能用对象方法，否则无效.
 
 @param image 原图片
 @param maxLength 压缩到指定质量以下，单位KB
 @return 压缩后的
 */
+ (nullable NSData *)compressWithImage:(UIImage *_Nonnull)image lengthLimit:(NSUInteger)maxLength;

/**
 图片转成Base64字符串,并压缩到指定内存大小
 
 @param image 图片
 @param maxLength 压缩到指定大小，单位kb
 @return 字符串
 */
+ (nullable NSString *)imageToBase64Str:(UIImage *_Nonnull)image  maxLength:(NSInteger)maxLength;

/**
 Base64字符串转图片
 
 @param encodedImageStr Base64字符串转
 @return 图片
 */
+ (nullable UIImage *)base64StringToUIImage:(NSString *_Nonnull)encodedImageStr;

/**
 获取 bundle 下的图片, 自动适配2倍3倍图
 
 @param name 图片名字
 @param bundleName bundle 名字
 @return image
 */
+ (nullable UIImage *)imageNamed:(NSString *_Nonnull)name inBundleOfName:(NSString *_Nonnull)bundleName;

/** 根据本地GIF图片名 获得GIF image对象 */
+ (nullable UIImage *)imageWithGIFNamed:(NSString * _Nonnull)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (nullable UIImage *)imageWithGIFData:(NSData * _Nonnull)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString  * _Nonnull)url callBack:(void(^_Nullable)(UIImage * _Nullable gifImage))callBack;

@end
