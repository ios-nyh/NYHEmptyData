//
//  NYHBaseTableController.h
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/21.
//  Copyright © 2019 NYH. All rights reserved.
//

#import "NYHBaseController.h"
@class NYHBaseModel;
@class NYHBaseTableCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^NYHRefreshHandler)(void);

@interface NYHBaseTableController : NYHBaseController

@property (nonatomic, strong) UITableView *baseTableView;
@property (nonatomic, strong) id baseTableViewCell;

@property (nonatomic, assign) BOOL headerRefresh;
@property (nonatomic, assign) BOOL footerRefresh;

@property (nonatomic, copy) NYHRefreshHandler refreshHandler;

@property (nonatomic, strong) NSMutableArray *baseDatas;

@property (nonatomic, assign) NYHRefreshStatus refreshStatus;

@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger totalPage;


- (void)configureCell:(NYHBaseTableCell *)cell forBaseModel:(NYHBaseModel *)baseModel;


@end


NS_ASSUME_NONNULL_END

