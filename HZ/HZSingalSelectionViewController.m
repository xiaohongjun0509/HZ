//
//  HZSingalSelectionViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/4/9.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZSingalSelectionViewController.h"
#import "HZRightTableViewCell.h"
#import "HZPositionName.h"
@interface HZSingalSelectionViewController ()<UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate>

@end

@implementation HZSingalSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.singleType = HZSingleTypeUnkown;
    [self.tableView registerNib:[UINib nibWithNibName:@"HZRightTableViewCell" bundle:nil] forCellReuseIdentifier:@"HZRightTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideController)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (void)hideController{
    self.view.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZRightTableViewCell"];
    HZPositionName *areaModel = self.dataList[indexPath.row];
    cell.label.text = self.singleType == HZSingleTypeArea ? (areaModel.name ? areaModel.name : areaModel.suffer) : areaModel.pay;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.updateBlock) {
        HZPositionName *nameModel = self.dataList[indexPath.row];
        self.updateBlock(self.singleType == HZSingleTypeArea ? nameModel.name : nameModel.pay);
        self.view.hidden = YES;
    }
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
    
}
@end
