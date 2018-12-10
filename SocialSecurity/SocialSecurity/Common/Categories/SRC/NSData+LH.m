//
//  NSData+speexConvert.m
//  XMPPIOS
//
//  Created by 琪 on 14-3-19.
//  Copyright (c) 2014年 Dawn_wdf. All rights reserved.
//

#import "NSData+LH.h"

@implementation NSData (LH)


+ (NSData *)dataWithImage:(UIImage *)image scale:(float)scale{
    if (UIImageJPEGRepresentation(image, scale) == nil) {
        return UIImagePNGRepresentation(image);
    } else {
        return UIImageJPEGRepresentation(image, scale);
        
    }
}

+ (NSData *)dataWithString:(NSString *)string{
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}
@end
