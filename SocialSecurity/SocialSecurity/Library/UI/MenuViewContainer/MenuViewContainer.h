//
//  MenuViewContainer.h
//  EEDOPHONE
//
//  Created by zhangrongbing on 16/6/22.
//  Copyright © 2016年 HuiHai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewContainer;

@protocol MenuViewContainerDelegate <NSObject>

@required
-(NSInteger)menuViewContainer:(MenuViewContainer*)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell*)menuViewContainer:(MenuViewContainer*)menu tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath;

@optional
-(void)menuViewContainer:(MenuViewContainer*)menu tableView:(UITableView*)tableView index:(NSInteger) index;
-(CGFloat)menuViewContainer:(MenuViewContainer*)menu tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;

-(void)menuViewContainer:(MenuViewContainer*)menu tableView:(UITableView*)tableView didSelectRowIndexPath:(NSIndexPath*)indexPath;

-(void)menuViewContainer:(MenuViewContainer*)menu tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath;

-(void)menuViewContainer:(MenuViewContainer*)menu tableView:(UITableView*)tableView didEndDiplayingCell:(UITableViewCell*)cell forrowAtIndexPath:(NSIndexPath*)indexPath;
@end

@interface MenuViewContainer : UIView<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray* titleArr;//标题
@property(nonatomic, strong) NSArray* itemButtonArr;//菜单子项的集合
@property(nonatomic)NSInteger itemVisibleCount;//可见数量
@property(nonatomic) NSInteger maxTitleLength;//标题最大字符数量
@property(nonatomic)NSInteger curIndex;//默认显示第几个

@property(nonatomic, strong) id<MenuViewContainerDelegate> delegate;

- (void)reloadTableViews;
-(void)reloadData;
-(void)reloadDataNormal;
@end
