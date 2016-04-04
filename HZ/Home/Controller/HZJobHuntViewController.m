//
//  HZJobHuntViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZJobHuntViewController.h"
#import "HZJobHuntCell.h"
#import "HZJobModel.h"
#import "HZSegmentView.h"
#import "HZJobDetailController.h"
@interface HZJobHuntViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, strong) HZSegmentView *segmentView;
@end

@implementation HZJobHuntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cityName = @"北京";
    self.title = [NSString stringWithFormat:@"找工作(%@)",self.cityName];
    self.job = nil;
    self.area = nil;
    self.salary = nil;
    [self registerCell:[HZJobHuntCell class]];
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    [self.tableView.mj_header beginRefreshing];
    [self attachBackButton];
    [self attachSegmentView];
}

- (void)attachSegmentView{
    self.segmentView = [[HZSegmentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
   
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
    NSString *urlStr = [NSString stringWithFormat:@"%@?area=%@&hasNext=%ld",findwork,self.cityName,self.requestPage];
    WEAKSELF
    [[NetworkManager manager] startRequest:urlStr completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if(!error){
            NSDictionary *dict = responseObject;
            NSArray *dataList = [HZJobModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
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
    HZJobModel *model = self.dataList[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HZJobHuntCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   HZJobModel *model = self.dataList[indexPath.row];
    HZJobDetailController *vc = [HZJobDetailController new];
    vc.model = model;
    [self presentVC:vc];
}

@end
