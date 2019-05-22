//
//  NYHListModel.h
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/17.
//  Copyright © 2019 NYH. All rights reserved.
//

#import "NYHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYHListModel : NYHBaseModel

@property (nonatomic, copy) NSString *infoId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *fromPlace;
@property (nonatomic, copy) NSString *toPlace;
@property (nonatomic, copy) NSString *linkman;
@property (nonatomic, copy) NSString *linkphone;
@property (nonatomic, copy) NSString *linkPhone;
@property (nonatomic, copy) NSString *publishTime;

@property (nonatomic, assign) NSInteger status; // 发布状态
@property (nonatomic, copy) NSString *statusName; // 发布状态名字

@property (nonatomic, assign) NSInteger userAuthStatus; // 用户认证状态
@property (nonatomic, copy) NSString *userAuthStatusName; // 用户认证名字

@property (nonatomic, assign) NSInteger vehicleAuthStatus; // 车辆认证状态
@property (nonatomic, copy) NSString *vehicleAuthStatusName; // 车辆认证名字

@property (nonatomic, copy) NSString *tonnage; // 载重
@property (nonatomic, copy) NSString *vehicleHeight; // 车辆高度
@property (nonatomic, copy) NSString *vehicleLength; // 车辆长度
@property (nonatomic, copy) NSString *vehicleNumber; // 车牌号
@property (nonatomic, copy) NSString *vehicleTypeName; // 车辆类型
@property (nonatomic, copy) NSString *vehicleWidth; // 车辆宽度
@property (nonatomic, copy) NSString *freightOrderNum; // 成交量


@end

NS_ASSUME_NONNULL_END
