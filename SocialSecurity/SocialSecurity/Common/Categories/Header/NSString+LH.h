//
//  NSString_CISCommon.h
//  PhoneSchool
//
//  Created by zhang on 13-5-3.
//
//

#import <Foundation/NSString.h>
#import <UIKit/UIKit.h>
@interface NSString (LH)
/**
 * 判断字符串是否为空
 */
+ (BOOL)isNilOrEmpty:(NSString *)str;

/**
 * 获取Document路径
 */
+ (NSString *)getDocumentPath;

/**
 * 获取（中文）字符串的首字母
 */
- (NSString *)firstLetter;

/**
 * 获取（中文）字符串中所有汉字首字母组成的字符串
 */
- (NSString *)firstLetters;

/**
 * 获取（中文）字符串的拼音
 */
- (NSString *)allLetters;

/**
 * 将NSData转成NSString
 *  逆向请参考 NSData+LH.h -> dataWithString:
 */
+ (NSString *)stringByEncodingData:(NSData *)data;

/**
 * 计算文本高度
 */
+ (CGFloat)getTextHeightWithText:(NSString *)text Font:(UIFont *)font MaxWidth:(CGFloat)maxWidth;

/**
 * 计算文本尺寸
 */
- (CGSize)getSizeWithFont:(UIFont *)font;
- (CGSize)getSizeWithFont:(UIFont *)font forWidth:(CGFloat)width;
- (CGSize)getSizeWithFont:(UIFont *)font ConstrainedToSize:(CGSize)constrainedToSize;
+ (CGSize)getSizeWithText:(NSString *)text Font:(UIFont *)font MaxWidth:(CGFloat)maxWidth;
+ (CGSize)getSizeWithText:(NSString *)text Font:(UIFont *)font ConstrainedToSize:(CGSize)constrainedToSize;

/**
 * 将字符串转成UIWebView可以直接显示的字符串
 */
+ (NSString *)getHtmlStringWithString:(NSString *)str;

- (NSString *)htmlWordWrapString;

/**
 * LHHTTPClient中使用,将特殊符号转码成%xx形式
 */
- (NSString*)encodedURLParameterString;



@end
