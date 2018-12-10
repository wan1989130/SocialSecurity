//
//  XHLWaterLayout.h
//  TestCollectionLayout
//
//  Created by xhl on 16/6/15.
//  Copyright © 2016年 xhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHLWaterLayoutDelegate <NSObject>

@required

- (CGFloat)waterLayout:(UICollectionViewLayout *)waterLayout itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath;

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
 *  列数
 */
- (NSInteger)columnCountInWaterflowLayout:(UICollectionViewLayout*)layout;
/**
 *  collectionView内边距
 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(UICollectionViewLayout*)layout;


@end

@interface XHLWaterLayout : UICollectionViewLayout

@property (nonatomic,weak) id<XHLWaterLayoutDelegate> delegate;

@end
