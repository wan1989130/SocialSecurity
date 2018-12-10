//
//  XHLLabelsLayout.h
//  TestCollectionLayout
//
//  Created by xhl on 16/6/15.
//  Copyright © 2016年 xhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHLTagLabelsLayoutDelegate <NSObject>

@required

- (CGSize)tagLabels:(UICollectionViewLayout *)tagLabels indexPath:(NSIndexPath *)indexPath;

@optional
/**
 *  行间距
 */
- (CGFloat)rowMarginInWaterflowLayout:(UICollectionViewLayout*)layout;
/**
 *  列间距
 */
- (CGFloat)columnMarginInWaterflowLayout:(UICollectionViewLayout*)layout;
/**
 *  collectionView内边距
 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(UICollectionViewLayout*)layout;


@end

@interface XHLTagLabelsLayout : UICollectionViewLayout

@property (nonatomic,weak) id<XHLTagLabelsLayoutDelegate> delegate;



@end
