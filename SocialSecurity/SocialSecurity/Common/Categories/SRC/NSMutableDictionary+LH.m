//
//  NSMutableDictionary_CISCommon.m
//  PhoneSchool
//
//  Created by zhang on 13-5-3.
//
//

#import "NSMutableDictionary+LH.h"
#import "NSString+LH.h"
@implementation NSMutableDictionary (LH)

- (void)setString:(NSString *)str forKey:(id <NSCopying>)aKey {
    if ([NSString isNilOrEmpty:str]) {
        [self setObject:@"" forKey:aKey];
    }
    else{
        [self setObject:str forKey:aKey];
    }
    
    
}

- (void)setInteger:(long)value forKey:(id <NSCopying>)aKey {
    @try {
        [self setObject:[NSNumber numberWithLong:value] forKey:aKey];
    }
    @catch (NSException *exception) {
        NSLog(@"操作异常");
    }
    @finally {
        
    }
    
}
- (void)setLong:(long long)value forKey:(id <NSCopying>)aKey {
    @try {
        [self setObject:[NSNumber numberWithLongLong:value] forKey:aKey];
    }
    @catch (NSException *exception) {
        NSLog(@"操作异常");
    }
    @finally {
        
    }
    
}

- (void)setBoolean:(BOOL)value forKey:(id<NSCopying>)aKey{
    @try {
        [self setObject:[NSNumber numberWithBool:value] forKey:aKey];
    }
    @catch (NSException *exception) {
        NSLog(@"操作异常");
    }
    @finally {
        
    }
}

- (void)setFloat:(float)value forKey:(id<NSCopying>)aKey{
    @try {
        [self setObject:[NSNumber numberWithFloat:value] forKey:aKey];
    }
    @catch (NSException *exception) {
        NSLog(@"操作异常");
    }
    @finally {
        
    }
}
@end