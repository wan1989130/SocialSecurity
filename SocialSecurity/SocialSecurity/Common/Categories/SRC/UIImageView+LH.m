//
//  UIImageView+Common.m
//  XMPPIOS
//
//  Created by 王 晓明 on 13-11-29.
//  Copyright (c) 2013年 Dawn_wdf. All rights reserved.
//

#import "UIImageView+LH.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Common)

- (void)setShoulderWithInteger:(NSInteger)integer
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    if(integer > 0)
    {
        CGRect rect = self.frame;
        float width = rect.size.width>=rect.size.height ?rect.size.height:rect.size.width;
        UIImageView *imageView = [[UIImageView alloc]init];
        //        float x = rect.size.width*2/3 + width/9;
        //        float y = 0 - width/9;
        float x = rect.size.width - width/3;
        float y = 0;
        imageView.frame = CGRectMake(x, y, width/3, width/3);
        imageView.image = [UIImage imageNamed:@"circle.png"];
        
        UILabel *countText = [[UILabel alloc]initWithFrame:imageView.frame];
        countText.textAlignment = NSTextAlignmentCenter;
        countText.textColor = [UIColor whiteColor];
        countText.backgroundColor = [UIColor clearColor];
        countText.font = [UIFont boldSystemFontOfSize:9];
        if(integer > 99)
        {
            countText.text = @"99+";
        }
        else
        {
            countText.text = [NSString stringWithFormat:@"%ld",(long)integer];
        }
        
        
        [self addSubview:imageView];
        [self addSubview:countText];
    }
    else
    {
        NSArray *subViewArray = self.subviews;
        for(int i = 0;i<[subViewArray count];i++)
        {
            UIView *tempView = [subViewArray objectAtIndex:i];
            [tempView removeFromSuperview];
        }
    }
}

@end
