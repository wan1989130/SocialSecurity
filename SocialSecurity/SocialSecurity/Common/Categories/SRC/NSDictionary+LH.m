//
//  NSDictionary+LH.m
//  LHFramework
//
//  Created by 李琪 on 15/7/13.
//  Copyright (c) 2015年 Lihuo. All rights reserved.
//

#import "NSDictionary+LH.h"

@implementation NSDictionary (LH)
- (NSString *)stringValueForKey:(NSString *)aKey{
    return [[self objectForKey:aKey] stringValue];
}

- (NSInteger)integerValueForKey:(NSString *)aKey{
    return [[self objectForKey:aKey] integerValue];
}

- (CGFloat)floatValueForKey:(NSString *)aKey{
    return [[self objectForKey:aKey] floatValue];
}

- (BOOL)boolValueForKey:(NSString *)aKey{
    return [[self objectForKey:aKey] boolValue];
}
@end
