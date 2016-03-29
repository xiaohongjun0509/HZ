//
//  HZResumeDetailViewController.m
//  HZ
//
//  Created by hongjunxiao on 16/3/29.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZResumeDetailViewController.h"
#import "HZResumeDetailCell.h"
#import "HZResumeModel.h"
#import "HZResumeDetailArrayCell.h"
@interface HZResumeDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation HZResumeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = @[@"标题",@"",@"工作经验",@"学历",@"求职意向",@"期望薪资",@"教育经历",@"工作经历",@"自我介绍"];
    self.dict  = @{self.titleArray[0]:self.model.title,
                   self.titleArray[1]:self.model.title,
                   self.titleArray[2]:self.model.experience,
                   self.titleArray[3]:self.model.diploma,
                   self.titleArray[4]:self.model.position,
                   self.titleArray[5]:self.model.wages,
                   self.titleArray[6]:self.model.experienced,
                   self.titleArray[7]:self.model.business,
                   self.titleArray[8]:self.model.intruduction
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
    if ([title isEqualToString:@"教育经历"] || [title isEqualToString:@"工作经历"]) {
        HZResumeDetailArrayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailArrayCell"];
        if ([title isEqualToString:@"教育经历"]) {
            cell.school = YES;
        }else{
            cell.school = NO;
        }
        
        cell.array = [self.dict objectForKey:title];
        return cell;
    }else{
        HZResumeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailCell"];
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.contentLabel.text = self.dict[title];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.titleArray[indexPath.row];
    if ([title isEqualToString:@"教育经历"] || [title isEqualToString:@"工作经历"]) {
//        HZResumeDetailArrayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailArrayCell"];
        return [HZResumeDetailArrayCell cellHeight:self.dict[title]];
        
    }else{
//        HZResumeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailCell"];
        return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dict.allKeys.count;
}
@end
