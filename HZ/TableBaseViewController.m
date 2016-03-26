//
//  TableBaseViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/25.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "TableBaseViewController.h"

@interface TableBaseViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation TableBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = [NSMutableArray array];
    [self customTableView];
}


- (void)setTopInset:(CGFloat)top{
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
}
- (void)customTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
   [self.view addSubview:self.tableView];
}

- (void)registerCell:(Class)clz{
    NSString *cellName = NSStringFromClass(clz);
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
}

- (void)loadMoreData{
//    子类来实现
}


- (void)refreshData{
   //    子类来实现
}

#pragma  mark //    子类来实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

@end
