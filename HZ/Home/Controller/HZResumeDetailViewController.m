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
#import "HZResumeDetailTimeUpdateCell.h"
#import "MbPaser.h"
@interface HZResumeDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, copy) NSArray *titleArray;

@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) UILabel *footerLabel;

@end

@implementation HZResumeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"简历详情";
    self.titleArray = @[@"标题",@"",@"工作经验",@"学历",@"求职意向",@"期望薪资",@"教育经历",@"工作经历",@"自我介绍"];
    self.dict  = @{self.titleArray[0]:self.model.title,
                   self.titleArray[1]:self.model.title,
                   self.titleArray[2]:self.model.experience,
                   self.titleArray[3]:self.model.diploma,
                   self.titleArray[4]:self.model.position,
                   self.titleArray[5]:self.model.wages,
                   self.titleArray[6]:self.model.experienced.count > 0 ? self.model.experienced : @"未填写",
                   self.titleArray[7]:self.model.business.count > 0 ? self.model.business : @"未填写",
                   self.titleArray[8]:self.model.intruduction
                   };
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailTimeUpdateCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailTimeUpdateCell"];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"HZResumeDetailArrayCell" bundle:nil] forCellReuseIdentifier:@"HZResumeDetailArrayCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = self.footer;
    [self attachCollect];
}

-(void)apply:(UIButton* )sender{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.model.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 1){
        HZResumeDetailTimeUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailTimeUpdateCell"];
        cell.contentLabel.text = [NSString stringWithFormat:@"%@     %@     %@岁",self.model.username, self.model.sex.integerValue == 1 ? @"男":@"女", self.model.age];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.model.restime.integerValue];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        [fmt  setDateFormat:@"yyyy-MM-dd"];
        NSString *time = [fmt stringFromDate:date];
        cell.updateTimeLabel.text = [NSString stringWithFormat:@"%@更新",time];
        return cell;
    }
    
    NSString *title = self.titleArray[indexPath.row];
    if ([title isEqualToString:@"教育经历"] || [title isEqualToString:@"工作经历"]) {
        HZResumeDetailArrayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailArrayCell"];
        if ([title isEqualToString:@"教育经历"]) {
            if(self.model.experienced.count > 0){
                cell.school = YES;
            }else{
                HZResumeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailCell"];
                cell.titleLabel.text = self.titleArray[indexPath.row];
                cell.contentLabel.text = self.dict[title];
                return cell;
            }
            
        }else{
            if (self.model.business.count > 0) {
                cell.school = NO;
            }else{
                HZResumeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZResumeDetailCell"];
                cell.titleLabel.text = self.titleArray[indexPath.row];
                cell.contentLabel.text = self.dict[title];
                return cell;
            }
            
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
        return [HZResumeDetailArrayCell cellHeight:self.dict[title]];
        
    }else{
        return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dict.allKeys.count;
}
- (void)collect{
    NSLog(@"----");
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            
            [MbPaser sendResumeCollectByUserid:[[NSUserDefaults standardUserDefaults] stringForKey:@"userid"] resumeid:self.model.resumeid result:^(ResumeidCollectResponse *response, NSError *error) {
                if (response.message) {
                    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    [self judgetwo];
                }
                
                
            }];
        }
}

-(void)judgetwo{
    NSString* path = [NSString stringWithFormat:@"%@userid=%@&resumeid=%@",judge2,@"",self.model.resumeid];
    
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

- (void)shoucang1{
    
}
@end
