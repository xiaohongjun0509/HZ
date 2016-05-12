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
#import "HZTwoSelectionViewController.h"
#import "HZPositionTypeModel.h"
#import "HZSingalSelectionViewController.h"



@interface HZJobHuntViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *salary;

@property (nonatomic, strong) HZTwoSelectionViewController *postionController;
@property (nonatomic, strong) HZSingalSelectionViewController *singlgSelectionController;
@property (nonatomic, strong) HZSegmentView *segmentView;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *wage;

@property (nonatomic, copy) NSArray *areaList;
@property (nonatomic, copy) NSArray *wageList;
@end




@implementation HZJobHuntViewController


- (HZTwoSelectionViewController *)postionController{
    if (_postionController == nil) {
        WEAKSELF
        _postionController = [[HZTwoSelectionViewController alloc] init];
        [self.view addSubview:_postionController.view];
        _postionController.view.hidden = YES;
        _postionController.view.frame = CGRectMake(0, 44, ScreenWidth, ScreenHeight - 44);
        _postionController.updateBlock = ^(NSString *content){
            weakSelf.segmentView.positionLabel.text = content;
            weakSelf.position = content;
            [weakSelf startRequest];
        };
    }
    return _postionController;
}

- (HZSingalSelectionViewController *)singlgSelectionController{
    if (!_singlgSelectionController) {
        WEAKSELF
        _singlgSelectionController = [[HZSingalSelectionViewController alloc] init];
        _singlgSelectionController.updateBlock = ^(NSString *content){
            if (_singlgSelectionController.singleType == HZSingleTypeArea) {
                weakSelf.segmentView.locationLabel.text = content;
                weakSelf.area = content;

            }else{
                weakSelf.segmentView.salarLabel.text = content;
                weakSelf.wage = content;
            }
            weakSelf.requestPage = 1;
            [weakSelf startRequest];
        };
        [self.view addSubview:_singlgSelectionController.view];
        _singlgSelectionController.view.hidden = YES;
        _singlgSelectionController.view.frame = CGRectMake(0, 44, ScreenWidth, ScreenHeight - 44);
    }
    return _singlgSelectionController;
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.title = [NSString stringWithFormat:@"找工作"];
    [self registerCell:[HZJobHuntCell class]];
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    [self.tableView.mj_header beginRefreshing];
    [self attachBackButton];
    [self attachSegmentView];
    [self requestArea];
    [self requestWage];
    
}

- (void)hideController{
    self.postionController.view.hidden = YES;
    self.singlgSelectionController.view.hidden = YES;
}

- (void)attachSegmentView{
    self.segmentView = [[HZSegmentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    WEAKSELF
    self.segmentView.positionBlock = ^{
        weakSelf.requestPage = 1;
        weakSelf.singlgSelectionController.view.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.postionController.view.hidden = NO;
        }];
        [weakSelf requestPosition];
        
    };
    
    self.segmentView.locationBlock = ^{
        weakSelf.requestPage = 1;
        weakSelf.postionController.view.hidden = YES;
        weakSelf.singlgSelectionController.singleType = HZSingleTypeArea;
        weakSelf.singlgSelectionController.dataList = weakSelf.areaList;
        [weakSelf.singlgSelectionController.tableView reloadData];
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.singlgSelectionController.view.hidden = NO;
        }];
        
    };
    
    self.segmentView.salaryBlock = ^{
        weakSelf.requestPage = 1;
        weakSelf.postionController.view.hidden = YES;
        weakSelf.singlgSelectionController.singleType = HZSingleTypeWage;
        weakSelf.singlgSelectionController.dataList = weakSelf.wageList;
        [weakSelf.singlgSelectionController.tableView reloadData];
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.singlgSelectionController.view.hidden = NO;
        }];
        
    };
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
    NSString *urlStr = [NSString stringWithFormat:@"%@area=%@&hasNext=%ld",findwork,self.cityName,self.requestPage];
    NSMutableString *mutableString = [NSMutableString stringWithString:urlStr];
    if (self.position) {
        [mutableString appendString:[NSString stringWithFormat:@"&position=%@",self.position]];
    }
    if (self.wage) {
        [mutableString appendString:[NSString stringWithFormat:@"&wages=%@",self.wage]];
    }
    
    if (self.area) {
         [mutableString appendString:[NSString stringWithFormat:@"&area=%@",self.area]];
    }
    WEAKSELF
    [[NetworkManager manager] startRequest:mutableString completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
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
                weakSelf.requestPage++;
            }
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    }];

}


#pragma mark network
-(void)requestPosition{
   
    WEAKSELF
//    NSString* path = [NSString stringWithFormat:@"%@area=%@",hopeposition1,self.cityName];
    [[NetworkManager manager] startRequest:hopeposition completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dict = responseObject;
            [HZPositionTypeModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"position":@"HZPositionName"};
            }];
           weakSelf.postionController.leftList = [HZPositionTypeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            [weakSelf.postionController.leftTableView reloadData];
            [weakSelf.postionController.leftTableView setNeedsLayout];
            [weakSelf.postionController.leftTableView layoutIfNeeded];
            weakSelf.postionController.selectedIndex = 0;
            [weakSelf.postionController.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }];
}


- (void)requestArea{
    WEAKSELF
//   这里有个接口上的问题。
    NSString *city = [self.cityName isEqualToString:@"北京"] ? @"北京市" : self.cityName;
    NSString* path = [NSString stringWithFormat:@"%@area=%@",threeplace,city];
    [[NetworkManager manager] startRequest:path completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dict = responseObject;
            
            weakSelf.areaList = [HZPositionName mj_objectArrayWithKeyValuesArray:dict[@"data"]];
          
        }
    }];
}
- (void)requestWage{
    WEAKSELF
    [[NetworkManager manager] startRequest:hopesalary completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dict = responseObject;

            weakSelf.wageList = [HZPositionName mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        }
    }];
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
