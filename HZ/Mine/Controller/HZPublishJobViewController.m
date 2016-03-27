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
@interface HZPublishJobViewController ()

@end

@implementation HZPublishJobViewController

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
//    [NetworkManager manager] postRequest:myfindwork parameters:<#(id)#> completionHandler:<#^(NSURLResponse *response, id responseObject, NSError *error)completionHandler#>;
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
    
}


@end
