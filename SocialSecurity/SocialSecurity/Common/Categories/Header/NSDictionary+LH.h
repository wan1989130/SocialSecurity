//
//  NSDictionary+LH.h
//  LHFramework
//
//  Created by 李琪 on 15/7/13.
//  Copyright (c) 2015年 Lihuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDictionary (LH)
- (NSString *)stringValueForKey:(NSString *)aKey;
- (NSInteger)integerValueForKey:(NSString *)aKey;
- (CGFloat)floatValueForKey:(NSString *)aKey;
- (BOOL)boolValueForKey:(NSString *)aKey;
@end
