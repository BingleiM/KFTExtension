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

/**
 *  计算文件 MD5 值
 *
 *  @param path 传入文件路径
 *
 *  @return 返回文件 MD5 值, 如果想要校验 MD5 值正确性, 可以在 Mac 终端中输入 MD5空格 '文件路径', 将终端输出的 MD5 值相比较
 */
+ (NSString *)getFileMD5WithPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
