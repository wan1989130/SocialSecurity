//
//  TitleImageButton.m
//  AnimationDemo
//
//  Created by 伯明利 on 2018/6/7.
//  Copyright © 2018年 伯明利. All rights reserved.
//

#import "TitleImageButton.h"

@interface TitleImageButton ()

@property (nonatomic, strong) UIView *containView;

@property (nonatomic, strong) NSLayoutConstraint *imageWidthHeightRate;

@end

@implementation TitleImageButton {
    UILabel *_leftTitleLabel;
    UIImageView *_rightImageView;
}

- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    self.leftTitleLabel.text = leftTitle;
    [self layout];
}

- (void)setRightImage:(UIImage *)rightImage {
    _rightImage = rightImage;
    self.rightImageView.image = rightImage;
    [self layout];
    
    if (self.imageWidthHeightRate) {
        [self.rightImageView removeConstraint:self.imageWidthHeightRate];
    }
    self.imageWidthHeightRate = [NSLayoutConstraint constraintWithItem:self.rightImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.rightImageView attribute:NSLayoutAttributeHeight multiplier:rightImage.size.width/rightImage.size.height constant:0];
    [self.rightImageView addConstraint:self.imageWidthHeightRate];
}

- (UILabel *)leftTitleLabel {
    if (_leftTitleLabel == nil) {
        _leftTitleLabel = [[UILabel alloc] init];
    }
    _leftTitleLabel.font = [UIFont systemFontOfSize:14];
    _leftTitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _leftTitleLabel.textColor = [UIColor colorWithRed:(99)/255.0 green:(99)/255.0 blue:(99)/255.0 alpha:1.0];
    return _leftTitleLabel;
}

- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

- (UIView *)containView {
    if (_containView == nil) {
        _containView = [[UIView alloc] init];
        _containView.userInteractionEnabled = NO;
    }
    return _containView;
}


- (void)layout {
    if (_containView.constraints.count > 0) {
        return;
    }
    
    CGFloat padding = 4;
    
    [self addSubview:self.containView];
    self.containView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:self.containView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
                           [NSLayoutConstraint constraintWithItem:self.containView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                           [NSLayoutConstraint constraintWithItem:self.containView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:padding],
                           [NSLayoutConstraint constraintWithItem:self.containView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:padding],
                           [NSLayoutConstraint constraintWithItem:self.containView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-padding],
                           [NSLayoutConstraint constraintWithItem:self.containView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-padding]
                           ]];
    
    [self.containView addSubview:self.leftTitleLabel];
    self.leftTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containView addConstraints:@[
                                       [NSLayoutConstraint constraintWithItem:self.leftTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containView attribute:NSLayoutAttributeTop multiplier:1 constant:0],
                                       [NSLayoutConstraint constraintWithItem:self.leftTitleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.containView attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                                       [NSLayoutConstraint constraintWithItem:self.leftTitleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]
                                       ]];
    
    [self.containView addSubview:self.rightImageView];
    self.rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containView addConstraints:@[
                                       [NSLayoutConstraint constraintWithItem:self.rightImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.containView attribute:NSLayoutAttributeTop multiplier:1 constant:0],
                                       [NSLayoutConstraint constraintWithItem:self.rightImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.containView attribute:NSLayoutAttributeRight multiplier:1 constant:0],
                                       [NSLayoutConstraint constraintWithItem:self.rightImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.containView attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                                       [NSLayoutConstraint constraintWithItem:self.rightImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]
                                       ]];
    
    [self.containView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.leftTitleLabel attribute:NSLayoutAttributeRight multiplier:1 constant:padding]];
    
}

@end
