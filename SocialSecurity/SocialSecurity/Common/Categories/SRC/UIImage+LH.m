//
//  UIImage+ImageCompress.m
//  FamilySchool
//
//  Created by xiaoming on 14-6-30.
//  Copyright (c) 2014年 phone.dept. All rights reserved.
//

#import "UIImage+LH.h"

#define smallImageMax 80.0
#define minHeight 600
#define minWidth 600

@implementation UIImage (LH)
+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

//计算缩略图片的压缩比例
+ (float)compressSmallScale:(CGSize)size maxH:(float)maxH maxW:(float)maxW
{
    //    float max = 80.0;
    //    NSLog(@"%f-%f",size.width,size.height);
    float tempH = size.height;
    float tempW = size.width;
    float scale = 1.0;
    if(tempH < tempW && tempW > maxW)
    {
        scale = maxW/tempW;
    }
    else if(tempW <= tempH && tempH > maxH)
    {
        scale = maxH/tempH;
    }
    //    NSLog(@"%f",scale);
    return scale;
}

//等比例缩放图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

//计算图片压缩比例
+ (float)compressScale:(CGSize)size
{
    float tempH = size.height;
    float tempW = size.width;
    float scale = 1.0;
    if(tempH < tempW && tempH > minHeight)
    {
        scale = minHeight/tempH;
    }
    else if(tempW <= tempH && tempW > minWidth)
    {
        scale = minWidth/tempW;
    }
    return scale;
}

+ (NSData *)dataWithImage:(UIImage *)image scale:(float)scale{
    if (UIImageJPEGRepresentation(image, scale) == nil) {
        return UIImagePNGRepresentation(image);
    } else {
        return UIImageJPEGRepresentation(image, scale);
        
    }
}

+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
