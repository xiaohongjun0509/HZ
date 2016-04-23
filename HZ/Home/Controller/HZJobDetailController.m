//
//  HZJobDetailController.m
//  HZ
//
//  Created by hongjunxiao on 16/4/4.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZJobDetailController.h"
#import "HZResumeDetailCell.h"
#import "HZResumeDetailTimeUpdateCell.h"
@interface HZJobDetailController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, strong) UIView *footer;
@end

@implementation HZJobDetailController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"工作详情(%@)",self.cityName];
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
                   self.titleArray[10]:self.model.linkman,
                   self.titleArray[11]:self.model.phone
                   };
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailArrayCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailArrayCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailTimeUpdateCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailTimeUpdateCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [self footer];
}

- (UIView *)footer{
    if (!_footer) {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        _footer = containerView;
        
        UIButton *applyBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/2-viewWidth/6, 15, viewWidth/3, 30)];
        [applyBtn setBackgroundColor:[UIColor colorWithRed:0 green:193/255.0 blue:90/255.0 alpha:1]];
        applyBtn.userInteractionEnabled = YES;
        [applyBtn addTarget:self action:@selector(apply:) forControlEvents:UIControlEventTouchUpInside];
        applyBtn.layer.cornerRadius = 15;
        applyBtn.layer.masksToBounds = YES;
        [containerView addSubview:applyBtn];
        
        UIImageView* callImage = [[UIImageView alloc]initWithFrame:CGRectMake(13, 5, 20, 20)];
        callImage.image = [UIImage imageNamed:@"home_icon_call.png"];
        [applyBtn addSubview:callImage];
        
        UILabel* applyLabel = [[UILabel alloc]init];
        applyLabel.text = @"申请职位";
        applyLabel.font = [UIFont systemFontOfSize:14];
        applyLabel.textColor = [UIColor whiteColor];
        CGSize applySize = [applyLabel.text sizeWithFont:applyLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        applyLabel.frame = CGRectMake(CGRectGetMaxX(callImage.frame)+5, 15-applySize.height/2, applySize.width, applySize.height);
        [applyBtn addSubview:applyLabel];
        applyBtn.center = containerView.center;
        [_footer addSubview:applyBtn];
    }
    return _footer;
}

-(void)apply:(UIButton* )sender{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.model.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        HZResumeDetailTimeUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailTimeUpdateCell"];
        cell.contentLabel.text = self.model.position;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.model.rectime.integerValue];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        [fmt  setDateFormat:@"yyyy:MM:dd"];
        NSString *time = [fmt stringFromDate:date];
        cell.updateTimeLabel.text = [NSString stringWithFormat:@"%@更新",time];
        cell.zhaoTypeButton.hidden = YES;
        cell.updateTimeLabel.hidden = NO;
        return cell;
    }
    if (indexPath.row == 2) {
        HZResumeDetailTimeUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailTimeUpdateCell"];
        if ([self.model.ways isEqualToString:@"1"]) {
            [cell.zhaoTypeButton setTitle:@"直招" forState:UIControlStateNormal];
        }else{
            [cell.zhaoTypeButton setTitle:@"代招" forState:UIControlStateNormal];
        }
        [cell.zhaoTypeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.zhaoTypeButton setBackgroundColor:RGB(41, 117, 224)];
        [cell.zhaoTypeButton setFont:[UIFont systemFontOfSize:14]];
        cell.contentLabel.text = self.model.company;
        cell.updateTimeLabel.hidden = YES;
        cell.zhaoTypeButton.hidden = NO;
        return cell;
    }
    
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
    return 12;
}

@end
