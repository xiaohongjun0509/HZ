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
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation HZPublishEnterpriseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self adjustTableView];
    if (self.requestOfPublish) {
        UILongPressGestureRecognizer *ges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(operate:)];
        [self.tableView addGestureRecognizer:ges];
    }
    [self.tableView.mj_header beginRefreshing];
}

-(void)operate:(UILongPressGestureRecognizer *)longRecognizer
{
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [longRecognizer locationInView:self.tableView];
        NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:point];
        self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight-64)];
        //图层透明，控件不透明
        UIColor *color = [UIColor blackColor];
        self.backBtn.backgroundColor = [color colorWithAlphaComponent:0.5];
        self.backBtn.userInteractionEnabled = YES;
        [self.backBtn addTarget:self action:@selector(dismissBackButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.backBtn];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = @"请选择";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor colorWithRed:11/255.0 green:111/255.0 blue:221/255.0 alpha:1];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:labelText];
        self.titleLabel.frame = CGRectMake(15, self.backBtn.frame.size.height/2 - 66, viewWidth-30, 44);
        [self.backBtn addSubview:self.titleLabel];
        
        UIButton *makeTop = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), viewWidth-30, 44)];
        [makeTop addTarget:self action:@selector(makeToTop:) forControlEvents:UIControlEventTouchUpInside];
        makeTop.backgroundColor = [UIColor whiteColor];
        [makeTop setTitle:@"置顶" forState:UIControlStateNormal];
        makeTop.tag = 1000 + indexPath.row;
        //        makeTop.contentEdgeInsets = UIEdgeInsetsMake(0, 0, <#CGFloat bottom#>, <#CGFloat right#>)
        [makeTop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.backBtn addSubview:makeTop];
        
        UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(makeTop.frame), viewWidth-30, 44)];
        [deleteButton addTarget:self action:@selector(makeDelete:) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.tag = 1000 + indexPath.row;
        deleteButton.backgroundColor = [UIColor whiteColor];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.backBtn addSubview:deleteButton];
    }
}


- (void)dismissBackButton:(UIButton *)sender{
    [sender removeFromSuperview];
}

- (void)makeToTop:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    [self.backBtn removeFromSuperview];
    MbUserInfo *model = self.dataList[index];
    
    [MbPaser sendMyReleaseEnterpriseRefreshByUserid:[[NSUserDefaults standardUserDefaults] stringForKey:@"userid"] companyid:model.companyid result:^(MyReleaseEnterpriseRefreshResponse *response, NSError *error) {
        if (response) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            [self refreshData];
        }
    }];
    
    
}

- (void)makeDelete:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    [self.backBtn removeFromSuperview];
    MbUserInfo *model = self.dataList[index];
    
    [MbPaser sendMyReleaseEnterpriseDeleteByUserid:[[NSUserDefaults standardUserDefaults] stringForKey:@"userid"] companyid:model.companyid result:^(MyReleaseEnterpriseDeleteResponse *response, NSError *error) {
        if (response) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertView show];
            [self refreshData];
        }
        
    }];
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
