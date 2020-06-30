//
//  UITableView+KFTExtension.m
//  KFTPaySDK
//
//  Created by 深圳快付通金融网络科技有限公司 on 2017/6/19.
//  Copyright © 2017年 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import "UITableView+KFTExtension.h"

@implementation UITableView (KFTExtension)

- (void)registerHeaderFooterWithNibClass:(Class)nibClass {
    UINib *nibName = [UINib nibWithNibName:NSStringFromClass(nibClass) bundle:[NSBundle mainBundle]];
    [self registerNib:nibName forHeaderFooterViewReuseIdentifier:NSStringFromClass(nibClass)];
}

- (void)registerHeaderFooterWithViewClass:(Class)viewClass {
    [self registerClass:viewClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(viewClass)];
}

- (void)registerNib:(Class)nibClass {
    UINib *nibName = [UINib nibWithNibName:NSStringFromClass(nibClass) bundle:[NSBundle mainBundle]];
    [self registerNib:nibName forCellReuseIdentifier:NSStringFromClass(nibClass)];
}

- (void)registerClass:(Class)cellClass {
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (NSInteger)fetchItemsCount {
    NSInteger sections = 1;
    NSInteger items = 0;
    id <UITableViewDataSource> dataSource = self.dataSource;
    if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self];
    }
    if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        for (NSInteger section = 0; section < sections; section++) {
            items += [dataSource tableView:self numberOfRowsInSection:section];
        }
    }
    return items;
}

@end
