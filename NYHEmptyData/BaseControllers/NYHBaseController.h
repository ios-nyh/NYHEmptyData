//
//  NYHBaseController.h
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/21.
//  Copyright © 2019 NYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYHBaseController : UIViewController

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIBarButtonItem *leftBtnItem;
@property (nonatomic, strong) UIBarButtonItem *rightBtnItem;
@property (nonatomic, strong) UILabel *titleLabel;


/**
 自定义导航左侧按钮事件
 */
- (void)leftBtnItemAction;

/**
 自定义导航右侧按钮事件
 */
- (void)rightBtnItemAction;

/**
 文本改变
 
 @param noti 通知
 */
- (void)changeTextFieldText:(NSNotification *)noti;

/**
 获取主窗体
 
 @return 主窗体
 */
- (UIWindow *)getMainWindow;


@end

NS_ASSUME_NONNULL_END
