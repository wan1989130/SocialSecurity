//
//  UIAlertView+Block.h
//  BlockAlertViewDemo
//
//  Created by 琪 on 14-5-6.
//  Copyright (c) 2014年 liqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OLGhostAlertView.h"

typedef void (^AlertViewCompleteBlock) (NSInteger buttonIndex);
typedef void (^AlertViewCancelBlock)();

@interface UIAlertView (LH)
//---------------------------------------------------------------
// 消息对话框
+ (void) showAlertWithTitle:(NSString *)title;
+ (void) showAlertWithTitle:(NSString *)title msg:(NSString *)msg;
+ (void) showAlertWithTitle:(NSString *)title msg:(NSString *)msg buttonTitle:(NSString *)btnTitle;

+ (void) showAlertWithTitle:(NSString *)title CompletionBlock:(AlertViewCompleteBlock)completionBlock;
+ (void) showAlertWithTitle:(NSString *)title msg:(NSString *)msg CompletionBlock:(AlertViewCompleteBlock)completionBlock;
+ (void) showAlertWithTitle:(NSString *)title msg:(NSString *)msg buttonTitle:(NSString *)btnTitle CompletionBlock:(AlertViewCompleteBlock)completionBlock;

+ (void)showYesNoAlertWithTitle:(NSString *)title delegate:(id)delegate viewTag:(NSInteger)tag;
+ (void)showYesNoAlertWithTitle:(NSString *)title msg:(NSString *)msg delegate:(id)delegate viewTag:(NSInteger)tag;
+ (void)showYesNoAlertWithTitle:(NSString *)title msg:(NSString *)msg delegate:(id)delegate yesButtonTitle:(NSString *)yesButtontitle noButtonTitle:(NSString *)noButtonTitle viewTag:(NSInteger)tag;

//---------------------------------------------------------------
// 提示对话框
+ (void)showTipAlertWithTitle:(NSString *)title;
+ (void)showTipAlertWithTitle:(NSString *)title Position:(OLGhostAlertViewPosition)_position;

+(UIAlertView *)showAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                     cancelButtonTitle:(NSString *)cancelButtonTitle
                     otherButtonTitles:(NSArray *)OtherButtons
                       onCompleteBlock:(AlertViewCompleteBlock) completed
                              onCancle:(AlertViewCancelBlock)cancelled;
@end

