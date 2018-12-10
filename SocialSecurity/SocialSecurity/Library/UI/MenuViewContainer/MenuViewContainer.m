//
//  MenuViewContainer.m
//  EEDOPHONE
//
//  Created by zhangrongbing on 16/6/22.
//  Copyright © 2016年 HuiHai. All rights reserved.
//

#import "MenuViewContainer.h"
#import "UIColor+LH.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeader.h"

static CGFloat SliderViewHeight = 2;

@implementation MenuViewContainer{
    UIView* sliderView;//滑块视图
    UIButton* curItemButton;//记录当前选择的菜单项
    CGFloat itemButtonWidth;//菜单子项的宽度
    
    UIScrollView* menuScrollView;//菜单滑动视图
    UIScrollView* contentScrollView;//主体滑动视图
}

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}



- (void)awakeFromNib{
    [super awakeFromNib];
   [self commonInit];
}


- (CGFloat)getMenuHeight{
    return  44;
}

- (void)commonInit{
    self.backgroundColor = [UIColor clearColor];
    
    menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:menuScrollView];
    menuScrollView.showsVerticalScrollIndicator = NO;
    menuScrollView.showsHorizontalScrollIndicator = NO;
    menuScrollView.backgroundColor = [UIColor whiteColor];
    menuScrollView.tag = 0;
    menuScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:menuScrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:menuScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:menuScrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:menuScrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:menuScrollView attribute:NSLayoutAttributeHeight multiplier:0 constant:[self getMenuHeight]]];
    
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:contentScrollView];
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate = self;
    contentScrollView.tag = 1;
    contentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentScrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:menuScrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentScrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    //初始化值
    _maxTitleLength = NSIntegerMax;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if ([_titleArr count] == 0) {
        return;
    }
    
    if (_titleArr.count > 0 && menuScrollView.subviews.count <= 0){
        float x = 0;
        float y = 0;
        float width = self.frame.size.width/_itemVisibleCount;
        itemButtonWidth = width;
        //    float height = CGRectGetHeight(menuScrollView.frame);
        float height = [self getMenuHeight];
        
        //加入滑块的滑到(滑块滑动区)
        UIView* slipwayView = [[UIView alloc] initWithFrame:CGRectMake(0, height-SliderViewHeight, _titleArr.count* width, SliderViewHeight)];
            slipwayView.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
        
        NSMutableArray* temp_itemButtonArr = @[].mutableCopy;
        //设置菜单项
        for (int i = 0; i < [_titleArr count]; i++) {
            x = width*i;
            
                UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
                NSString* titleStr = _titleArr[i];
                if (titleStr.length > _maxTitleLength) {
                    titleStr = [titleStr substringWithRange:NSMakeRange(0, _maxTitleLength)];
                }
                [btn setTitle:titleStr forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:13.5f]];
                btn.tag = i;
                [btn addTarget:self action:@selector(pressMenuItemButton:) forControlEvents:UIControlEventTouchUpInside];
                
                [btn setTitleColor:[UIColor colorWithHexString:@"b4b4b4"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithHexString:@"14b4ff"] forState:UIControlStateHighlighted];
                [btn setTitleColor:[UIColor colorWithHexString:@"14b4ff"] forState:UIControlStateSelected];
                
                if (i == 0) {
                    [btn setSelected:YES];
                    curItemButton = btn;
                    //设置滑块视图
                    sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, SliderViewHeight)];
                    sliderView.backgroundColor = [UIColor colorWithHexString:@"12b4fd"];
                    
                    [slipwayView addSubview:sliderView];
                }
            
                [temp_itemButtonArr addObject:btn];
                _itemButtonArr = temp_itemButtonArr;
                [menuScrollView addSubview:btn];
                
        }
        
        menuScrollView.contentSize = CGSizeMake(_titleArr.count* width, [self getMenuHeight]);
        [menuScrollView addSubview:slipwayView];
        
        //设置UITableView
        for (int i = 0; i < _titleArr.count; i++) {
            float x = i*self.frame.size.width;
            CGRect rect = contentScrollView.bounds;
            rect.origin.x = x;
            
            UITableView* tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.001)];
            tableView.tableHeaderView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.001)];
            
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            
            if (_delegate && [_delegate respondsToSelector:@selector(menuViewContainer:tableView:index:)]) {
                [_delegate menuViewContainer:self tableView:tableView index:i];
            }
            tableView.tag = i;
            tableView.delegate = self;
            tableView.dataSource = self;

            
            [contentScrollView addSubview:tableView];
        }
        contentScrollView.contentSize = CGSizeMake(_titleArr.count*self.frame.size.width, CGRectGetHeight(contentScrollView.bounds));
        if (_curIndex != 0) {
            _curIndex -= 1;
            [self moveSliderViewX:_curIndex*width];
            [contentScrollView scrollRectToVisible:CGRectMake(_curIndex*self.frame.size.width, 0, self.frame.size.width, CGRectGetHeight(contentScrollView.bounds)) animated:NO];
            [curItemButton setSelected:!curItemButton.isSelected];
            UIButton* btn = _itemButtonArr[_curIndex];
            [btn setSelected:YES];
            curItemButton = btn;
        }

    }
}


-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    if ([titleArr count] == 0) {
        return;
    }
    if (_itemVisibleCount == 0) {
        _itemVisibleCount = titleArr.count;
    }
}

-(void)setCurIndex:(NSInteger)curIndex{
    _curIndex = curIndex;
    if (!_titleArr) {
        return;
    }
    if (_curIndex != 0) {
        _curIndex -= 1;
        float width = self.frame.size.width/_itemVisibleCount;
        [self moveSliderViewX:_curIndex*width];
        [contentScrollView scrollRectToVisible:CGRectMake(_curIndex*self.frame.size.width, 0, self.frame.size.width, CGRectGetHeight(contentScrollView.bounds)) animated:NO];
        [curItemButton setSelected:!curItemButton.isSelected];
        UIButton* btn = _itemButtonArr[_curIndex];
        [btn setSelected:YES];
        curItemButton = btn;
    }
}


-(void)pressMenuItemButton:(UIButton*)btn{
    [curItemButton setSelected:NO];
    [btn setSelected:YES];
    curItemButton = btn;
    //移动contentScrollView
    [contentScrollView scrollRectToVisible:CGRectMake(btn.tag*self.frame.size.width, 0, self.frame.size.width, CGRectGetHeight(contentScrollView.bounds)) animated:YES];
    
    //菜单项移到此处
    if (btn.tag >= _itemVisibleCount/2) {
        [menuScrollView scrollRectToVisible:CGRectMake(btn.frame.origin.x - (self.frame.size.width-btn.frame.size.width)/2, 0, self.frame.size.width, [self getMenuHeight]) animated:YES];
    }else{
        [menuScrollView scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width, [self getMenuHeight]) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    if (scrollView.tag == 0) {
    }else{
        //移动滑块
        float offset = scrollView.contentOffset.x;
        offset = offset/_itemVisibleCount;
        [self moveSliderViewX:offset];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    if (scrollView.tag == 0) {
        
    }else{
        NSInteger pageNo = [self itemIndexOfContentOffset:scrollView.contentOffset];
        if (pageNo >= _itemButtonArr.count) {
            return;
        }
        UIButton* btn = _itemButtonArr[pageNo];
        [curItemButton setSelected:NO];
        [btn setSelected:YES];
        curItemButton = btn;
        //菜单项移到此处
        if (pageNo >= _itemVisibleCount/2.0f) {
            [menuScrollView scrollRectToVisible:CGRectMake(btn.frame.origin.x - (self.frame.size.width-btn.frame.size.width)/2, 0, self.frame.size.width, [self getMenuHeight]) animated:YES];
        }else{
            [menuScrollView scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width, [self getMenuHeight]) animated:YES];
        }
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_delegate menuViewContainer:self tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_delegate menuViewContainer:self tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(menuViewContainer:tableView:heightForRowAtIndexPath:)]) {
        return [_delegate menuViewContainer:self tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 44.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(menuViewContainer:tableView:didSelectRowIndexPath:)]) {
        [_delegate menuViewContainer:self tableView:tableView didSelectRowIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(menuViewContainer:tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [_delegate menuViewContainer:self tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_delegate && [_delegate respondsToSelector:@selector(menuViewContainer:tableView:didEndDiplayingCell:forrowAtIndexPath:)]){
        [_delegate menuViewContainer:self tableView:tableView didEndDiplayingCell:cell forrowAtIndexPath:indexPath];
    }
}

#pragma mark - Public

//移动滑块
-(void)moveSliderViewX:(float)x{
    CGRect rect = sliderView.frame;
    rect.origin.x = x;
    sliderView.frame = rect;
}

//根据contentScrollView偏移量来计算当前是第几个菜单项
-(NSInteger)itemIndexOfContentOffset:(CGPoint)point{
     return ceilf(point.x/self.frame.size.width);
}


- (void)reloadTableViews{
    for (UIView* childView in [contentScrollView subviews]) {
        if ([childView isKindOfClass:[UITableView class]]) {
            UITableView* tableView = (UITableView*)childView;
            [tableView reloadData];
        }
    }

}
-(void)reloadData{
    [self layoutSubviews];
    for (UIView* childView in [contentScrollView subviews]) {
        if ([childView isKindOfClass:[UITableView class]]) {
            UITableView* tableView = (UITableView*)childView;
            if (tableView.mj_header) {
                [tableView.mj_header beginRefreshing];
            }else{
                if (_delegate && [_delegate respondsToSelector:@selector(menuViewContainer:tableView:index:)]) {
                    [_delegate menuViewContainer:self tableView:tableView index:tableView.tag];
                    [tableView reloadData];
                }
            }
        }
    }
}

-(void)reloadDataNormal{
    for (UIView* childView in [contentScrollView subviews]) {
        if ([childView isKindOfClass:[UITableView class]]) {
            UITableView* tableView = (UITableView*)childView;
            if (_delegate && [_delegate respondsToSelector:@selector(menuViewContainer:tableView:index:)]) {
                [_delegate menuViewContainer:self tableView:tableView index:tableView.tag];
                [tableView reloadData];
            }
        }
    }
}
@end
