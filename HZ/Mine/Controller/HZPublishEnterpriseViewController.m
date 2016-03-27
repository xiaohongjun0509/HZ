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
@interface HZPublishEnterpriseViewController ()

@end

@implementation HZPublishEnterpriseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTableView];
}


- (void)customTableView{
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self registerCell:[HZEnterpriseCell class]];
}
- (void)loadMoreData{
    
}

- (void)refreshData{
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZEnterpriseCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HZJobHuntCell"];
    HZEnterpriseModel*model = self.dataList[indexPath.row];
    cell.model = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
