//
//  UICollectionView+KFTExtension.m
//  KFTPaySDK
//
//  Created by 深圳快付通金融网络科技有限公司 on 2017/8/8.
//  Copyright © 2017年 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import "UICollectionView+KFTExtension.h"

@implementation UICollectionView (KFTRegisterCell)

- (void)registerNib:(Class)nibClass forSupplementaryViewOfKind:(NSString *)kind {
    UINib *nibName = [UINib nibWithNibName:NSStringFromClass(nibClass) bundle:[NSBundle mainBundle]];
    [self registerNib:nibName forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(nibClass)];
}

- (void)registerViewClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)kind {
    [self registerClass:[viewClass class] forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(viewClass)];
}

- (void)registerNibClass:(Class)nibClass {
    UINib *nibName = [UINib nibWithNibName:NSStringFromClass(nibClass) bundle:[NSBundle mainBundle]];
    [self registerNib:nibName forCellWithReuseIdentifier:NSStringFromClass(nibClass)];
}

- (void)registerCellClass:(Class)cellClass {
    [self registerClass:[cellClass class] forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (NSInteger)fetchItemsCount {
    NSInteger sections = 1;
    NSInteger items = 0;
    id <UICollectionViewDataSource> dataSource = self.dataSource;
    if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [dataSource numberOfSectionsInCollectionView:self];
    }
    if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        for (NSInteger section = 0; section < sections; section++) {
            items += [dataSource collectionView:self numberOfItemsInSection:section];
        }
    }
    return items;
}

@end
