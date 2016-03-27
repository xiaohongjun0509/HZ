//
//  HZPublishResumeViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/27.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZPublishResumeViewController.h"
#import "HZJobHuntCell.h"
#import "HZResumeModel.h"
@interface HZPublishResumeViewController ()

@end

@implementation HZPublishResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTableView];
}


- (void)customTableView{
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self registerCell:[HZJobHuntCell class]];
}
- (void)loadMoreData{
    
}

- (void)refreshData{
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZJobHuntCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HZJobHuntCell"];
    HZResumeModel *model = self.dataList[indexPath.row];
    cell.resumeModel = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HZJobHuntCell cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
