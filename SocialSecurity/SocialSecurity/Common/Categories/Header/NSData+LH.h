//
//  NSData+speexConvert.h
//  XMPPIOS
//
//  Created by 琪 on 14-3-19.
//  Copyright (c) 2014年 Dawn_wdf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSData (LH)
/**
 * 将UIImage图像转成NSData
 */
+ (NSData *)dataWithImage:(UIImage *)image scale:(float)scale;

/**
 * 将NSString转成NSData
 *  逆向请参考 NSString+LH.h -> stringByEncodingData:
 */
+ (NSData *)dataWithString:(NSString *)string;
@end
