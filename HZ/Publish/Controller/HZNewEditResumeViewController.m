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
#import "HZEditEducationCell.h"
#import "HZEducationalExperienceViewController.h"
#import "MbWorkExperienceViewController.h"
#import "MbPaser.h"
#import "HZEditDetailStudyModel.h"
@interface HZNewEditResumeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *showList;
@property (nonatomic, strong) HZEditSingleSelectionViewController *selectionController;
@property (nonatomic, strong) NSMutableDictionary *selectionDataSource;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) HZEducationalExperienceViewController *eduvc;
@property (nonatomic, copy) NSString *userid;
@end

@implementation HZNewEditResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    self.title = [NSString stringWithFormat:@"填写简历信息(%@)",self.cityName];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [self footer];
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeEditCell" bundle:nil] forCellReuseIdentifier:@"HZResumeEditCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HZEditEducationCell" bundle:nil] forCellReuseIdentifier:@"HZEditEducationCell"];
    [self makeItems];
    self.selectionDataSource = [NSMutableDictionary dictionary];
    [self requestData];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
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
        item.studyList = [NSMutableArray array];
        item.workList = [NSMutableArray array];
        [self.showList addObject:item];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 7 || indexPath.row == 8){
        HZEditEducationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZEditEducationCell"];
        HZEditResumeItemModel *model = self.showList[indexPath.row];
        cell.model = model;
        [cell.button setTitle: (indexPath.row == 7 ? @"教育经历"  : @"工作经历") forState:UIControlStateNormal];
        cell.study = indexPath.row == 7;
        cell.editBlock = ^{
            if (indexPath.row == 7) {
                self.eduvc = [[HZEducationalExperienceViewController alloc]init];
                self.eduvc.item = model;
                [self presentVC:self.eduvc];
            }else{
                MbWorkExperienceViewController *vc = [[MbWorkExperienceViewController alloc] init];
                vc.item = model;
                [self presentVC:vc];
            }
            
        };
        
       
        return cell;
    }
    
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
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 9 || indexPath.row == 10) {
        cell.textField.hidden = NO;
        cell.arrow.hidden = YES;
        
    }else{
        cell.textField.hidden = YES;
        cell.arrow.hidden = NO;
    }
    return cell;
}


- (UIView *)footer{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    view.backgroundColor = [UIColor redColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    button.center = CGPointMake(0.5 * ScreenWidth, 20);
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(releaseResume) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 7 || indexPath.row == 8){
        HZEditResumeItemModel *model = self.showList[indexPath.row];
        if (indexPath.row == 7) {
            return  [HZEditEducationCell cellHeight:model.studyList];
        }else{
            return  [HZEditEducationCell cellHeight:model.workList];
        }
       
    }
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


- (void)releaseResume{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag = 200;
        [alertView show];
    }else{
    
        HZEditResumeItemModel *model = self.showList[0];
        NSString *intro = model.placeHolder;
        model = self.showList[1];
        NSString *name = model.placeHolder;
        model = self.showList[2];
        int age = (int)[model.placeHolder integerValue];
        NSString *education = [self.showList[3] placeHolder];
        NSString *exp = [self.showList[4] placeHolder];
        NSString *position = [self.showList[5] placeHolder];
        NSString *salary = [self.showList[6] placeHolder];
        NSString *telephone = [[self.showList lastObject] placeHolder];
        
//      学习经历
        model = self.showList[7];
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:0];
        int i = 0;
        while (i < model.studyList.count) {
            HZEditDetailStudyModel *studyModel = model.studyList[i];
            [tmp addObject:studyModel.modelString];
            i++;
        }
        NSString* str = [tmp componentsJoinedByString:@","];
        NSString* string1 = @"[";
        NSString* string2 = @"]";
        NSString *studyString = [NSString stringWithFormat:@"%@%@%@",string1,str,string2];
        
        
        model = self.showList[8];
        tmp = [NSMutableArray arrayWithCapacity:0];
        i = 0;
        while (i < model.workList.count) {
            HZEditDetailStudyModel *studyModel = model.workList[i];
            [tmp addObject:studyModel.modelWorkString];
            i++;
        }
        NSString* str3 = [tmp componentsJoinedByString:@","];
        NSString* string4 = @"[";
        NSString* string5 = @"]";
        NSString *workString = [NSString stringWithFormat:@"%@%@%@",string4,str3,string5];
        
        BOOL needShow = NO;
        for (int i = 0; i < self.showList.count; i++) {
            HZEditResumeItemModel *model = self.showList[i];
            if (i == 7 ) {
                if(model.studyList.count == 0){
                    needShow = YES;
                }
            }else if(i == 8){
                needShow = model.workList.count == 0;
            }else{
               needShow = model.placeHolder.length == 0;
            }
        }
        if (needShow) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            HZEditResumeItemModel *model = self.showList[0];
            if (model.placeHolder.length > 10) {
                UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"自我介绍字数不能大于10" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }else{
                 HZEditResumeItemModel *model = self.showList[1];
                if(model.placeHolder.length > 6){
                    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"姓名字数不能大于6" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                }else{
                    [MbPaser sendResumeInformationByUserid:self.userid area:self.cityName
                                                introduces:intro
                                                      name:name
                                                       sex:0
                                                       age:age
                                                 education:education
                                                experience:exp
                                                  position:position
                                                    salary:salary
                                                 telephone:telephone
                                               addeduArray:studyString
                                              addworkArray:workString
                                                   jieshao:[self.showList[10] placeHolder]
                                                    result:^(ResumeSaveResponse *response, NSError *error) {
                        
                        NSString *str = [NSString stringWithFormat:@"%d",response.turn];
                        
                        if (response.turn == 200) {
                            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alert show];
                        }else{
                            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alert show];
                            
                        }
                        
                    }];

                }
            }
            
            
        }
    }

}
@end
