//
//  TitleImageButton.h
//  AnimationDemo
//
//  Created by 伯明利 on 2018/6/7.
//  Copyright © 2018年 伯明利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleImageButton : UIButton

@property (nonatomic, copy) IBInspectable NSString *leftTitle;

@property (nonatomic, strong) IBInspectable UIImage *rightImage;

@property (nonatomic, strong, readonly) UILabel *leftTitleLabel;

@property (nonatomic, strong, readonly) UIImageView *rightImageView;

@end
