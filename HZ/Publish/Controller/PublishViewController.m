//
//  PublishViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/22.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "PublishViewController.h"
#import "HZResumeEditViewController.h"
#import "HZRecruitmentViewController.h"
#import "HZEnterpriseinformationViewController.h"
#import "HZNewEditResumeViewController.h"
@interface PublishViewController ()
@property(nonatomic,strong)UIButton* btn1;    //求职简历
@property(nonatomic,strong)UIButton* btn2;    //职位招聘
@property(nonatomic,strong)UIButton* btn3;    //企业信息
@property(nonatomic,strong)UIImageView* imageView1;
@property(nonatomic,strong)UIImageView* imageView2;
@property(nonatomic,strong)UIImageView* imageView3;
@property(nonatomic,strong)UILabel* label1;
@property(nonatomic,strong)UILabel* label2;
@property(nonatomic,strong)UILabel* label3;
//@property(nonatomic,strong)MbResumeViewController* resumeVC;  //填写简历页面
//@property(nonatomic,strong)MbRecruitmentViewController* recruitmentVC;//填写招聘信息
//@property(nonatomic,strong)MbEnterpriseinformationViewController* enterInformationVC;    //填写企业信息
//@property(nonatomic,strong)MbCityListViewController* cityList;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布";
    self.cityName = @"北京市";
    if (ScreenHeight==480) {
        //求职简历
        self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenHeight/10, ScreenHeight/20-5, ScreenHeight/5, ScreenHeight/5)];
        [self.btn1 setBackgroundColor:[UIColor colorWithRed:44/255.0 green:214/255.0 blue:202/255.0 alpha:1]];
        [self.btn1 addTarget:self action:@selector(jianli:) forControlEvents:UIControlEventTouchUpInside];
        self.btn1.userInteractionEnabled = YES;
        self.btn1.layer.cornerRadius = ScreenHeight/10;
        self.btn1.layer.masksToBounds = YES;
        [self.view addSubview:self.btn1];
        
        self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.btn1.frame.size.width/3, self.btn1.frame.size.width/5, self.btn1.frame.size.width/2.5, self.btn1.frame.size.width/2.5)];
        self.imageView1.image = [UIImage imageNamed:@"home_1_icon2.png"];
        [self.btn1 addSubview:self.imageView1];
        
        self.label1 = [UILabel new];
        self.label1.text = @"求职简历";
        self.label1.textColor = [UIColor whiteColor];
        self.label1.font = [UIFont systemFontOfSize:labelText];
        CGSize label1Size = [self.label1.text sizeWithFont:self.label1.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        self.label1.frame = CGRectMake(0, 0, label1Size.width, label1Size.height);
        self.label1.center = CGPointMake(self.btn1.frame.size.width/2, CGRectGetMaxY(self.imageView1.frame)+15);
        [self.btn1 addSubview:self.label1];
        //职位招聘
        self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenHeight/10, ScreenHeight/5+ScreenHeight/10-7, ScreenHeight/5, ScreenHeight/5)];
        [self.btn2 setBackgroundColor:[UIColor colorWithRed:0 green:224/255.0 blue:249/255.0 alpha:1]];
        [self.btn2 addTarget:self action:@selector(zhaopin:) forControlEvents:UIControlEventTouchUpInside];
        self.btn2.userInteractionEnabled = YES;
        self.btn2.layer.cornerRadius = ScreenHeight/10;
        self.btn2.layer.masksToBounds = YES;
        [self.view addSubview:self.btn2];
        
        
        self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.btn2.frame.size.width*3/10, self.btn2.frame.size.width/5, self.btn2.frame.size.width/2.5, self.btn2.frame.size.width/2.5)];
        self.imageView2.image = [UIImage imageNamed:@"home_1_icon1.png"];
        [self.btn2 addSubview:self.imageView2];
        
        self.label2 = [UILabel new];
        self.label2.text = @"职位招聘";
        self.label2.textColor = [UIColor whiteColor];
        self.label2.font = [UIFont systemFontOfSize:labelText];
        CGSize label2Size = [self.label2.text sizeWithFont:self.label2.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        self.label2.frame = CGRectMake(0, 0, label2Size.width, label2Size.height);
        self.label2.center = CGPointMake(self.btn2.frame.size.width/2, CGRectGetMaxY(self.imageView2.frame)+15);
        [self.btn2 addSubview:self.label2];
        
        //企业信息
        self.btn3 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenHeight/10, ScreenHeight/2.5+ScreenHeight/20*3-10, ScreenHeight/5, ScreenHeight/5)];
        [self.btn3 setBackgroundColor:[UIColor colorWithRed:74/255.0 green:121/255.0 blue:247/255.0 alpha:1]];
        [self.btn3 addTarget:self action:@selector(xinxi:) forControlEvents:UIControlEventTouchUpInside];
        self.btn3.userInteractionEnabled = YES;
        self.btn3.layer.cornerRadius = ScreenHeight/10;
        self.btn3.layer.masksToBounds = YES;
        [self.view addSubview:self.btn3];
        
        
        self.imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(self.btn3.frame.size.width*3/10, self.btn3.frame.size.width/5, self.btn3.frame.size.width/2.5, self.btn3.frame.size.width/2.5)];
        self.imageView3.image = [UIImage imageNamed:@"home_1_icon3.png"];
        [self.btn3 addSubview:self.imageView3];
        
        self.label3 = [UILabel new];
        self.label3.text = @"企业信息";
        self.label3.textColor = [UIColor whiteColor];
        self.label3.font = [UIFont systemFontOfSize:labelText];
        CGSize label3Size = [self.label3.text sizeWithFont:self.label3.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        self.label3.frame = CGRectMake(0, 0, label3Size.width, label3Size.height);
        self.label3.center = CGPointMake(self.btn3.frame.size.width/2, CGRectGetMaxY(self.imageView3.frame)+15);
        [self.btn3 addSubview:self.label3];
    }else{
        
        
        //求职简历
        self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenHeight/10, ScreenHeight/20, ScreenHeight/5, ScreenHeight/5)];
        [self.btn1 setBackgroundColor:[UIColor colorWithRed:44/255.0 green:214/255.0 blue:202/255.0 alpha:1]];
        [self.btn1 addTarget:self action:@selector(jianli:) forControlEvents:UIControlEventTouchUpInside];
        self.btn1.userInteractionEnabled = YES;
        self.btn1.layer.cornerRadius = ScreenHeight/10;
        self.btn1.layer.masksToBounds = YES;
        [self.view addSubview:self.btn1];
        
        self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.btn1.frame.size.width/3, self.btn1.frame.size.width/5, self.btn1.frame.size.width/2.5, self.btn1.frame.size.width/2.5)];
        self.imageView1.image = [UIImage imageNamed:@"home_1_icon2.png"];
        [self.btn1 addSubview:self.imageView1];
        
        self.label1 = [UILabel new];
        self.label1.text = @"求职简历";
        self.label1.textColor = [UIColor whiteColor];
        self.label1.font = [UIFont systemFontOfSize:labelText];
        CGSize label1Size = [self.label1.text sizeWithFont:self.label1.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        self.label1.frame = CGRectMake(0, 0, label1Size.width, label1Size.height);
        self.label1.center = CGPointMake(self.btn1.frame.size.width/2, CGRectGetMaxY(self.imageView1.frame)+15);
        [self.btn1 addSubview:self.label1];
        //职位招聘
        self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenHeight/10, ScreenHeight/5+ScreenHeight/10, ScreenHeight/5, ScreenHeight/5)];
        [self.btn2 setBackgroundColor:[UIColor colorWithRed:0 green:224/255.0 blue:249/255.0 alpha:1]];
        [self.btn2 addTarget:self action:@selector(zhaopin:) forControlEvents:UIControlEventTouchUpInside];
        self.btn2.userInteractionEnabled = YES;
        self.btn2.layer.cornerRadius = ScreenHeight/10;
        self.btn2.layer.masksToBounds = YES;
        [self.view addSubview:self.btn2];
        
        
        self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.btn2.frame.size.width*3/10, self.btn2.frame.size.width/5, self.btn2.frame.size.width/2.5, self.btn2.frame.size.width/2.5)];
        self.imageView2.image = [UIImage imageNamed:@"home_1_icon1.png"];
        [self.btn2 addSubview:self.imageView2];
        
        self.label2 = [UILabel new];
        self.label2.text = @"职位招聘";
        self.label2.textColor = [UIColor whiteColor];
        self.label2.font = [UIFont systemFontOfSize:labelText];
        CGSize label2Size = [self.label2.text sizeWithFont:self.label2.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        self.label2.frame = CGRectMake(0, 0, label2Size.width, label2Size.height);
        self.label2.center = CGPointMake(self.btn2.frame.size.width/2, CGRectGetMaxY(self.imageView2.frame)+15);
        [self.btn2 addSubview:self.label2];
        
        //企业信息
        self.btn3 = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenHeight/10, ScreenHeight/2.5+ScreenHeight/20*3, ScreenHeight/5, ScreenHeight/5)];
        [self.btn3 setBackgroundColor:[UIColor colorWithRed:74/255.0 green:121/255.0 blue:247/255.0 alpha:1]];
        [self.btn3 addTarget:self action:@selector(xinxi:) forControlEvents:UIControlEventTouchUpInside];
        self.btn3.userInteractionEnabled = YES;
        self.btn3.layer.cornerRadius = ScreenHeight/10;
        self.btn3.layer.masksToBounds = YES;
        [self.view addSubview:self.btn3];
        
        
        self.imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(self.btn3.frame.size.width*3/10, self.btn3.frame.size.width/5, self.btn3.frame.size.width/2.5, self.btn3.frame.size.width/2.5)];
        self.imageView3.image = [UIImage imageNamed:@"home_1_icon3.png"];
        [self.btn3 addSubview:self.imageView3];
        
        self.label3 = [UILabel new];
        self.label3.text = @"企业信息";
        self.label3.textColor = [UIColor whiteColor];
        self.label3.font = [UIFont systemFontOfSize:labelText];
        CGSize label3Size = [self.label3.text sizeWithFont:self.label3.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        self.label3.frame = CGRectMake(0, 0, label3Size.width, label3Size.height);
        self.label3.center = CGPointMake(self.btn3.frame.size.width/2, CGRectGetMaxY(self.imageView3.frame)+15);
        [self.btn3 addSubview:self.label3];
        
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    
}

//求职简历
-(void)jianli:(UIButton*)sender{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        
        HZNewEditResumeViewController *resumeVC = [[HZNewEditResumeViewController alloc]init];
        resumeVC.hidesBottomBarWhenPushed = YES;
        resumeVC.cityName = self.cityName;
        [self presentVC:resumeVC];
    }
}
//职位招聘
-(void)zhaopin:(UIButton*)sender{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        HZRecruitmentViewController *recruitmentVC = [[HZRecruitmentViewController alloc]init];
        
        recruitmentVC.cityName = self.cityName;
        [self presentVC:recruitmentVC];
    }
}
////企业信息
-(void)xinxi:(UIButton*)sender{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        HZEnterpriseinformationViewController  *enterInformationVC = [[HZEnterpriseinformationViewController alloc]init];
        enterInformationVC.cityName = self.cityName;
        [self presentVC:enterInformationVC];
    }
}


@end
