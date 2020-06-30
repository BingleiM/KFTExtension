//
//  NSMutableArray+NilSafe.m
//  NilDictionaryTest
//
//  Created by 张张凯 on 2018/2/2.
//  Copyright © 2018年 TRS. All rights reserved.
//

#import "NSMutableArray+NilSafe.h"
#import <objc/runtime.h>
#import "NSObject+SafeSwizzle.h"
@implementation NSMutableArray (NilSafe)


//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        //1、提示移除的数据不能为空
//        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(removeObject:) withSwizzledSelector:@selector(hdf_safeRemoveObject:)];
//
////        [self swizzleSelector:@selector(removeObject:) withSwizzledSelector:@selector(hdf_safeRemoveObject:)];
//        
//        //2、提示数组不能添加为nil的数据
//        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(addObject:) withSwizzledSelector:@selector(hdf_safeAddObject:)];
////        [objc_getClass("__NSArrayM") swizzleSelector:@selector(addObject:) withSwizzledSelector:@selector(hdf_safeAddObject:)];
//        //3、移除数据越界
//        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(removeObjectAtIndex:) withSwizzledSelector:@selector(hdf_safeRemoveObjectAtIndex:)];
////        [objc_getClass("__NSArrayM") swizzleSelector:@selector(removeObjectAtIndex:) withSwizzledSelector:@selector(hdf_safeRemoveObjectAtIndex:)];
//        //4、插入数据越界
//        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(insertObject:atIndex:) withSwizzledSelector:@selector(hdf_insertObject:atIndex:)];
////        [objc_getClass("__NSArrayM") swizzleSelector:@selector(insertObject:atIndex:) withSwizzledSelector:@selector(hdf_insertObject:atIndex:)];
//    
//        //5、处理[arr objectAtIndex:1000]这样的越界
//        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(objectAtIndex:) withSwizzledSelector:@selector(hdf_objectAtIndex:)];
////        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(hdf_objectAtIndex:)];
//        
//        //6、处理arr[1000]这样的越界
//        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(safeobjectAtIndexedSubscript:)];
////        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(safeobjectAtIndexedSubscript:)];
//        
//        //7、替换某个数据越界
//        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(replaceObjectAtIndex:withObject:) withSwizzledSelector:@selector(safereplaceObjectAtIndex:withObject:)];
////        [objc_getClass("__NSArrayM") swizzleSelector:@selector(replaceObjectAtIndex:withObject:) withSwizzledSelector:@selector(safereplaceObjectAtIndex:withObject:)];
//        
//    });
//}

- (instancetype)hdf_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"%@", objects[i]);
        }
        if (objects[i] == nil) {
            hasNilObject = YES;
            NSLog(@"%s object at index %lu is nil, it will be filtered", __FUNCTION__, i);
        }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        
        NSLog(@"%@", [NSThread callStackSymbols]);
        return [self hdf_initWithObjects:newObjects count:index];
    }
    
    return [self hdf_initWithObjects:objects count:cnt];
}


- (void)hdf_safeAddObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s can add nil object into NSMutableArray", __FUNCTION__);
    } else {
        [self hdf_safeAddObject:obj];
    }
}

- (void)hdf_safeRemoveObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s call -removeObject:, but argument obj is nil", __FUNCTION__);
        return;
    }
    
    [self hdf_safeRemoveObject:obj];
}

- (void)hdf_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"%s can't insert nil into NSMutableArray", __FUNCTION__);
    } else if (index > self.count) {
        NSLog(@"%s index is invalid", __FUNCTION__);
    } else {
        [self hdf_insertObject:anObject atIndex:index];
    }
}

- (id)hdf_objectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return nil;
    }
    
    if (index > self.count) {
        NSLog(@"%s index out of bounds in array", __FUNCTION__);
        return nil;
    }
    
    return [self hdf_objectAtIndex:index];
}

- (void)hdf_safeRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return;
    }
    
    if (index >= self.count) {
        NSLog(@"%s index out of bound", __FUNCTION__);
        return;
    }
    
    [self hdf_safeRemoveObjectAtIndex:index];
}

// 1、索引越界 2、移除索引越界 3、替换索引越界
- (instancetype)safeobjectAtIndexedSubscript:(NSUInteger)index{
    
    if (index > (self.count - 1)) { // 数组越界
        NSLog(@"索引越界");
        return nil;
    }else { // 没有越界
        return [self safeobjectAtIndexedSubscript:index];
    }
    
}

- (instancetype)safereplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (index > (self.count - 1)) { // 数组越界
        NSLog(@"移除索引越界");
        return nil;
    }else { // 没有越界
        return [self safeobjectAtIndexedSubscript:index];
    }
    
}


@end
