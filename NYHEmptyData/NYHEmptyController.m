//
//  NYHEmptyController.m
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/21.
//  Copyright © 2019 NYH. All rights reserved.
//

#import "NYHEmptyController.h"
#import "NYHListModel.h"

@interface NYHEmptyController () 

@property (nonatomic, assign) NSInteger pageSize;

@end

@implementation NYHEmptyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNaviBar];
    
    [self initData];
    
    [self setupBaseView];
    
}

- (void)setupNaviBar
{
    self.titleLabel.text = @"占位视图";
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"占位" forState:UIControlStateNormal];
}

- (void)initData
{
    
}

- (void)setupBaseView
{
    self.headerRefresh = YES;
    self.footerRefresh = YES;
    self.baseTableView.rowHeight = 88;
    
    NYHWeakSelf(self);
    self.refreshHandler = ^{
        if ([weakself.baseTableView.emptyView superview]) {
            [weakself.baseTableView.emptyView removeFromSuperview];
            weakself.baseTableView.emptyView = nil;
        }

        weakself.pageSize = 10;
        
        [weakself requestData];
    };
    
    
    [self.baseTableView.mj_header beginRefreshing];
    
    
    self.baseTableView.refreshHandler = ^{
        if ([weakself.baseTableView.emptyView superview]) {
            [weakself.baseTableView.emptyView removeFromSuperview];
            weakself.baseTableView.emptyView = nil;
        }
        
        weakself.pageSize = 10;
        
        [weakself requestData];
    };
}

- (void)rightBtnItemAction
{    
    // 占位视图
    self.baseTableView.dataType = self.dataType;
    
    self.pageSize = 0;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.baseDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NYHBaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[NYHBaseTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    NYHListModel *model = self.baseDatas[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", model.fromPlace, model.toPlace];
    
    [self configureCell:cell forBaseModel:model];

    return cell;
}

#pragma mark - Table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NYHLog(@"%@", indexPath);
}

#pragma mark - 数据加载

- (void)requestData
{
    NSString *url = @"https://lcloud.lzz56.com/api/freight/transportinfo/query";
    
    NSString *pageSize = [NSString stringWithFormat:@"%ld", self.pageSize];
    NSString *pageNum = [NSString stringWithFormat:@"%ld", self.pageNum];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageSize"] = pageSize;
    params[@"pageNum"] = pageNum;
    
    [self.view makeToastActivity:CSToastPositionCenter];
    
    __weak typeof(self) weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20.0f;
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.view hideToastActivity];
        [weakSelf.baseTableView.mj_header endRefreshing];
        [weakSelf.baseTableView.mj_footer endRefreshing];
        
        NSDictionary *results = responseObject;
        NSLog(@"success:%@", results);
        
        NSInteger code = [results[@"code"] integerValue];
        NSString *msg = results[@"msg"];
        
        if (code == 200) {
            // 数据为空直接返回
            if ([results[@"data"] isKindOfClass:[NSNull class]]) return;
            if ([results[@"data"][@"list"] isKindOfClass:[NSNull class]]) return;
            
            NSArray *dataArr = results[@"data"][@"list"];
            weakSelf.totalPage = [results[@"data"][@"pages"] integerValue];
            
            if (weakSelf.refreshStatus == NYHRefreshHeader) {
                [weakSelf.baseDatas removeAllObjects];
            }
            
            for (NSDictionary *dataDic in dataArr) {
                NYHListModel *model = [NYHListModel mj_objectWithKeyValues:dataDic];
                [weakSelf.baseDatas addObject:model];
            }
            
            [weakSelf.baseTableView reloadData];
        }
        else {
            [weakSelf.view makeToast:msg duration:2.0f position:CSToastPositionCenter];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.view hideToastActivity];
        [weakSelf.baseTableView.mj_header endRefreshing];
        [weakSelf.baseTableView.mj_footer endRefreshing];
        
        NSString *msg = [error localizedDescription];
        NSLog(@"error:%@", msg);
        [weakSelf.view makeToast:msg duration:2.0f position:CSToastPositionCenter];
    }];
}


@end

