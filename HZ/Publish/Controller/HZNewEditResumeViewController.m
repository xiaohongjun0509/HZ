//
//  HZNewEditResumeViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/4/10.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZNewEditResumeViewController.h"
#import "HZEditResumeItemModel.h"
#import "HZResumeEditCell.h"
#import "HZEditSingleSelectionViewController.h"
#import "HZPlaceModel.h"
#import "HZPositionModel.h"
@interface HZNewEditResumeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *showList;
@property (nonatomic, strong) HZEditSingleSelectionViewController *selectionController;
@property (nonatomic, strong) NSMutableDictionary *selectionDataSource;
@property (nonatomic, copy) NSArray *titleArray;
@end

@implementation HZNewEditResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeEditCell" bundle:nil] forCellReuseIdentifier:@"HZResumeEditCell"];
    [self makeItems];
    self.selectionDataSource = [NSMutableDictionary dictionary];
    [self requestData];
    
}


- (void)requestData{
    [self requestAge];
    [self getExperience];
    [self getEducation];
    [self getPosition];
    [self getSalary];
}


- (void)makeItems{
    NSArray *titleArray = @[@"自我介绍",@"姓名",@"年龄",@"学历",@"工作经验",@"意向职位",@"期望薪资",@"教育经历",@"工作经历",@"详细介绍",@"电话"];
    self.titleArray = titleArray;
    NSArray *placeHolderArray = @[@"一句话介绍自己",@"请填写名字",@"请选择年龄",@"请选择学历",@"请选择工作年限",@"请选择意向职位",@"请选择期望薪资",@"",@"",@"请详细描述自身的工作能力等等",@"请填写手机或固话"];
    self.showList = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        HZEditResumeItemModel *item = [HZEditResumeItemModel new];
        item.leftTitle = titleArray[i];
        item.placeHolder = placeHolderArray[i];
        item.showSexButton = i == 1;
        item.index = 1000 + i;
        [self.showList addObject:item];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZResumeEditCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HZResumeEditCell"];
    __block HZEditResumeItemModel *model = self.showList[indexPath.row];
    cell.model = model;
    WEAKSELF
    cell.showSelectionView = ^(NSInteger index){
        NSString *key = [NSString stringWithFormat:@"%ld",index];
        weakSelf.selectionController.dataList = weakSelf.selectionDataSource[key];
        [weakSelf.selectionController.tableView reloadData];
        weakSelf.selectionController.type = index;
        weakSelf.selectionController.view.hidden = NO;
        weakSelf.selectionController.label.text = weakSelf.titleArray[index + 2];
        weakSelf.selectionController.item = model;
        
    };
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showList.count;
}


#pragma mark - private
- (void)requestAge{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 16; i < 70; i++) {
        NSString *age = [NSString stringWithFormat:@"%d",i];
        [array addObject:age];
    }
    [self.selectionDataSource setValue:array forKey:@"0"];
}
//地区
//-(void)requestPlace{
//
//    [[NetworkManager manager] postRequest:hopeplace completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        NSDictionary *dict = (NSDictionary *)responseObject;
//        NSArray *placeList = [HZPlaceModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
//
//    }];
//}
////学历
-(void)getEducation{
    [[NetworkManager manager] postRequest:hopeeducation completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *educationList = [HZPlaceModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        self.selectionDataSource[@"1"] = educationList;
    }];
}
////工作经验
-(void)getExperience{
    
    [[NetworkManager manager] postRequest:hopeexperience completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *experienceList = [HZPlaceModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        self.selectionDataSource[@"2"] = experienceList;
    }];
}
////应聘职位
-(void)getPosition{
    
    [[NetworkManager manager] postRequest:hopeposition completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSArray *positionList = [HZPositionModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        self.selectionDataSource[@"3"] = positionList;
    }];
}
////期望薪资
-(void)getSalary{
    
    [[NetworkManager manager] postRequest:hopesalary completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *salaryList = [HZPlaceModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        self.selectionDataSource[@"4"] = salaryList;
    }];
}

- (HZEditSingleSelectionViewController *)selectionController{
    if(!_selectionController){
        WEAKSELF
        _selectionController = [[HZEditSingleSelectionViewController alloc] init];
        [self.view addSubview:_selectionController.view];
        _selectionController.view.hidden = YES;
        self.selectionController.updateBlock = ^(){
            [weakSelf.tableView reloadData];
        };
    }
    return _selectionController;
}
@end
