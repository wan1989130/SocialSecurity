//
//  UIAlertView+Block.m
//  BlockAlertViewDemo
//
//  Created by 琪 on 14-5-6.
//  Copyright (c) 2014年 liqi. All rights reserved.
//

#import "UIAlertView+LH.h"

@implementation UIAlertView (LH)

static AlertViewCompleteBlock _completedBlock;
static AlertViewCancelBlock _cancelBlock;



#pragma mark - UIAlertView showing Methods


+ (void)showAlertWithTitle:(NSString *)title {
    [UIAlertView showAlertWithTitle:title msg:nil buttonTitle:NSLocalizedString(@"确定", @"ok")];
}

+ (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg {
    [UIAlertView showAlertWithTitle:title msg:msg buttonTitle:NSLocalizedString(@"确定", @"ok")];
}

+ (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg buttonTitle:(NSString *)btnTitle {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:btnTitle otherButtonTitles:nil];
    [av show];
}

+ (void) showAlertWithTitle:(NSString *)title CompletionBlock:(AlertViewCompleteBlock)completionBlock{
    [UIAlertView showAlertViewWithTitle:title message:nil cancelButtonTitle:nil otherButtonTitles:@[NSLocalizedString(@"确定", @"ok")] onCompleteBlock:completionBlock onCancle:nil];
}

+ (void) showAlertWithTitle:(NSString *)title msg:(NSString *)msg CompletionBlock:(AlertViewCompleteBlock)completionBlock{
    [UIAlertView showAlertViewWithTitle:title message:msg cancelButtonTitle:nil otherButtonTitles:@[NSLocalizedString(@"确定", @"ok")] onCompleteBlock:completionBlock onCancle:nil];
}

+ (void) showAlertWithTitle:(NSString *)title msg:(NSString *)msg buttonTitle:(NSString *)btnTitle CompletionBlock:(AlertViewCompleteBlock)completionBlock{
    [UIAlertView showAlertViewWithTitle:title message:msg cancelButtonTitle:nil otherButtonTitles:@[btnTitle] onCompleteBlock:completionBlock onCancle:nil];
}


+ (void)showYesNoAlertWithTitle:(NSString *)title msg:(NSString *)msg delegate:(id)delegate yesButtonTitle:(NSString *)yesButtontitle noButtonTitle:(NSString *)noButtonTitle viewTag:(NSInteger)tag {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:noButtonTitle otherButtonTitles:yesButtontitle, nil];
    av.tag = tag;
    [av show];
}

+ (void)showYesNoAlertWithTitle:(NSString *)title delegate:(id)delegate viewTag:(NSInteger)tag {
    [UIAlertView showYesNoAlertWithTitle:title msg:nil delegate:delegate yesButtonTitle:NSLocalizedString(@"确定", @"ok") noButtonTitle:NSLocalizedString(@"取消", @"cancel") viewTag:tag];
}

+ (void)showYesNoAlertWithTitle:(NSString *)title msg:(NSString *)msg delegate:(id)delegate viewTag:(NSInteger)tag {
    [UIAlertView showYesNoAlertWithTitle:title msg:msg delegate:delegate yesButtonTitle:NSLocalizedString(@"确定", @"ok") noButtonTitle:NSLocalizedString(@"取消", @"cancel") viewTag:tag];
}

#pragma mark -
#pragma mark tip message

+ (void)showTipAlertWithTitle:(NSString *)title {
    OLGhostAlertView *alertView = [[OLGhostAlertView alloc] initWithTitle:title message:nil timeout:2.0 dismissible:NO];
    alertView.position = OLGhostAlertViewPositionBottom;
    alertView.completionBlock = ^(void) { };
    [alertView show];
}

+ (void)showTipAlertWithTitle:(NSString *)title Position:(OLGhostAlertViewPosition)_position
{
    OLGhostAlertView *alertView = [[OLGhostAlertView alloc] initWithTitle:title message:nil timeout:2.0 dismissible:NO];
    alertView.position = _position;
    alertView.completionBlock = ^(void) { };
    [alertView show];
}

+(UIAlertView *)showAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                     cancelButtonTitle:(NSString *)cancelButtonTitle
                     otherButtonTitles:(NSArray *)OtherButtons
                       onCompleteBlock:(AlertViewCompleteBlock) completed
                              onCancle:(AlertViewCancelBlock)cancelled{
    
    _cancelBlock = [cancelled copy];
    _completedBlock = [completed copy];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:[self self] cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    for (NSString *buttonTitle in OtherButtons) {
        [alert addButtonWithTitle:buttonTitle];
    }
    [alert show];
    return alert;
}

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        _cancelBlock();
    }
    else{
        _completedBlock(buttonIndex);
    }
}

@end
