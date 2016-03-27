//
//  HZLoginViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "HZLoginViewController.h"
#import "HZRegistViewController.h"
#import "HZFindPassWordViewController.h"
@interface HZLoginViewController ()<UIAlertViewDelegate>
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
@property(nonatomic,strong)UIButton* loginBtn;
@property(nonatomic,strong)UIButton* registBtn;
@property(nonatomic,strong)UIButton* forgetBtn;
@property(nonatomic,strong)UIView* view1;
@property(nonatomic,strong)UIImageView* logo;
@property(nonatomic,strong)NSString* string;
@property(nonatomic,assign)NSInteger* userid;
@end

@implementation HZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的账号";
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self custonSubviews];
    [self attachBackButton];
    
}

-(void)custonSubviews{
    //白色背景
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 10, ScreenWidth - 30, 91)];
    self.view1.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.view1];
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth-30, 1)];
    self.line1.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    [self.view1 addSubview:self.line1];
    

    self.userNameImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12.5, 20, 20)];
    self.userNameImage.image = [UIImage imageNamed:@"zhanghu.png"];
    [self.view1 addSubview:self.userNameImage];

//    
    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userNameImage.frame)+10, 10, ScreenWidth/3*2, 25)];
    self.nameField.textColor = [UIColor blackColor];
    self.nameField.font = [UIFont systemFontOfSize:labelText];
     self.nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameField.placeholder = @"用户名/手机号";
    [self.nameField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
   [self.nameField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.nameField];
    

//    
    self.passWordImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.line1.frame) + 12.5, 20, 20)];
    self.passWordImage.image = [UIImage imageNamed:@"tubiao.png"];
    [self.view1 addSubview:self.passWordImage];

//    
    self.passWordField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.passWordImage.frame)+10, CGRectGetMaxY(self.line1.frame) + 10, ScreenWidth/3*2, 25)];
    self.passWordField.textColor = [UIColor blackColor];
    self.passWordField.font = [UIFont systemFontOfSize:labelText];
    self.passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passWordField.secureTextEntry = YES;
    self.passWordField.placeholder = @"请输入密码";
    [self.passWordField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.passWordField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.passWordField];
    //新用户注册
    self.registBtn = [[UIButton alloc]init];
    self.registBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    self.registBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    
     CGSize size = [self.registBtn.titleLabel.text sizeWithFont:self.registBtn.titleLabel.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByCharWrapping];
    
      self.registBtn.frame = CGRectMake(15, CGRectGetMaxY(self.view1.frame)+10, size.width, size.height);
    [self.registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registBtn];
    
    //忘记密码
    self.forgetBtn = [[UIButton alloc]init];
    [self.forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[self.forgetBtn setBackgroundColor:[UIColor whiteColor]];
    self.forgetBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    
   
    self.forgetBtn.frame = CGRectMake(ScreenWidth - 15 - size.width, CGRectGetMaxY(self.view1.frame)+10, size.width, size.height);
    [self.forgetBtn addTarget:self action:@selector(forget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetBtn];
    
    
    //登录按钮
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 180, ScreenWidth-40, 40)];
    //[self.loginBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:166/255.0 blue:238/255.0 alpha:1]];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"home_6_btn1.png"] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"home_6_btn1_col.png"] forState:UIControlStateSelected];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.layer.cornerRadius = 20;
    self.loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.loginBtn];

    
   
    
    
    
    
    
    //LOGO
    self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/4, CGRectGetMaxY(self.loginBtn.frame)+20, ScreenWidth/2, ScreenWidth/2/1.2)];
    self.logo.image = [UIImage imageNamed:@"LOGO.png"];
    
    [self.view addSubview:self.logo];
    

}
//登录
-(void)loginBtn:(UIButton*)sender{
    //手机号验证正则表达式
    NSString *regex = @"^((1[0-9][0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self.nameField.text];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
      
    }else if (self.passWordField.text.length==0){
    
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }else{
    
        [JZQHttpTools postWithPath:login params:@{@"telephone":self.nameField.text,@"password":self.passWordField.text}
                           success:^(id JSON)
         {
             self.string = JSON[@"return"];
             if ([JSON[@"return"] isEqualToString:@"200"]) {
//                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:JSON[@"msg"] message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
//                 
//                 [alert show];
                 NSDictionary* dic = JSON[@"data"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"userid"] forKey:@"userid"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"telephone"] forKey:@"telephone"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [self dismissViewControllerAnimated:YES completion:nil];
          
                 
             }else if ([JSON[@"return"] isEqualToString:@"3000"]){
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                 [alert show];
             
             }else if ([JSON[@"return"] isEqualToString:@"300"]){
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:JSON[@"msg"] message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                 [alert show];
                 
             }
    
         }
                           failure:^(NSError *error)
         {
             NSLog(@"error:%@",[error localizedDescription]);
         }];
    }


}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([self.string isEqualToString:@"200"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
    }
    
    

}

//新用户注册
-(void)registBtn:(UIButton*)sender{
    HZRegistViewController *registVC = [[HZRegistViewController alloc]init];
//    [self.navigationController pushViewController:registVC animated:YES];
    [self presentViewController:[[HZNavigationController alloc] initWithRootViewController:registVC] animated:YES completion:nil];

}
////忘记密码
-(void)forget:(UIButton*)sender{
    HZFindPassWordViewController *vc  = [[HZFindPassWordViewController alloc]init];
     [self presentViewController:[[HZNavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];

}
@end
