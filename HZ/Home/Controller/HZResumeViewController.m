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
#import "HZTwoSelectionViewController.h"
#import "HZPositionTypeModel.h"
#import "HZSingalSelectionViewController.h"
@interface HZResumeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *wage;

@property (nonatomic, strong) HZTwoSelectionViewController *postionController;
@property (nonatomic, strong) HZSingalSelectionViewController *singlgSelectionController;
@property (nonatomic, strong) HZSegmentView *segmentView;
@property (nonatomic, copy) NSArray *wageList;
@property (nonatomic, copy) NSArray *experienceList;
@end

@implementation HZResumeViewController

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
    
    self.title = @"看简历";
    [self registerCell:[HZJobHuntCell class]];
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView.mj_header beginRefreshing];
    [self attachBackButton];
    [self attachSegmentView];
    [self requestWage];
    [self requestExperience];
}

- (void)attachSegmentView{
    self.segmentView = [[HZSegmentView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
     self.segmentView.titleArray = @[@"意向职位",@"工作经验",@"期望薪资"];
    WEAKSELF
    self.segmentView.positionBlock = ^{
        weakSelf.singlgSelectionController.view.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.postionController.view.hidden = NO;
        }];
        [weakSelf requestPosition];
        
    };
    
    self.segmentView.locationBlock = ^{
        weakSelf.postionController.view.hidden = YES;
        weakSelf.singlgSelectionController.singleType = HZSingleTypeArea;
        weakSelf.singlgSelectionController.dataList = weakSelf.experienceList;
        [weakSelf.singlgSelectionController.tableView reloadData];
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.singlgSelectionController.view.hidden = NO;
        }];
        
    };
    
    self.segmentView.salaryBlock = ^{
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
    NSString *urlStr = [NSString stringWithFormat:@"%@?hasNext=%ld&area=%@",seeresume,self.requestPage,self.cityName];
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


-(void)requestPosition{
    
    WEAKSELF
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


- (void)requestExperience{
    WEAKSELF
//    NSString* path = [NSString stringWithFormat:@"%@area=%@",threeplace,self.cityName];
    [[NetworkManager manager] startRequest:hopeexperience completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *dict = responseObject;
            
            weakSelf.experienceList = [HZPositionName mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            
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
