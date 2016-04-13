//
//  MbZhongBiaoViewController.m
//  好筑
//
//  Created by tusm on 15/12/10.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbZhongBiaoViewController.h"
#import "MbZhongBiaoTableViewCell.h"

@interface MbZhongBiaoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;

@end

@implementation MbZhongBiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, viewWidth, viewHeight- 120)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifire = @"Cell";
    MbZhongBiaoTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[MbZhongBiaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        cell.delegate = self;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat cellHeight = 0.0f;
    MbZhongBiaoTableViewCell *cell = (MbZhongBiaoTableViewCell *)[self tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath];
    cellHeight = cell.finalH;
    
    return cellHeight;
}

@end
