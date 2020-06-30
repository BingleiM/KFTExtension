//
//  NSString+KFTExtension.h
//  KFTPaySDK
//
//  Created by 马冰垒 on 2017/11/13.
//  Copyright © 2017年 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSString (KFTExtension)

/** 计算字符串的高度 */
+ (CGSize)boundingSizeWithLimitWith:(CGFloat)limitWidth
                               font:(UIFont *)font
                             string:(NSString *)string;

/** 计算字符串的宽度 */
+ (CGSize)boundingSizeWithLimitHeight:(CGFloat)limitHeight
                                 font:(UIFont *)font
                               string:(NSString *)string;

/**
 富文本高度
 
 @param lineSpace 行距
 @param textFont 字体大小
 @param limitWidth 最大的宽度
 @return 高度
 */
+ (CGSize)attributeStringHeightWithLineSpace:(CGFloat)lineSpace
                                    textFont:(UIFont *)textFont
                                   limitWith:(CGFloat)limitWidth
                                      string:(NSString *)string;

/**
 返回富文本
 
 @param lineSpace 行间距
 @param textColor 文字颜色
 @param textFont 文字大小
 @return 富文本
 */
+ (NSAttributedString *)attributeStringWithParagraplineSpace:(CGFloat)lineSpace
                                                   textColor:(UIColor *)textColor
                                                    textFont:(UIFont *)textFont
                                                        text:(NSString *)text;

/** 转化 HTML 标签 */
+ (NSAttributedString *)stringFromHTML:(NSString *)HTML font:(UIFont *)font;

/** 字典转 json 字符串 */
+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dict;

/** json 字符串转字典 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/** 验证电话号码 */
+ (BOOL)isValidMobile:(NSString *)mobileString;

/** 验证是否是有效手机验证码 */
+ (BOOL)isValidPhoneVerificationCode:(NSString *)code;

/** 验证邮箱 */
+ (BOOL)isValidEmail:(NSString *)emailString;

/** 验证有效身份证号 */
+ (BOOL)isValidIdentityCard:(NSString *)identityCardString;

/** 验证有效银行卡号（目前要求12-19位，全是数字） */
+ (BOOL)isValidBankCard:(NSString *)bankCard;

/** 验证是否是有效昵称（限制只能输入中文/英文/数字） */
+ (BOOL)isValidNickName:(NSString *)nameString;

/** 验证是否是有效登录名（限制只能输入英文/数字） */
+ (BOOL)isValidLogName:(NSString *)logNameString;

/** 验证密码 */
+ (BOOL)isValidPassword:(NSString *)passwordString;

/** 验证是否包含特殊字符 */
+ (BOOL)containsSpecialChar:(NSString *)string;

/** 验证是否为空字符串 */
+ (BOOL)isEmptyString:(NSString *)string;

/** 验证是否为有效邀请码 */
+ (BOOL)isValidInviteCode:(NSString *)string;

/** 验证是否是合法的 url 链接， 如：http://www.baidu.com 或者 http://192.168.1.1） */
+ (BOOL)isValidUrl:(NSString *)urlString;

/** 限制输入 0~9 和 . */
+ (BOOL)isValidateNumber:(NSString*)number;

/** 限制输入 0~9 */
+ (BOOL)isValidateNumberWithNoDot:(NSString*)number;

/** 限制输入 字母和数字 */
+ (BOOL)isValidateNumberOrLetter:(NSString*)string;

/** 判断输入的字符串是否有中文 */
+ (BOOL)containsOfChinese:(NSString *)string;

/** 获取非空字符串 */
+ (NSString *)fetchNoneNilString:(NSString *)string;

/** 格式化银行卡号（每4位添加一个空格） */
+ (NSString *)fetchBankCardNumberFormat:(NSString *)bankCardNumber;

/** 格式化银行卡号（移除中间的中空格） */
+ (NSString *)fetchBankcardNumberWithoutWhitespace:(NSString *)bankcardNumber;

/**
 返回格式为￥xx.xx的字符串
 
 @param fen 单位为分的金额数
 @return 格式化后的字符串 如(￥12.11)
 */
+ (NSString *)fetchMoneyFormatStringYuanFromFen:(NSUInteger)fen;

/** 获取字符串中的所有数字 */
+ (NSInteger)fetchIntergerValueFromString:(NSString *)string;

/** 字符串转base64（加密） */
+ (NSString *)base64StringFromText:(NSString *)text;

/** base64转字符串（解密） */
+ (NSString *)textFromBase64String:(NSString *)base64;

@end
