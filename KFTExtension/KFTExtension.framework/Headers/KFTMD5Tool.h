//
//  KFTPaySDKMD5Tool.h
//  KFTPaySDK
//
//  Created by 马冰垒 on 2019/7/1.
//  Copyright © 2019 kftpay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KFTMD5Tool : NSObject
/**
 *  MD5加密, 32位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (NSString * _Nonnull )MD5ForLower32Bate:( NSString * _Nonnull )str;

/**
 *  MD5加密, 32位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *_Nonnull)MD5ForUpper32Bate:(NSString *_Nonnull)str;

/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *_Nonnull)MD5ForLower16Bate:(NSString *_Nonnull)str;

/**
 *  MD5加密, 16位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *_Nonnull)MD5ForUpper16Bate:(NSString *_Nonnull)str;

/**
 *  获取随机16位字符串，长度为16位，只能包含数字、大小写字母
 *
 *  @return 随机16位字符串，长度为16位，只能包含数字、大小写字母
 */
+ (NSString *_Nonnull)fetch16BateLetterAndNumber;

/**
 *  获取随机32位字符串，长度为32位，只能包含数字、大小写字母
 *
 *  @return 随机32位字符串，长度为32位，只能包含数字、大小写字母
 */
+ (NSString *_Nonnull)fetch32BateLetterAndNumber;

@end

NS_ASSUME_NONNULL_END
