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
#import "MbPaser.h"
@interface HZJobDetailController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, strong) UIView *footer;
@end

@implementation HZJobDetailController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"工作详情"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.titleArray = @[@"标题",@"",@"",@"薪资待遇",@"学历要求",@"经验要求",@"区域",@"工作地点",@"任职要求",@"公司简介",@"联系人"];
    self.dict  = @{self.titleArray[0]:self.model.title,
                   self.titleArray[1]:self.model.title,
                   self.titleArray[2]:self.model.experience,
                   self.titleArray[3]:self.model.wages,
                   self.titleArray[4]:self.model.diploma,
                   self.titleArray[5]:self.model.experience,
                   self.titleArray[6]:self.model.area,
                   self.titleArray[7]:self.model.address,
                   self.titleArray[8]:self.model.demand,
                   self.titleArray[9]:self.model.aboutus,
                   self.titleArray[10]:self.model.linkman,
                   };
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailArrayCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailArrayCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailTimeUpdateCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailTimeUpdateCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [self footer];
    [self attachCollect];
}

- (void)collect{
    NSString *userid = [[NSUserDefaults standardUserDefaults]stringForKey:@"userid"];
    if (userid.length) {
       [MbPaser sendRecruitmenCollectByUserid:userid recruitmenid:self.model.recruitmenid result:^(RecruitmenCollectResponse *response, NSError *error) {
           
           UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:(response.turn == 200? @"收藏成功" : @"已收藏,不需重复收藏") delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
           [self judgetwo];
          
       }];
        }else{
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    
}

-(void)judgetwo{
    NSString *userid = [[NSUserDefaults standardUserDefaults] stringForKey:@"userid"];
    NSString* path = [NSString stringWithFormat:@"%@userid=%@&recruitmenid=%@",judge1,userid,self.model.recruitmenid];
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:path];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:nil];
    
    NSString* string = [dic objectForKey:@"collectionid"];
    if ([string isEqualToString:@"0"]) {
        UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_co_col.png"] style:UIBarButtonItemStyleDone target:self action:@selector(collect)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }else if ([string isEqualToString:@"1"]){
        UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_co_sel_col.png"] style:UIBarButtonItemStyleDone target:self action:@selector(shoucang1)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
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
        applyLabel.text = @"职位邀请";
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
    if(![[NSUserDefaults standardUserDefaults] stringForKey:@"userid"]){
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.model.phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
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
        [fmt  setDateFormat:@"yyyy-MM-dd"];
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
    if (indexPath.row == self.titleArray.count - 2 || indexPath.row == self.titleArray.count - 3) {
        NSString *title = self.titleArray[indexPath.row];
        NSString *content = self.dict[title];
        return [HZResumeDetailCell cellHeight:content];
    }
    
        return 44;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

@end
