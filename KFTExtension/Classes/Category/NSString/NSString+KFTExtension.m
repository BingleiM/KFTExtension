//
//  NSString+KFTExtension.m
//  KFTPaySDK
//
//  Created by 马冰垒 on 2017/11/13.
//  Copyright © 2017年 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import "NSString+KFTExtension.h"

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (Extension)

+ (CGSize)boundingSizeWithLimitWith:(CGFloat)limitWidth font:(UIFont *)font string:(NSString *)string
{
    NSDictionary *attribute = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(limitWidth, MAXFLOAT);
    CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    return rect.size;
}

+ (CGSize)boundingSizeWithLimitHeight:(CGFloat)limitHeight
                                 font:(UIFont *)font
                               string:(NSString *)string
{
    NSDictionary *attribute = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(MAXFLOAT, limitHeight);
    CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    return rect.size;
}

+ (CGSize)attributeStringHeightWithLineSpace:(CGFloat)lineSpace
                                    textFont:(UIFont *)textFont
                                   limitWith:(CGFloat)limitWidth
                                      string:(NSString *)string
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = lineSpace;
    NSDictionary *attribute = @{
                                NSFontAttributeName:textFont, NSParagraphStyleAttributeName:paraStyle
                                };
    CGSize size = [string boundingRectWithSize:CGSizeMake(limitWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return size;
}

+ (NSAttributedString *)attributeStringWithParagraplineSpace:(CGFloat)lineSpace
                                                   textColor:(UIColor *)textColor
                                                    textFont:(UIFont *)textFont
                                                        text:(NSString *)text
{
    if ([NSString isEmptyString:text]) return nil;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attribute = @{NSForegroundColorAttributeName:textColor,
                                NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName: paragraphStyle,
                                };
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString fetchNoneNilString:text] attributes:attribute];
    
    if (attributedString.length > 0) {
        [attributedString addAttributes:attribute range:NSMakeRange(0, text.length)];
        return attributedString;
    }
    return [[NSAttributedString alloc] init];
}

+ (NSAttributedString *)stringFromHTML:(NSString *)HTML font:(UIFont *)font {
    NSDictionary *attribute = @{
                                NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSFontAttributeName:font
                                };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[HTML dataUsingEncoding:NSUnicodeStringEncoding] options:attribute documentAttributes:nil error:nil];
    return attributedString ? attributedString : [NSAttributedString new];
}

+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dict {
    NSError *error;
    
    // 注
    //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingSortedKeys error:&error];
    
    // NSJSONWritingSortedKeys这个枚举类型只适用iOS11所以我是使用下面写法解决的
    NSJSONWritingOptions writingOption = NSJSONWritingPrettyPrinted;
    if (@available(iOS 11, *)) {
        writingOption = NSJSONWritingSortedKeys;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:writingOption error:&error];
    
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if ([NSString isEmptyString:jsonString]) return nil;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"解析 JsonString 失败 ====> %@", error.localizedDescription);
    }
    return dict;
}

+ (BOOL)isValidMobile:(NSString *)mobileString {
    NSString *mobile = @"^1[3-9]\\d{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    return [predicate evaluateWithObject:mobileString];
//    BOOL valid = NO;
//    NSString *regex =@"[0-9]*";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    if (mobileString.length == 11) {
//        valid = [predicate evaluateWithObject:mobileString];
//    }
//    return valid;
}

+ (BOOL)isValidPhoneVerificationCode:(NSString *)code {
    BOOL valid = NO;
    NSString *regex =@"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (code.length == 6) {
        valid = [predicate evaluateWithObject:code];
    }
    return valid;
}

+ (BOOL)isValidEmail:(NSString *)emailString {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [predicate evaluateWithObject:emailString];
}

+ (BOOL)isValidIdentityCard:(NSString *)identityCardString {
    NSString *idCardNumber = [identityCardString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([idCardNumber length] != 18) return NO;
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:idCardNumber]) return NO;
    int summary = ([idCardNumber substringWithRange:NSMakeRange(0,1)].intValue + [idCardNumber substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([idCardNumber substringWithRange:NSMakeRange(1,1)].intValue + [idCardNumber substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([idCardNumber substringWithRange:NSMakeRange(2,1)].intValue + [idCardNumber substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([idCardNumber substringWithRange:NSMakeRange(3,1)].intValue + [idCardNumber substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([idCardNumber substringWithRange:NSMakeRange(4,1)].intValue + [idCardNumber substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([idCardNumber substringWithRange:NSMakeRange(5,1)].intValue + [idCardNumber substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([idCardNumber substringWithRange:NSMakeRange(6,1)].intValue + [idCardNumber substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [idCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6
    + [idCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[idCardNumber substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

/**
 校验身份证号码是否正确 返回BOOL值
 十八位： ^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$
 
 十五位： ^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$
 
 总结：
 
 ^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$

 @param idCardString 身份证号码
 @return 返回BOOL值 YES or NO
 */
+ (BOOL)cly_verifyIDCardString:(NSString *)idCardString {
    if (idCardString.length != 15 || idCardString.length != 18) return NO;
    if (idCardString.length == 15) {
        NSString *regex = @"^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [predicate evaluateWithObject:idCardString];
    }
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:idCardString];
    if (!isRe) {
        //身份证号码格式不对
        return NO;
    }
    //加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    NSInteger sum = 0;//保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) {//将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [idCardString substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }
    
    NSInteger modNum = sum % 11;//总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; //根据余数取出校验码
    NSString *idCardLast = [idCardString.uppercaseString substringFromIndex:17]; //获取身份证最后一位
    
    if (modNum == 2) {//等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { //身份证号码验证成功
        return YES;
    } else { //身份证号码验证失败
        return NO;
    }
}

+ (BOOL)isValidBankCard:(NSString *)bankCard {
    return ([self isValidateNumberWithNoDot:bankCard] && bankCard.length >= 12);
}

+ (BOOL)isValidNickName:(NSString *)nameString {
    if ([nameString isEqualToString:@""] || [@"➋➌➍➎➏➐➑➒" rangeOfString:nameString].location != NSNotFound) {
        return NO;
    } else {
        /** 昵称限制输入字母、数字、汉字 */
        NSString *regex= @"[A-Za-z0-9\u4e00-\u9fa5]+";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regex];
        return [pred evaluateWithObject:nameString];
    }
}

+ (BOOL)isValidLogName:(NSString *)logNameString {
    if (logNameString.length < 1 || logNameString.length > 15 || [logNameString isEqualToString:@""] || [@"➋➌➍➎➏➐➑➒" rangeOfString:logNameString].location != NSNotFound) {
        return NO;
    } else {
        /** 昵称限制输入字母、数字 */
        NSString *regex= @"[a-zA-Z0-9]*";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
        return [pred evaluateWithObject:logNameString];
    }
}

+ (BOOL)isValidPassword:(NSString *)passwordString {
    if ([NSString isEmptyString:passwordString] || passwordString.length < 6 || passwordString.length > 20) return NO;
    NSString *pwdRegex = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:pwdRegex] invertedSet];
    NSString *filter = [[passwordString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL canChange = [passwordString isEqualToString:filter];
    return canChange;
}

+ (BOOL)containsSpecialChar:(NSString *)string {
    NSString *charRegex = @"[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）&mdash;—|{}【】‘；：”“'。，、？]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", charRegex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isEmptyString:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    if (string == nil || string == NULL || [string isEqualToString:@"<null>"] || [string isKindOfClass:[NSNull class]] || string.length == 0) return YES;
    if ( [string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isValidInviteCode:(NSString *)string {
    BOOL valid = NO;
    NSString *regex = @"[a-zA-Z0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (string.length == 4) {
        valid = [predicate evaluateWithObject:string];
    }
    return valid;
}

+ (NSString *)fetchNoneNilString:(NSString *)string {
    if ([NSString isEmptyString:string]) {
        return @"";
    }
    return string;
}

+ (NSString *)fetchMoneyFormatStringYuanFromFen:(NSUInteger)fen {
    NSString *yuanStr;
    if(fen % 100 == 0) {
        yuanStr = [NSString stringWithFormat:@"￥%.0f", fen/100.0];
    }else {
        yuanStr = [NSString stringWithFormat:@"￥%.2f", fen/100.0];
        if([[yuanStr substringFromIndex:yuanStr.length-1] isEqualToString:@"0"]) {
            yuanStr = [yuanStr substringWithRange:NSMakeRange(0, yuanStr.length-1)];
        }
    }
    
    return yuanStr;
}

+ (BOOL)containsOfChinese:(NSString *)string {
    for(int i=0; i < string.length; i++) {
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

+ (NSString *)fetchBankCardNumberFormat:(NSString *)bankCardNumber {
    if ([NSString isEmptyString:bankCardNumber]) return @"";
    NSString *cardNumber = bankCardNumber;
    NSMutableArray *tempArray = @[].mutableCopy;
    while (cardNumber.length) {
        NSRange range = NSMakeRange(0, MIN(4, cardNumber.length));
        NSString *subString = [cardNumber substringWithRange:range];
        cardNumber = [cardNumber substringFromIndex:range.length];
        [tempArray addObject:subString];
    }
    return [tempArray componentsJoinedByString:@" "];
}

+ (NSString *)fetchBankcardNumberWithoutWhitespace:(NSString *)bankcardNumber {
    if ([NSString isEmptyString:bankcardNumber]) return @"";
    NSString *bankCardNum = [bankcardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    bankCardNum = [bankCardNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return bankCardNum;
}

+ (BOOL)isValidUrl:(NSString *)urlString {
    NSString *regex = @"((http|ftp|https)://)(([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\&%_\./-~-]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:urlString];
}

+ (BOOL)isValidateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+ (BOOL)isValidateNumberWithNoDot:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString *string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+ (BOOL)isValidateNumberOrLetter:(NSString *)string {
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

+ (NSInteger)fetchIntergerValueFromString:(NSString *)string {
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return[[[string componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""] integerValue];
}

// 字符串转base64（加密）
+ (NSString *)base64StringFromText:(NSString *)text {
    if (![NSString isEmptyString:text]) {
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    else {
        return @"";
    }
    /*
    if (![NSString isEmptyString:text]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return @"";
    }
     */
}

// base64转字符串（解密）
+ (NSString *)textFromBase64String:(NSString *)base64 {
    if (![NSString isEmptyString:base64]) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return @"";
    }
    /*
    if (![NSString isEmptyString:base64]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return @"";
    }
     */
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string {
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data {
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end
