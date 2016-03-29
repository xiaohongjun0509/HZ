//
//  HZResumeViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZResumeViewController.h"
#import "HZJobHuntCell.h"
#import "HZResumeModel.h"
#import "HZSegmentView.h"
#import "HZResumeDetailViewController.h"
@interface HZResumeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, strong) HZSegmentView *segmentView;
@end

@implementation HZResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cityName = @"北京";
    self.title = [NSString stringWithFormat:@"看简历(%@)",self.cityName];
    self.job = nil;
    self.area = nil;
    self.salary = nil;
    [self registerCell:[HZJobHuntCell class]];
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView.mj_header beginRefreshing];
    [self attachBackButton];
    [self attachSegmentView];
}

- (void)attachSegmentView{
    self.segmentView = [[HZSegmentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
     self.segmentView.titleArray = @[@"意向职位",@"工作经验",@"期望薪资"];
    [self.view addSubview:self.segmentView];
}

- (void)refreshData{
    self.requestPage = 1;
    [self startRequest];
    
}

-(void)loadMoreData{
    [self startRequest];
}

- (void)startRequest{
    NSString *urlStr = [NSString stringWithFormat:@"%@?hasNext=%ld",seeresume,self.requestPage];
    WEAKSELF
    [[NetworkManager manager] startRequest:urlStr completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if(!error){
            NSDictionary *dict = responseObject;
            [HZResumeModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"experienced":@"HZResumeExperienceModel",@"business":@"HZResumeBusinessModel"};
            }];
            NSArray *dataList = [HZResumeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            if(self.requestPage == 1){
                [weakSelf.dataList removeAllObjects];
            }
            if (dataList.count == 0) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.dataList addObjectsFromArray:dataList];
                [weakSelf.tableView reloadData];
                weakSelf.requestPage++;
            }
            
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            
        }
    }];
    
}


#pragma mark network
-(void)getPosition{
    //    NSURL *url = [NSURL URLWithString:hopeposition1];
    //    //第二步，创建请求
    //    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    //    NSString *str = @"type=focus-c";//设置参数
    //    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //    [request setHTTPBody:data];
    //    //第三步，连接服务器
    //    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
    //    self.positionList = [MbPaser paserPositionByDic:dic];
    //
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [self.tableView1 reloadData];
    //    });
}


#pragma mark UITableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZJobHuntCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZJobHuntCell"];
    HZResumeModel *model = self.dataList[indexPath.row];
    cell.resumeModel = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HZJobHuntCell cellHeight];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HZResumeDetailViewController *controller = [[HZResumeDetailViewController alloc] init];
    controller.model = self.dataList[indexPath.row];
    [self presentVC:controller];
}
@end
