//
//  NYHEnum.h
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/21.
//  Copyright © 2019 NYH. All rights reserved.
//

#ifndef NYHEnum_h
#define NYHEnum_h


/**
 刷新方式
 
 - NYHRefreshHeader: 头部刷新
 - NYHRefreshFooter: 尾部刷新
 */
typedef NS_ENUM(NSInteger, NYHRefreshStatus) {
    NYHRefreshHeader = 1,
    NYHRefreshFooter = 2,
};


/**
 数据加载类型
 
 - NYHNoDataType: 没有数据
 - NYHNoNetworkType: 没有网络
 - NYHRequestErrorType: 请求失败
 */
typedef enum : NSInteger {
    NYHNoDataType,
    NYHNoNetworkType,
    NYHRequestErrorType,
} NYHDataType;


#endif /* NYHEnum_h */

