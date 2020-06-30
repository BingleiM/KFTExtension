//
//  UIImage+KFTExtension.m
//  KFTPaySDK
//
//  Created by 马冰垒 on 2018/7/23.
//  Copyright © 2018 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import "UIImage+KFTExtension.h"

@implementation UIImage (KFTExtension)

+ (UIImage *)imageCrop:(nullable UIImage *)image inRect:(CGRect)rect {
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    //返回剪裁后的图片
    return newImage;
}

+ (UIImage *)drawImageWithImageNamed:(NSString *)name {
    //1.获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
    //2.开启图形上下文
    UIGraphicsBeginImageContext(image.size);
    //3.绘制到图形上下文中
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //4.从上下文中获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

+ (UIImage *)waterImageWithImage:(UIImage *)image
                      waterImage:(UIImage *)waterImage
                  waterImageRect:(CGRect)rect
{
    //1.获取图片
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //4.从上下文中获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

+ (UIImage *)waterImageWithImage:(UIImage *)image
                            text:(NSString *)text
                       textPoint:(CGPoint)point
                attributedString:(NSDictionary * )attributed
{
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


+ (nullable UIImage *)clipCircleImageWithImage:(nullable UIImage *)image circleRect:(CGRect)rect {
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2、设置裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    //3、绘制图片
    [image drawAtPoint:CGPointZero];
    //4、获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    //6、返回新图片
    return newImage;
}

+ (nullable UIImage *)clipCircleImageWithImage:(nullable UIImage *)image
                                    circleRect:(CGRect)rect
                                   borderWidth:(CGFloat)borderW
                                   borderColor:(nullable UIColor *)borderColor
{
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2、设置边框
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [borderColor setFill];
    [path fill];
    //3、设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x + borderW , rect.origin.x + borderW , rect.size.width - borderW * 2, rect.size.height - borderW *2)];
    [clipPath addClip];
    //3、绘制图片
    [image drawAtPoint:CGPointZero];
    //4、获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    //6、返回新图片
    return newImage;
}

+ (void)cutScreenWithView:(nullable UIView *)view
             successBlock:(nullable void(^)(UIImage * _Nullable image, NSData * _Nullable imagedata))block
{
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //2.获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3.截屏
    [view.layer renderInContext:ctx];
    //4、获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.转化成为Data
    //compressionQuality:表示压缩比 0 - 1的取值范围
    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    //6、关闭上下文
    UIGraphicsEndImageContext();
    //7.回调
    block(newImage, data);
}

+ (void)cutScreenWithView:(nullable UIView *)view
                 cutFrame:(CGRect)frame
             successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block
{
    //先把裁剪区域上面显示的层隐藏掉
    //    for (PQWipeView * wipe in view.subviews) {
    //        [wipe setHidden:YES];
    //    }
    // ************************   进行第一次裁剪 ********************
    //1.开启上下文
    UIGraphicsBeginImageContext(view.frame.size);
    //2、获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3、添加裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    [path addClip];
    //4、渲染
    [view.layer renderInContext:ctx];
    //5、从上下文中获取
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7、关闭上下文
    UIGraphicsEndImageContext();
    //8、进行完第一次裁剪之后，我们就已经拿到了没有半透明层的图片，这个时候可以恢复显示
    //    for (PQWipeView * wipe in view.subviews) {
    //        [wipe setHidden:NO];
    //    }
    // ************************   进行第二次裁剪 ********************
    //9、开启上下文，这个时候的大小就是我们最终要显示图片的大小
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    //10、这里把x y 坐标向左、上移动
    [newImage drawAtPoint:CGPointMake(- frame.origin.x, - frame.origin.y)];
    //11、得到要显示区域的图片
    UIImage *fImage = UIGraphicsGetImageFromCurrentImageContext();
    //12、得到data类型 便于保存
    NSData *data2 = UIImageJPEGRepresentation(fImage, 1);
    //13、关闭上下文
    UIGraphicsEndImageContext();
    //14、回调
    block(fImage, data2);
}

- (nullable UIImage *)wipeImageWithView:(nullable UIView *)view
                           currentPoint:(CGPoint)nowPoint
                                   size:(CGSize)size
{
    //计算位置
    CGFloat offsetX = nowPoint.x - size.width * 0.5;
    CGFloat offsetY = nowPoint.y - size.height * 0.5;
    CGRect clipRect = CGRectMake(offsetX, offsetY, size.width, size.height);
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把图片绘制上去
    [view.layer renderInContext:ctx];
    //把这一块设置为透明
    CGContextClearRect(ctx, clipRect);
    //获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    //重新赋值图片
    return newImage;
}

+ (nullable NSData *)compressWithImage:(UIImage *)image lengthLimit:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}

+ (nullable NSString *)imageToBase64Str:(UIImage *)image  maxLength:(NSInteger)maxLength {
    if (![image isKindOfClass:[UIImage class]]) return nil;
    NSData *data = [UIImage compressWithImage:image lengthLimit:maxLength * 1024.0f];
    NSLog(@"转Base64压缩后图片大小：%luk",(unsigned long)data.length/1024);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

+ (nullable UIImage *)base64StringToUIImage:(NSString *)encodedImageStr {
    NSData * decodedImageData = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    UIImage * decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

+ (UIImage *)imageWithGIFData:(NSData *)data {
    if (!data) return nil;
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    } else {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        for (size_t i = 0; i < count; i++) {
            // 拿出了Gif的每一帧图片
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            //Learning... 设置动画时长 算出每一帧显示的时长（帧时长）
            NSTimeInterval frameDuration = [UIImage sd_frameDurationAtIndex:i source:source];
            duration += frameDuration;
            // 将每帧图片添加到数组中
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            // 释放真图片对象
            CFRelease(image);
        }
        // 设置动画时长
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    // 释放源Gif图片
    CFRelease(source);
    return animatedImage;
}

+ (UIImage *)imageNamed:(NSString *)name inBundleOfName:(NSString *)bundleName {
    if (name.length == 0 || bundleName.length == 0) return nil;
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]];
    UIImage *image = [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
//    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
//    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
//    if (bundle == nil) return nil;
//    CGFloat scale = [UIScreen mainScreen].scale;
//    NSString *fileName = nil;
//    if (ABS(scale - 3) <= 0.001) { // 3倍图
//        fileName = [NSString stringWithFormat:@"%@@3x", name];
//    } else { // 2倍图
//        fileName = [NSString stringWithFormat:@"%@@2x", name];
//    }
//    return [UIImage imageWithContentsOfFile:[bundle pathForResource:fileName ofType:@"png"]];
}

+ (UIImage *)imageWithGIFNamed:(NSString *)name {
    NSUInteger scale = (NSUInteger)[UIScreen mainScreen].scale;
    return [self GIFName:name scale:scale];
}

+ (UIImage *)GIFName:(NSString *)name scale:(NSUInteger)scale {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    if (!imagePath) {
        (scale + 1 > 3) ? (scale -= 1) : (scale += 1);
        imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    }
    if (imagePath) {
        // 传入图片名(不包含@Nx)
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        return [UIImage imageWithGIFData:imageData];
    } else {
        imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        if (imagePath) {
            // 传入的图片名已包含@Nx or 传入图片只有一张 不分@Nx
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            return [UIImage imageWithGIFData:imageData];
        } else {
            // 不是一张GIF图片(后缀不是gif)
            return [UIImage imageNamed:name];
        }
    }
}

+ (void)imageWithGIFUrl:(NSString *)url callBack:(void (^ _Nullable)(UIImage * _Nullable))callBack {
    NSURL *GIFUrl = [NSURL URLWithString:url];
    if (!GIFUrl) return;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *CIFData = [NSData dataWithContentsOfURL:GIFUrl];
        // 刷新UI在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            if (callBack) callBack([UIImage imageWithGIFData:CIFData]);
        });
    });
    
}

#pragma mark - <关于GIF图片帧时长(Learning...)>

+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    } else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    return frameDuration;
}

#pragma mark - 生成条形码以及二维码

+ (UIImage *_Nullable)generateQRCode:(NSString * _Nonnull)urlString codeSize:(CGSize)codeSize {    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [urlString dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    // 消除模糊
    CGFloat scaleX = codeSize.width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = codeSize.height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    return [UIImage imageWithCIImage:transformedImage];
}

@end
