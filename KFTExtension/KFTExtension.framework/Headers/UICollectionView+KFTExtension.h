//
//  UICollectionView+KFTExtension.h
//  KFTPaySDK
//
//  Created by 马冰垒 on 2017/8/8.
//  Copyright © 2017年 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (KFTExtension)

- (void)registerNib:(Class)nibClass forSupplementaryViewOfKind:(NSString *)kind;

- (void)registerViewClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)kind;

- (void)registerNibClass:(Class)nibClass;

- (void)registerCellClass:(Class)cellClass;

/**
 获取collectionView items个数
 
 @return items个数
 */
- (NSInteger)fetchItemsCount;

@end
