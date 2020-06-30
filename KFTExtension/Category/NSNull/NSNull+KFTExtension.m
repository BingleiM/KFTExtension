//
//  NSNull+KFTExtension.m
//  KFTPaySDK
//
//  Created by 马冰垒 on 2019/7/9.
//  Copyright © 2019 kftpay. All rights reserved.
//

#import "NSNull+KFTExtension.h"

#define NSNullObjects @[@"",@0,@{},@[]]

@implementation NSNull (KFTExtension)

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        for (NSObject *object in NSNullObjects) {
            signature = [object methodSignatureForSelector:selector];
            if (signature) {
                break;
            }
        }
        
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    
    for (NSObject *object in NSNullObjects) {
        if ([object respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    [self doesNotRecognizeSelector:aSelector];
}

@end
