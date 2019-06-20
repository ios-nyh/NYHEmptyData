//
//  NYHBaseController.m
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/21.
//  Copyright © 2019 NYH. All rights reserved.
//

#import "NYHBaseController.h"
#import "IQKeyboardManager.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface NYHBaseController ()

@end

@implementation NYHBaseController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addObserver];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self removeObserver];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupBaseNaviBar];
    
    [self initBaseData];
}


- (void)setupBaseNaviBar
{
    // 设置全局View背景色
    self.view.backgroundColor = [UIColor whiteColor];
    // 修改系统导航栏背景
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    // 去除导航栏底部横线(官方用法)
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    // 禁止系统自动调整ScrollView的Insets,手动适应(iOS7以前)
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    // 从导航栏下开始布局
    // self.edgesForExtendedLayout = UIRectEdgeNone;
    // 导航栏不透明,从导航栏下开始布局
    self.navigationController.navigationBar.translucent = NO;
    // 工具栏不透明
    self.tabBarController.tabBar.translucent = NO;
    
    // 自定义导航栏Item
    [self customNaviBarItem];
    
    // 第三方公共设置
    [self setupThirdSetting];
}


/**
 自定义导航栏Item
 */
- (void)customNaviBarItem
{
    // 左侧按钮,默认不隐藏
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [self.leftBtn setImage:[UIImage imageNamed:@"navi_back_white.png"] forState:UIControlStateNormal];
    self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self.leftBtn addTarget:self action:@selector(leftBtnItemAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = self.leftBtnItem;
    
    // 右侧按钮,默认隐藏
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [self.rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    [self.rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    [self.rightBtn addTarget:self action:@selector(rightBtnItemAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.rightBtn.hidden = YES;
    self.rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = self.rightBtnItem;
    
    // 中间标题,默认不隐藏
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.leftBtn.frame), 0, [UIScreen mainScreen].bounds.size.width-self.leftBtn.mj_w-self.rightBtn.mj_w, 44);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:18.f];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.titleLabel;
}


/**
 初始化全局常用数据
 */
- (void)initBaseData
{
    
}

#pragma mark - 按钮处理事件
/**
 自定义导航左侧按钮事件
 */
- (void)leftBtnItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 自定义导航右侧按钮事件
 */
- (void)rightBtnItemAction
{
    
}

/**
 第三方公共设置
 */
- (void)setupThirdSetting
{
    // 第三方键盘控制
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].layoutIfNeededOnUpdate = NO;
}

#pragma mark - 处理键盘回收
/**
 点击空白处,收回键盘
 */
- (void)setupForDismissKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    
    NSOperationQueue *mainQuene = [NSOperationQueue mainQueue];

    __weak typeof(self) weakSelf = self;
    
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

#pragma mark - 注册监听
/**
 添加观察者
 */
- (void)addObserver
{
    // 点击空白处,收回键盘
    [self setupForDismissKeyboard];
    
    // 监听输入框文本改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextFieldText:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

/**
 文本改变
 
 @param noti 通知
 */
- (void)changeTextFieldText:(NSNotification *)noti
{
    
}

/**
 获取主窗体
 
 @return 主窗体
 */
- (UIWindow *)getMainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)]) {
        return [app.delegate window];
    }
    else {
        return [app keyWindow];
    }
}




@end

