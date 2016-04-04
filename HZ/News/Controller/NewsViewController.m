//
//  NewsViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "NewsViewController.h"
#import "HZNewsTableViewCell.h"
@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    [self.tableView registerClass:[HZNewsTableViewCell class] forCellReuseIdentifier:@"HZNewsTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.mj_footer = nil;
    self.tableView.mj_header = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    HZNewsTableViewCell* cell = [tableView  dequeueReusableCellWithIdentifier:@"HZNewsTableViewCell"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [HZNewsTableViewCell cellHeight];
}


@end
