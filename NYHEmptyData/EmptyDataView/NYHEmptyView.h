//
//  NYHEmptyView.h
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/17.
//  Copyright © 2019 NYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NYHEmptyViewHandler)(NYHDataType dataType, UIButton * btn);

@interface NYHEmptyView : UIView

@property (nonatomic, assign) NYHDataType dataType;

@property (nonatomic, copy) NYHEmptyViewHandler emptyViewHandler;

+ (instancetype)sharedEmptyView;

+ (NYHEmptyView *)nyh_emptyView;

@end

NS_ASSUME_NONNULL_END
