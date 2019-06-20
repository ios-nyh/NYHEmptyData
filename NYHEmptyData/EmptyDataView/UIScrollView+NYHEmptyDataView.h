//
//  UIScrollView+NYHEmptyDataView.h
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/17.
//  Copyright © 2019 NYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYHEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NYHRefreshHandler)(void);

@interface UIScrollView (NYHEmptyDataView)

@property (nonatomic, strong, nullable) NYHEmptyView *emptyView;

@property (nonatomic, assign) NYHDataType dataType;

@property (nonatomic, copy) NYHRefreshHandler refreshHandler;

@end

NS_ASSUME_NONNULL_END
