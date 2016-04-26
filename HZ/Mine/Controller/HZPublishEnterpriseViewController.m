//
//  HZPublishEnterpriseViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/27.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZPublishEnterpriseViewController.h"
#import "HZEnterpriseCell.h"
#import "HZEnterpriseModel.h"
#import "MbPaser.h"
#import "MbEnterpriseTableViewCell.h"
#import "MbEnterpriseDetailViewController.h"
@interface HZPublishEnterpriseViewController ()

@end

@implementation HZPublishEnterpriseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self adjustTableView];
    [self.tableView.mj_header beginRefreshing];
}


- (void)adjustTableView{
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self.tableView registerClass:[MbEnterpriseTableViewCell class] forCellReuseIdentifier:@"MbEnterpriseTableViewCell"];
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
    NSString *urlPath = self.requestOfPublish ? myenterpriseList: qiyeCollect;
    WEAKSELF
    [[NetworkManager manager] postRequest:urlPath parameters:@{@"userid":userid,@"hasNext":[NSString stringWithFormat:@"%ld",self.requestPage] } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            return ;
        }
        if (self.requestPage == 1) {
            [self.dataList removeAllObjects];
        }
        NSDictionary *result = responseObject;
        NSArray *array = [MbPaser paserEnterpriseByDic:result];
//        NSArray *array = [HZEnterpriseModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
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
    MbEnterpriseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MbEnterpriseTableViewCell"];
    MbUserInfo *model = self.dataList[indexPath.row];
    [cell loadContent:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MbUserInfo *model = self.dataList[indexPath.row];
    MbEnterpriseDetailViewController *controller = [[MbEnterpriseDetailViewController alloc]init];
    controller.info = model;
    [self presentVC:controller];
}

@end
