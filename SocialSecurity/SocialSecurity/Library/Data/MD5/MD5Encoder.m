 //
//  MyMD5.m
//  GoodLectures
//
//  Created by yangshangqing on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MD5Encoder.h"
#import "CommonCrypto/CommonDigest.h"

@implementation MD5Encoder

+(NSString *) md5: (NSString *) inPutText 
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[32];
    NSInteger length = strlen(cStr);
    NSNumber *lenNum = [NSNumber numberWithInteger:length];
    
    
    CC_MD5(cStr, [lenNum unsignedIntValue], result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *) encrypt: (NSData *)inputData{
    NSString *str =  [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
    return [MD5Encoder md5:str];

}
@end
