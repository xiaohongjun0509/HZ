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
#import "HZJobDetailController.h"
#import "MbPaser.h"
@interface HZPublishJobViewController ()
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *operationTitle1;
@property (nonatomic, copy) NSString *operationTitle2;

@end

@implementation HZPublishJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self adjustTableView];
    [self.tableView.mj_header beginRefreshing];
    UILongPressGestureRecognizer *ges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(operate:)];
    [self.tableView addGestureRecognizer:ges];
    if (self.requestOfPublish) {
        self.operationTitle1 = @"置顶";
        self.operationTitle2 = @"删除";
    }else{
        self.operationTitle1 = @"取消收藏";
        self.operationTitle2 = @"全部取消收藏";
    }
}

-(void)operate:(UILongPressGestureRecognizer *)longRecognizer
{
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [longRecognizer locationInView:self.tableView];
        NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:point];
        HZJobModel *model = self.dataList[indexPath.row];
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
        [makeTop setTitle:self.operationTitle1 forState:UIControlStateNormal];
        makeTop.tag = 1000 + indexPath.row;
        [makeTop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.backBtn addSubview:makeTop];
        
        UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(makeTop.frame), viewWidth-30, 44)];
        [deleteButton addTarget:self action:@selector(makeDelete:) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.tag = 1000 + indexPath.row;
        deleteButton.backgroundColor = [UIColor whiteColor];
        [deleteButton setTitle:self.operationTitle2 forState:UIControlStateNormal];
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
    if (self.requestOfPublish) {//置顶
        HZJobModel *model = self.dataList[index];
        [MbPaser sendMyReleaseRecruitRefreshByRecruitmenid:model.recruitmenid result:^(MyReleaseRecruitRefreshResponse *response, NSError *error) {
            if (response) {
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                [self refreshData];
            }
        }];
    }else{//取消收藏
        HZJobModel *model = self.dataList[index];
        //取消收藏
        NSString *userid = [[NSUserDefaults standardUserDefaults] stringForKey:@"userid"];
        [MbPaser sendCancleRecruitmenCollectByUserid:userid recruitmencollid:model.recruitmenid result:^(CancleRecruitmenCollectResponse *response, NSError *error) {
            if (response.message) {
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            [self refreshData];
            [self.backBtn removeFromSuperview];
        }];

        
        
        
    }

}

- (void)makeDelete:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    [self.backBtn removeFromSuperview];
    if (self.requestOfPublish) {
        HZJobModel *model = self.dataList[index];
        [MbPaser sendMyReleaseRecruitDeleteByUserid:[[NSUserDefaults standardUserDefaults] stringForKey:@"userid"] recruitmenid:model.recruitmenid result:^(MyReleaseRecruitDeleteResponse *response, NSError *error) {
            if (response) {
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                [self refreshData];
            }
        }];
    }else{
        
        NSMutableArray* arr = [NSMutableArray array];
        for (int i = 0; i<self.dataList.count; i++) {
            HZJobModel *model = [self.dataList objectAtIndex:i];
            
            [arr addObject:model];
            
        }
//        NSString *recuitmentIdArray = [arr componentsJoinedByString:@","];

        NSString *userid = [[NSUserDefaults standardUserDefaults] stringForKey:@"userid"];
        //取消收藏
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HZJobModel *model = obj;
            [MbPaser sendCancleRecruitmenCollectByUserid:userid recruitmencollid:model.recruitmenid result:^(CancleRecruitmenCollectResponse *response, NSError *error) {
//                if (response.message) {
//                    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alertView show];
//                }
                [self refreshData];
            }];
        }];
        

    }

}


- (void)adjustTableView{
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self registerCell:[HZJobHuntCell class]];
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
    NSString *urlPath = self.requestOfPublish ? myfindwork : workCollect;
    WEAKSELF
    
    NSString *tmp = self.requestOfPublish ? myfindwork : workCollect;
    NSString *url = [NSString stringWithFormat:@"%@userid=%@&hasNext=%ld",tmp,userid,self.requestPage];
    [[NetworkManager manager] postRequest:url completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            return ;
        }
        if (self.requestPage == 1) {
            [self.dataList removeAllObjects];
        }
        NSDictionary *result = responseObject;
        NSArray *array = [HZJobModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
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
    

//    }];
//    
//    [[NetworkManager manager] postRequest:urlPath parameters:@{@"userid":[[NSUserDefaults standardUserDefaults] stringForKey:@"userid"],@"hasNext":[NSString stringWithFormat:@"%ld",self.requestPage] } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            return ;
//        }
//        if (self.requestPage == 1) {
//            [self.dataList removeAllObjects];
//        }
//        NSDictionary *result = responseObject;
//        NSArray *array = [HZJobModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
//        if (array.count == 0) {
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        }else{
//            weakSelf.requestPage++;
//        }
//        [weakSelf.dataList addObjectsFromArray:array];
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//    }];
// 
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
    HZJobModel *model = self.dataList[indexPath.row];
    HZJobDetailController *vc = [HZJobDetailController new];
    vc.model = model;
    [self presentVC:vc];
}


@end
