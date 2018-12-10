//
//  UIImage+ImageCompress.h
//  FamilySchool
//
//  Created by xiaoming on 14-6-30.
//  Copyright (c) 2014年 phone.dept. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (ImageCompress)
/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize;

//计算缩略图片的压缩比例
+ (float)compressSmallScale:(CGSize)size maxH:(float)maxH maxW:(float)maxW;

//等比例缩放图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

//计算图片压缩比例
+ (float)compressScale:(CGSize)size;

+ (UIImage*) createImageWithColor: (UIColor*) color;
@end
