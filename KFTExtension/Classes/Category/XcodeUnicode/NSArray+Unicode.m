//
//  NSArray+Unicode.m
//  TestExample
//
//  Created by Apple on 2019/1/25.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "NSArray+Unicode.h"
#import "NSObject+SafeSwizzle.h"
#import "NSString+Unicode.h"

@implementation NSArray (Unicode)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:[self class] selector:@selector(description) withSwizzledSelector:@selector(chinese_description)];
        [self exchangeInstance:[self class] selector:@selector(descriptionWithLocale:) withSwizzledSelector:@selector(chinese_descriptionWithLocale:)];
        [self exchangeInstance:[self class] selector:@selector(descriptionWithLocale:indent:) withSwizzledSelector:@selector(chinese_descriptionWithLocale:indent:)];
        //越界崩溃方式一：[array objectAtIndex:1000];
        [self exchangeInstance:objc_getClass("__NSArrayI") selector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safeObjectAtIndex:)];
//        [objc_getClass("__NSArrayI") swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safeObjectAtIndex:)];
        //越界崩溃方式二：arr[1000];   Subscript n:下标、脚注
        [self exchangeInstance:objc_getClass("__NSArrayI") selector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(safeobjectAtIndexedSubscript:)];
//        [objc_getClass("__NSArrayI") swizzleSelector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(safeobjectAtIndexedSubscript:)];
    });
}

- (NSString *)chinese_description{
    return [[self chinese_description] stringByReplaceUnicode];
}

- (NSString *)chinese_descriptionWithLocale:(nullable id)locale{
    return [[self chinese_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)chinese_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level{
    return [[self chinese_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

- (instancetype)safeObjectAtIndex:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (index > (self.count - 1)) { // 数组越界
        return nil;
    }else { // 没有越界
        return [self safeObjectAtIndex:index];
    }
}

- (instancetype)safeobjectAtIndexedSubscript:(NSUInteger)index {
    if (index > (self.count - 1)) { // 数组越界
        return nil;
    }else { // 没有越界
        return [self safeobjectAtIndexedSubscript:index];
    }
}

@end
