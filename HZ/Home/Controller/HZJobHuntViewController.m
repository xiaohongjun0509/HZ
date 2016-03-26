//
//  HZJobHuntViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZJobHuntViewController.h"
#import "HZJobHuntCell.h"
#import "HZJobModel.h"
@interface HZJobHuntViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *cityName;
@end

@implementation HZJobHuntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.job = nil;
    self.area = nil;
    self.salary = nil;
    self.cityName = @"北京";
    [self registerCell:[HZJobHuntCell class]];
    [self attachBackButton];
    [self.tableView.mj_header beginRefreshing];
}

- (void)refreshData{
    NSString *urlStr = [NSString stringWithFormat:@"%@?area=%@&hasNext=1",findwork,self.cityName];
    
    [self.dataList removeAllObjects];
    WEAKSELF
    [[NetworkManager manager] startRequest:urlStr completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if(!error){
            NSDictionary *dict = responseObject;
            NSArray *dataList = [HZJobModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            [weakSelf.dataList addObjectsFromArray:dataList];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        }
    }];
    
}

-(void)loadMoreData{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZJobHuntCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZJobHuntCell"];
    HZJobModel *model = self.dataList[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HZJobHuntCell cellHeight];
}
@end
