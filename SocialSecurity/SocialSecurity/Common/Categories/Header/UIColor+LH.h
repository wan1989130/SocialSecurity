//
//  UIColor+RCColor.h
//  RCloudMessage
//
//  Created by Liv on 15/4/3.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r, g, b)        [UIColor colorWithRed:((r) / 256.0) green:((g) / 256.0) blue:((b) / 256.0) alpha:1.0]
#define RGBA(r, g, b, a)    [UIColor colorWithRed:((r) / 256.0) green:((g) / 256.0) blue:((b) / 256.0) alpha:(a)]

@interface UIColor (LH)
/**
 * 获取RGB颜色值，参数为16进制
 * @param color 该参数可以以‘0X’开头也可以以‘#’开头，即0Xffffff或#ffffff，透明度为1
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 * 获取RGB颜色值，参数为16进制
 * @param color 该参数可以以‘0X’开头也可以以‘#’开头，即0Xffffff或#ffffff
 * @param alpha 透明度
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

/**
 * 生成一个纯色的图片
 */
+ (UIImage*) imageWithColor: (UIColor*) color;


- (NSArray *)convertToRGBArray;

- (NSDictionary *)convertToRGBDictionary;
@end
