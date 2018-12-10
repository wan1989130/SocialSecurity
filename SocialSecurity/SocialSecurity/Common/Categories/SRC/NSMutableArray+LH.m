//
//  NSMutableArray+LH.m
//  LHFramework
//
//  Created by 李琪 on 15/7/16.
//  Copyright (c) 2015年 Lihuo. All rights reserved.
//

#import "NSMutableArray+LH.h"

@implementation NSMutableArray (LH)
+ (NSMutableArray *)createIndexPathArrayForRow:(NSInteger)row inSection:(NSInteger)section{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [indexPaths addObject: indexPath];
    
    return indexPaths;
}

@end
