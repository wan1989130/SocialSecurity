//
//  NSMutableArray+LH.h
//  LHFramework
//
//  Created by 李琪 on 15/7/16.
//  Copyright (c) 2015年 Lihuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSMutableArray (LH)
/**
 * 创建一个公包含一个NSIndexPath类型值的数组
 */
+ (NSMutableArray *)createIndexPathArrayForRow:(NSInteger)row inSection:(NSInteger)section;
@end
