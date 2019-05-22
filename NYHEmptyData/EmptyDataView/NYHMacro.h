//
//  NYHMacro.h
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/17.
//  Copyright © 2019 NYH. All rights reserved.
//

#ifndef NYHMacro_h
#define NYHMacro_h

// 物理屏幕大小
#define NYHWIDTH  [UIScreen mainScreen].bounds.size.width
#define NYHHEIGHT [UIScreen mainScreen].bounds.size.height

// 控件位置
#define NYHMinX(v) CGRectGetMinX((v).frame)
#define NYHMinY(v) CGRectGetMinY((v).frame)

#define NYHMidX(v) CGRectGetMidX((v).frame)
#define NYHMidY(v) CGRectGetMidY((v).frame)

#define NYHMaxX(v) CGRectGetMaxX((v).frame)
#define NYHMaxY(v) CGRectGetMaxY((v).frame)


// 弱引用
#define NYHWeakSelf(type)    __weak   typeof(type) weak##type = type;
// 强引用
#define NYHStrongSelf(type)  __strong typeof(type) strong##type = type;


// 调试输出
#ifdef DEBUG

// iOS10之前
// #define NYHLog(fmt, ...) {NSLog((@"%s [Line %d]" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}

// iOS10之后
#define AppName [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]
#define AppFunc [[NSString stringWithUTF8String:__PRETTY_FUNCTION__] lastPathComponent]

#define NYHLog(fmt, ...) { \
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; \
                            [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"]; \
                            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]]; \
                           \
                            fprintf(stderr,"%s %s %s [Line %d] %s\n",[dateString UTF8String], [AppName UTF8String], [AppFunc UTF8String], __LINE__, [[NSString stringWithFormat:fmt, ##__VA_ARGS__] UTF8String]); \
                          }

#else

#define NYHLog(...)

#endif


#pragma mark - 颜色值
// 16进制颜色计算
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// RGB颜色计算
#define UIColorWithRGB(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

// 不可点击颜色
#define kUnclickableColor UIColorFromRGB(0xe7e7e7)
// 可点击颜色
#define kClickableColor   UIColorFromRGB(0x35cc97)


#pragma mark - 屏幕判断

#define iPhone4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXr    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXsMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)


#pragma mark - iOS系统判断

#define NYHIOS9  ([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending)
#define NYHIOS10  ([[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending)
#define NYHIOS11  ([[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending)
#define NYHIOS12  ([[[UIDevice currentDevice] systemVersion] compare:@"12.0" options:NSNumericSearch] != NSOrderedAscending)


// 字体设置
#define NYHSystemFont     [UIFont systemFontOfSize:14.0f]
#define NYHFont(size)     [UIFont systemFontOfSize:size]


#pragma mark - 加载图片
#define NYHLOADIMG(file, ext)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]
#define NYHIMG(A)                [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
#define NYHIMGNAMED(imageName)   [UIImage imageNamed:imageName]


// Alert 系统样式提示
#define LZZALERT(msg)         UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction  *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];\
[alertVC addAction:alertAction];\
[self presentViewController:alertVC animated:YES completion:^{}];\


#pragma mark - 系统单例

#define NYHUSERDEFAULTS      [NSUserDefaults standardUserDefaults]
#define NYHAPPLICATION       [UIApplication sharedApplication]
#define NYHFILEMANAGER       [NSFileManager defaultManager]
#define NYHAPPDELEGATE       (AppDelegate *)[[UIApplication sharedApplication] delegate]


#pragma mark - 常量宏

#define kStatusBarHeight     (CGFloat)((iPhoneX | iPhoneXr | iPhoneXsMax) ? (44) : (20))
#define kTopHeigth           (CGFloat)((iPhoneX | iPhoneXr | iPhoneXsMax) ? (88) : (64))
#define kTabBarHeight        (CGFloat)((iPhoneX | iPhoneXr | iPhoneXsMax) ? (49 + 34) : (49))
// 导航栏高度
#define kNaviBarHeight       (44)
// 顶部安全区域远离高度
#define kTopBarSafeHeight    (CGFloat)((iPhoneX | iPhoneXr | iPhoneXsMax) ? (44) : (0))
// 底部安全区域远离高度
#define kBottomSafeHeight    (CGFloat)((iPhoneX | iPhoneXr | iPhoneXsMax) ? (34) : (0))

// 弧度转角度
#define RADIANS_TO_DEGREES(x) ((x)/M_PI*180.0)
// 角度转弧度
#define DEGREES_TO_RADIANS(x) ((x)/180.0*M_PI)


#endif /* NYHMacro_h */

