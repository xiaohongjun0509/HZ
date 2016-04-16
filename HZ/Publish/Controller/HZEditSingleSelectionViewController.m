//
//  HZEditSingleSelectionViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/4/10.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZEditSingleSelectionViewController.h"
#import "HZRightTableViewCell.h"
#import "HZPlaceModel.h"
@interface HZEditSingleSelectionViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@end

@implementation HZEditSingleSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HZRightTableViewCell" bundle:nil] forCellReuseIdentifier:@"HZRightTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.userInteractionEnabled = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideController)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    self.label.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
}

- (void)hideController{
    self.view.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZRightTableViewCell"];
    switch (self.type) {
        case 0://age
        {
           NSString *age = self.dataList[indexPath.row];
           cell.label.text = age;
            break;
        }
        case 1:
        {
            HZPlaceModel *model = self.dataList[indexPath.row];
            cell.label.text = model.diploma;
            break;
        }
        case 2:
        {
            HZPlaceModel *model = self.dataList[indexPath.row];
            cell.label.text = model.suffer;
            break;
        }
        case 3:
        {
            HZPlaceModel *model = self.dataList[indexPath.row];
            cell.label.text = model.positioname;
            break;
        }
        case 4:
        {
            HZPlaceModel *model = self.dataList[indexPath.row];
            cell.label.text = model.pay;
            break;
        }
            
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.updateBlock) {
        HZRightTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.item.btnTitle = cell.label.text;
        self.item.placeHolder = cell.label.text;
        self.updateBlock();
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
