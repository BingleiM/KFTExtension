//
//  NSData+KFTExtension.h
//  KFTPaySDK
//
//  Created by 马冰垒 on 2019/5/17.
//  Copyright © 2019 kftpay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KFTExtension)

/** 16 进制字符串转 data */
+ (NSData*)dataWithHexString:(NSString*)str;

/** data 转 16 进制字符串 */
+ (NSString*)hexStringWithData:(NSData*)data;

/** 文本数据进行DES加密 */
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;

/** 文本数据进行DES解密 */
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
