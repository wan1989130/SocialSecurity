//
//  NSString_CISCommon.m
//  PhoneSchool
//
//  Created by zhang on 13-5-3.
//
//

#import "NSString+LH.h"
#import <Foundation/Foundation.h>

#import "GTMBase64.h"


#import "pinyin.h"
#import "POAPinyin.h"


@implementation NSString (LH)

+ (BOOL)isNilOrEmpty:(NSString *)str {
    if (str && ![str isKindOfClass:[NSNull class]]) {
        return ([str length] == 0);
    }
    return YES;
}

- (NSString *)firstLetter
{
    return [HTFirstLetter firstLetter:self];
}

- (NSString *)firstLetters
{
    return [HTFirstLetter firstLetters:self];
}

- (NSString *)allLetters
{
    NSString *letters = [POAPinyin Convert:self];
    return [letters stringByReplacingOccurrencesOfString:@" " withString:@""];
}


+ (NSString *)stringByEncodingData:(NSData *)data{
    return [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
}

- (NSString *)htmlWordWrapString {
    if ([self length] == 0)
        return self;
    return [NSString stringWithFormat:@"<div style=\"word-break:break-all;word-wrap:break-word;\">%@</div>", self];
}


+ (NSString *)getDocumentPath {
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}


+ (NSString *)getHtmlStringWithString:(NSString *)str {
    if (str ==  nil || [str length] == 0)
        return @"";
    NSString *htmlStr = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"];
    return [htmlStr htmlWordWrapString];
}

- (NSString*)encodedURLParameterString {
    NSString *result;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 9.0) {

        NSMutableCharacterSet *allSet = [NSMutableCharacterSet letterCharacterSet]; //字母
        NSCharacterSet *decimalDigit = [NSCharacterSet decimalDigitCharacterSet];   //十进制数字
        [allSet formUnionWithCharacterSet:decimalDigit];
        result = [self stringByAddingPercentEncodingWithAllowedCharacters:allSet];
    }
    else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                      (__bridge CFStringRef)self,
                                                                                      NULL,
                                                                                      CFSTR(":/=,!$&'()*+;[]@#?^%\"`<>{}\\|~ "),
                                                                                      kCFStringEncodingUTF8));
#pragma clang diagnostic pop
    }
    return result;
}

- (CGSize)getSizeWithFont:(UIFont *)font{
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

- (CGSize)getSizeWithFont:(UIFont *)font forWidth:(CGFloat)width{
    return [NSString getSizeWithText:self Font:font MaxWidth:width];
}

- (CGSize)getSizeWithFont:(UIFont *)font ConstrainedToSize:(CGSize)constrainedToSize{
    return [NSString getSizeWithText:self Font:font ConstrainedToSize:constrainedToSize];
}

+ (CGFloat)getTextHeightWithText:(NSString *)text Font:(UIFont *)font MaxWidth:(CGFloat)maxWidth{
    return [NSString getSizeWithText:text Font:font MaxWidth:maxWidth].height;
}

+ (CGSize)getSizeWithText:(NSString *)text Font:(UIFont *)font MaxWidth:(CGFloat)maxWidth{
    return [NSString getSizeWithText:text Font:font ConstrainedToSize:CGSizeMake(maxWidth, 10000)];
}

+ (CGSize)getSizeWithText:(NSString *)text Font:(UIFont *)font ConstrainedToSize:(CGSize)constrainedToSize{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    // available only on ios7.0 sdk.
    CGRect rect = [text boundingRectWithSize:constrainedToSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    
    return rect.size;
}


@end
