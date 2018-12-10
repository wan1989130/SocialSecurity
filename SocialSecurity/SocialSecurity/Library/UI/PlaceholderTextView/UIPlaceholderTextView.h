//
//  UIPlaceholderTextView.h
//  XiaoLvOA
//
//  Created by C on 16/9/21.
//  Copyright © 2016年 fuweihan00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceholderTextView : UITextView
@property(nonatomic, strong) NSString *placeholder;     //占位符

-(void)addObserver;//添加通知
-(void)removeobserver;//移除通知
@end
