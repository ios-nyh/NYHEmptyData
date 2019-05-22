//
//  UIScrollView+NYHEmptyDataView.m
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/17.
//  Copyright © 2019 NYH. All rights reserved.
//

#import "UIScrollView+NYHEmptyDataView.h"
#import <objc/runtime.h>

@implementation UIScrollView (NYHEmptyDataView)

#pragma mark - 数据类型

- (NYHDataType)dataType
{
    // OBJC_EXPORT id _Nullable objc_getAssociatedObject(id _Nonnull object, const void * _Nonnull key)
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setDataType:(NYHDataType)dataType
{
    // 移除上次占位视图
    if ([self.emptyView superview]) {
        [self.emptyView removeFromSuperview];
        self.emptyView = nil;
    }
    
    self.emptyView.dataType = dataType;
    self.emptyView.frame = self.bounds;
    [self addSubview:self.emptyView];
    
    NYHWeakSelf(self);
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself);
        make.width.height.equalTo(weakself);
    }];

    objc_setAssociatedObject(self, @selector(dataType), @(dataType), OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark - 占位视图

- (NYHEmptyView *)emptyView
{
    // 检查是否存在视图
    NYHEmptyView *nyh_emptyView = objc_getAssociatedObject(self, _cmd);
    if (nyh_emptyView == nil) {
        nyh_emptyView = [NYHEmptyView nyh_emptyView];
        
        __weak typeof(self) weakSelf = self;
        nyh_emptyView.emptyViewHandler = ^(NYHDataType dataType, UIButton * _Nonnull btn) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.refreshHandler) {
                strongSelf.refreshHandler();
            }
        };
        // 如果不存在,则添加关联
        objc_setAssociatedObject(self, @selector(emptyView), nyh_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return nyh_emptyView;
}

- (void)setEmptyView:(NYHEmptyView *)emptyView
{
    // OBJC_EXPORT void
    // objc_setAssociatedObject(id _Nonnull object, const void * _Nonnull key, id _Nullable value, objc_AssociationPolicy policy)
    objc_setAssociatedObject(self, @selector(emptyView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - 获取刷新视图的 Block

- (NYHRefreshHandler)refreshHandler
{
    NYHRefreshHandler handlerBlock = objc_getAssociatedObject(self, @selector(refreshHandler));
    
    return handlerBlock;
}

- (void)setRefreshHandler:(NYHRefreshHandler)refreshHandler
{
    objc_setAssociatedObject(self, @selector(refreshHandler), refreshHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end

