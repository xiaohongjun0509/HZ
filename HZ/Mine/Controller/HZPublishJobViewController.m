//
//  HZPublishJobViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/27.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZPublishJobViewController.h"
#import "HZJobHuntCell.h"
#import "HZJobModel.h"
#import  "HZJobDetailController.h"
@interface HZPublishJobViewController ()

@end

@implementation HZPublishJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self adjustTableView];
    [self.tableView.mj_header beginRefreshing];
}


- (void)adjustTableView{
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self registerCell:[HZJobHuntCell class]];
}
- (void)loadMoreData{
    [self refreshData];
}

- (void)refreshData{
    self.requestPage = 1;
    [self startRequest];
}

- (void)startRequest{
    NSString *userid= [[HZUserManager manager] userid];
    NSString *urlPath = self.requestOfPublish ? myfindwork : workCollect;
    WEAKSELF
    [[NetworkManager manager] postRequest:urlPath parameters:@{@"userid":userid,@"hasNext":[NSString stringWithFormat:@"%ld",self.requestPage] } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            return ;
        }
        if (self.requestPage == 1) {
            [self.dataList removeAllObjects];
        }
        NSDictionary *result = responseObject;
        NSArray *array = [HZJobModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
        if (array.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            weakSelf.requestPage++;
        }
        [weakSelf.dataList addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
 
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZJobHuntCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HZJobHuntCell"];
    HZJobModel *model = self.dataList[indexPath.row];
    cell.model = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HZJobHuntCell cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HZJobModel *model = self.dataList[indexPath.row];
    HZJobDetailController *vc = [HZJobDetailController new];
    vc.model = model;
    [self presentVC:vc];
}


@end
