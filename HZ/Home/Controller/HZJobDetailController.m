//
//  HZJobDetailController.m
//  HZ
//
//  Created by hongjunxiao on 16/4/4.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZJobDetailController.h"
#import "HZResumeDetailCell.h"
@interface HZJobDetailController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSDictionary *dict;
@end

@implementation HZJobDetailController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"简历详情";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.titleArray = @[@"标题",@"",@"",@"薪资待遇",@"学历要求",@"经验要求",@"区域",@"工作地点",@"任职要求",@"公司简介",@"联系人",@"电话"];
    self.dict  = @{self.titleArray[0]:self.model.title,
                   self.titleArray[1]:self.model.title,
                   self.titleArray[2]:self.model.experience,
                   self.titleArray[3]:self.model.wages,
                   self.titleArray[4]:self.model.diploma,
                   self.titleArray[5]:self.model.experience,
                   self.titleArray[6]:self.model.area,
                   self.titleArray[7]:self.model.position,
                   self.titleArray[8]:self.model.demand,
                   self.titleArray[9]:self.model.aboutus,
                   self.titleArray[10]:self.model.phone,
                   self.titleArray[11]:self.model.phone
                   };
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailArrayCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailArrayCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title = self.titleArray[indexPath.row];
   
    HZResumeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailCell"];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.contentLabel.text = self.dict[title];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 44;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dict.allKeys.count;
}

@end
