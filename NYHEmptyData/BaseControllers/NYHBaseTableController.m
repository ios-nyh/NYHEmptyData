//
//  NYHBaseTableController.m
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/21.
//  Copyright © 2019 NYH. All rights reserved.
//

#import "NYHBaseTableController.h"
#import "NYHBaseTableCell.h"
#import "NYHBaseModel.h"

@interface NYHBaseTableController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation NYHBaseTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGeneralNaviBar];
    
    [self initGeneralBaseData];
    
    [self setupGeneralBaseView];
}

- (void)setupGeneralNaviBar
{
    
}

- (void)initGeneralBaseData
{
    self.baseDatas = [NSMutableArray array];
    
    // 默认请求第一页
    self.pageNum = 1;
}

- (void)setupGeneralBaseView
{
    self.baseTableView = [[UITableView alloc] init];
    self.baseTableView.dataSource = self;
    self.baseTableView.delegate = self;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.baseTableView];
    
    self.baseTableView.tableFooterView = [[UIView alloc] init];
    
    self.baseTableView.estimatedRowHeight = 0;
    self.baseTableView.estimatedSectionHeaderHeight = 0;
    self.baseTableView.estimatedSectionFooterHeight = 0;
    
    NYHWeakSelf(self);
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(weakself.view);
    }];
}

- (void)setHeaderRefresh:(BOOL)headerRefresh
{
    [self addHeaderRefreshing];
}

- (void)setFooterRefresh:(BOOL)footerRefresh
{
    [self addFooterRefreshing];
}

#pragma mark - 上拉刷新和下拉加载
// 上拉刷新
- (void)addHeaderRefreshing
{
    NYHWeakSelf(self);
    self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.pageNum = 1;
        [weakself loadNewData];
    }];
}

// 下拉加载更多
- (void)addFooterRefreshing
{
    NYHWeakSelf(self);
    self.baseTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakself.pageNum++;
        if (weakself.pageNum <= weakself.totalPage) {
            [weakself loadMoreData];
        }
        else {
            [weakself.baseTableView.mj_footer endRefreshing];
            [weakself.baseTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

// 刷新数据
- (void)loadNewData
{
    self.refreshStatus = NYHRefreshHeader;
    
    self.refreshHandler();
}

// 加载更多
- (void)loadMoreData
{
    self.refreshStatus = NYHRefreshFooter;
    
    self.refreshHandler();
}

- (void)configureCell:(NYHBaseTableCell *)cell forBaseModel:(NYHBaseModel *)baseModel;
{
    cell.baseModel = baseModel;
    
    cell.detailTextLabel.text = @"啊哈哈";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.baseDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    return cell;
}

#pragma mark - Table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end

