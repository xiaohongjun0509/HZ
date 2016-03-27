//
//  HZLoginedViewController.m
//  好筑
//
//  Created by hongjunxiao on 16/2/1.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import "HZLoginedViewController.h"

@interface HZLoginedViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UIImageView* userNameImage;
@property(nonatomic,strong)UILabel* userName;
@property(nonatomic,strong)UITextField* nameField;

@property(nonatomic,strong)UIImageView* passWordImage;
@property(nonatomic,strong)UILabel* passWord;
@property(nonatomic,strong)UITextField* passWordField;

@property(nonatomic,strong)UILabel* line1;
@property(nonatomic,strong)UILabel* line2;
@property(nonatomic,strong)UILabel* line3;
@property(nonatomic,strong)UILabel* line4;
@property(nonatomic,strong)UIButton* modifyBtn;    //修改密码
@property(nonatomic,strong)UIButton* exitBtn;      //退出登录
@property(nonatomic,strong)UIView* view1;
@property(nonatomic,strong)UIImageView* logo;
//@property(nonatomic,strong)HZModifyViewController* modifyVC;
@end

@implementation HZLoginedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"登录";
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self onCreate];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏按钮的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}
-(void)onCreate{
    //白色背景
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 10, ScreenWidth - 30, 91)];
    self.view1.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.view1];
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth-30, 1)];
    self.line1.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    [self.view1 addSubview:self.line1];
    

    //
    self.userNameImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12.5, 20, 20)];
    self.userNameImage.image = [UIImage imageNamed:@"zhanghu.png"];
    [self.view1 addSubview:self.userNameImage];
    

    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userNameImage.frame)+10, 10, ScreenWidth/3*2, 25)];
    self.nameField.textColor = [UIColor blackColor];
    self.nameField.font = [UIFont systemFontOfSize:labelText];
    self.nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"telephone"];
    self.nameField.placeholder = @"用户名/手机号";
    [self.nameField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.nameField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.nameField];
    
  
    self.passWordImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.line1.frame) + 12.5, 20, 20)];
    self.passWordImage.image = [UIImage imageNamed:@"tubiao.png"];
    [self.view1 addSubview:self.passWordImage];

    self.passWordField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.passWordImage.frame)+10, CGRectGetMaxY(self.line1.frame) + 10, ScreenWidth/3*2, 25)];
    self.passWordField.textColor = [UIColor blackColor];
    self.passWordField.text = @"******";
    self.passWordField.font = [UIFont systemFontOfSize:labelText];
    self.passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passWordField.secureTextEntry = YES;
    //self.passWordField.placeholder = @"请输入密码";
    [self.passWordField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.passWordField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.passWordField];

    
    
    
    
    //修改密码
    self.modifyBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 130, ScreenWidth-40, 40)];
    [self.modifyBtn setBackgroundImage:[UIImage imageNamed:@"0002.png"] forState:UIControlStateNormal];
    [self.modifyBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [self.modifyBtn addTarget:self action:@selector(modifyBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.modifyBtn.layer.cornerRadius = 20;
    self.modifyBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.modifyBtn];
    
    
    //退出登录
    self.exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 190, ScreenWidth-40, 40)];
    [self.exitBtn setBackgroundImage:[UIImage imageNamed:@"0001.png"] forState:UIControlStateNormal];
    [self.exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.exitBtn addTarget:self action:@selector(exitBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.exitBtn.layer.cornerRadius = 20;
    self.exitBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.exitBtn];
    

    
    //LOGO
    self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/4, CGRectGetMaxY(self.exitBtn.frame)+20, ScreenWidth/2, ScreenWidth/2/1.2)];
    self.logo.image = [UIImage imageNamed:@"LOGO.png"];
    
    [self.view addSubview:self.logo];
    
}
//修改密码
-(void)modifyBtn:(UIButton*)sender{

//    self.modifyVC = [[HZModifyViewController alloc]init];
//    [self.navigationController pushViewController:self.modifyVC animated:YES];

}
//退出登录
-(void)exitBtn:(UIButton*)sender{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你确定退出账号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"telephone"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
    
    }



}
@end
