//
//  NSMutableDictionary_CISCommon.h
//  PhoneSchool
//
//  Created by zwm on 13-6-5.
//  Copyright (c) 2013年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (CISCommon)
- (void)setString:(NSString * __nullable)str forKey:(id <NSCopying> __nonnull)aKey;
- (void)setInteger:(long)value forKey:(id <NSCopying> __nonnull)aKey;
- (void)setLong:(long long)value forKey:(id <NSCopying> __nonnull)aKey;
- (void)setBoolean:(BOOL)value forKey:(id<NSCopying> __nonnull)aKey;
- (void)setFloat:(float)value forKey:(id<NSCopying> __nonnull)aKey;
@end
