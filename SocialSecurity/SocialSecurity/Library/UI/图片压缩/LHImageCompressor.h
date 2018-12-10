//
//  LHImageCompressor.h
//  HandleSchool
//
//  Created by 李琪 on 16/10/14.
//  Copyright © 2016年 Huihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LHImageCompressor : NSObject
+ (UIImage *)compressImage:(UIImage *)image;
    + (UIImage *)scaleImage:(UIImage *)image toTargetSize:(CGSize)targetSize;
    @end
