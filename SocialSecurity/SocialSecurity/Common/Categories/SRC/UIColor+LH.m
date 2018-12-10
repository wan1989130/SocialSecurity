//
//  UIColor+RCColor.m
//  RCloudMessage
//
//  Created by Liv on 15/4/3.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import "UIColor+LH.h"

@implementation UIColor (LH)
+ (UIColor *)colorWithHexString:(NSString *)color{
    return [UIColor colorWithHexString:color alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//UIColor 转UIImage
+ (UIImage*) imageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

- (NSArray *)convertToRGBArray{
    NSArray *preArray = [self.description componentsSeparatedByString:@" "];
    if ([preArray[0] isEqualToString:@"UIDeviceWhiteColorSpace"] || [preArray[0] isEqualToString:@"UIExtendedGrayColorSpace"]){
        return @[[NSNumber numberWithFloat:[preArray[1] floatValue]],[NSNumber numberWithFloat:[preArray[1] floatValue]],[NSNumber numberWithFloat:[preArray[1] floatValue]],[NSNumber numberWithFloat:[preArray[2] floatValue]]];
    }
    else{
        return @[[NSNumber numberWithFloat:[preArray[1] floatValue]],[NSNumber numberWithFloat:[preArray[2] floatValue]],[NSNumber numberWithFloat:[preArray[3] floatValue]],[NSNumber numberWithFloat:[preArray[4] floatValue]]];
    }
}

- (NSDictionary *)convertToRGBDictionary{
    NSArray *array= [self.description componentsSeparatedByString:@" "];
    NSDictionary *result = @{@"red":@[array[1]],
                             @"green":@[array[2]],
                             @"blue":@[array[3]],
                             @"alpha":@[array[4]]
                             };
    return result;
}
@end
