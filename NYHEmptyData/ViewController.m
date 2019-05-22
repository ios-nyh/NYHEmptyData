//
//  ViewController.m
//  NYHEmptyData
//
//  Created by greenspiderios on 2019/5/17.
//  Copyright © 2019 NYH. All rights reserved.
//

#import "ViewController.h"
#import "NYHEmptyController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNaviBar];
    
    [self initData];
    
    [self setupBaseView];
    
}

- (void)setupNaviBar
{
    self.titleLabel.text = @"测试";
    self.leftBtn.hidden = YES;
}

- (void)initData
{
    self.datas = @[@"NYHNoDataType", @"NYHNoNetworkType", @"NYHRequestErrorType"];
}

- (void)setupBaseView
{
    self.tableView.rowHeight = 88;
    self.tableView.tableFooterView = [[UIView alloc] init];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.datas[indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NYHEmptyController *emptyVC = [[NYHEmptyController alloc] init];
    emptyVC.dataType = indexPath.row;
    [self.navigationController pushViewController:emptyVC animated:YES];
}


@end

