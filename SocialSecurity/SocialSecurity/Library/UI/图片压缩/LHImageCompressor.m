//
//  LHImageCompressor.m
//  HandleSchool
//
//  Created by 李琪 on 16/10/14.
//  Copyright © 2016年 Huihai. All rights reserved.
//

#import "LHImageCompressor.h"
#import <UIKit/UIGraphics.h>

#define LHIC_PIC_QUALITY 0.8        // 图片质量
#define LHIC_MAX_WIDTH 612.0        // 最大缺省宽度
#define LHIC_MAX_HEIGHT  816.0      // 最大缺省高度

@implementation LHImageCompressor

    + (UIImage *)compressImage:(UIImage *)image{
        CGFloat height = image.size.height;
        CGFloat width = image.size.width;
        
        if (height < LHIC_MAX_HEIGHT && width < LHIC_MAX_WIDTH){
            return [UIImage imageWithData:UIImageJPEGRepresentation(image, LHIC_PIC_QUALITY)];
        }
        
        CGSize targetSize = image.size;
        CGFloat targetAsp = 1.0;
        CGFloat heightAsp = 1.0;
        CGFloat widthAsp = 1.0;
        
        if (height >= width){
            heightAsp = height / LHIC_MAX_HEIGHT;
            widthAsp = widthAsp / LHIC_MAX_WIDTH;
        }
        else{
            heightAsp = height / LHIC_MAX_WIDTH;
            widthAsp = width / LHIC_MAX_HEIGHT;
        }
        
        targetAsp = heightAsp > widthAsp ? heightAsp : widthAsp;
        targetSize = CGSizeMake( width / targetAsp, height / targetAsp);
        
        UIImage *targetSizeImage = [LHImageCompressor scaleImage:image toTargetSize:targetSize];
        
        NSData *targetImageData = UIImageJPEGRepresentation(targetSizeImage, LHIC_PIC_QUALITY);
        return [UIImage imageWithData:targetImageData];
    }
    
    + (UIImage *)scaleImage:(UIImage *)image toTargetSize:(CGSize)targetSize{
        UIImage *sourceImage = image;
        UIGraphicsBeginImageContext(targetSize);
        UIGraphicsBeginImageContextWithOptions(targetSize, NO, 1);
        CGRect thumbnailRect = CGRectMake(0, 0, targetSize.width, targetSize.height);
        [sourceImage drawInRect:thumbnailRect];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
        
    }

@end
