//
//  MyMD5.h
//  GoodLectures
//
//  Created by yangshangqing on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MD5Encoder : NSObject {
    
}
/*****
 2011.09.15
 创建： shen
 MD5 加密
 *****/

+(NSString *) md5: (NSString *) inPutText ;

+ (NSString *) encrypt: (NSData *)inputData;
@end
