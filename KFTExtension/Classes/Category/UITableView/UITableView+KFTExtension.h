//
//  UITableView+KFTExtension.h
//  KFTPaySDK
//
//  Created by 马冰垒 on 2017/6/19.
//  Copyright © 2017年 深圳快付通金融网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (KFTExtension)

- (void)registerHeaderFooterWithNibClass:(Class)nibClass;

- (void)registerHeaderFooterWithViewClass:(Class)viewClass;

- (void)registerNib:(Class)nibClass;

- (void)registerClass:(Class)cellClass;

/**
 获取tableView items个数

 @return items个数
 */
- (NSInteger)fetchItemsCount;

@end
