//
//  HZRegistViewController.m
//  Recruitment
//
//  Created by tusm on 15/10/27.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "HZRegistViewController.h"

@interface HZRegistViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UIImageView* userNameImage;   //账户
@property(nonatomic,strong)UILabel* userName;
@property(nonatomic,strong)UITextField* nameField;

@property(nonatomic,strong)UIImageView* passWordImage;   //验证码
@property(nonatomic,strong)UILabel* passWord;
@property(nonatomic,strong)UITextField* passWordField;

@property(nonatomic,strong)UIImageView* safeWordImage;   //密码
@property(nonatomic,strong)UILabel* safeWord;
@property(nonatomic,strong)UITextField* safeWordField;

@property(nonatomic,strong)UILabel* line1;
@property(nonatomic,strong)UILabel* line2;
@property(nonatomic,strong)UILabel* line3;
@property(nonatomic,strong)UILabel* line4;
@property(nonatomic,strong)UILabel* line5;
@property(nonatomic,strong)UILabel* line6;

@property(nonatomic,strong)UIButton* registBtn;
@property(nonatomic,strong)UIView* view1;
@property(nonatomic,strong)UIImageView* logo;
@property(nonatomic,strong)UIButton* getNumber;
@property(nonatomic,strong)NSTimer* timer;
@end
static int count = 60;
@implementation HZRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self onCreate];
    [self attachBackButton];
    
}

-(void)onCreate{
    
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 10, ScreenWidth-30, 137)];
    self.view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.view1];
    
    
    self.line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth-30, 1)];
    self.line1.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    [self.view1 addSubview:self.line1];
    
    self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 91, ScreenWidth-30, 1)];
    self.line2.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    [self.view1 addSubview:self.line2];
    

//    
    self.userNameImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12.5, 20, 20)];
    self.userNameImage.image = [UIImage imageNamed:@"zhanghu.png"];
    [self.view1 addSubview:self.userNameImage];

    
    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userNameImage.frame)+10,10, (self.view1.frame.size.width-70)/3*2, 25)];
    self.nameField.textColor = [UIColor blackColor];
    self.nameField.font = [UIFont systemFontOfSize:labelText];
    self.nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameField.placeholder = @"请输入手机号";
    [self.nameField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.nameField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.nameField];
    
    
    _getNumber = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getNumber setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getNumber.titleLabel.font = [UIFont systemFontOfSize:labelText - 2];
    //_getNumber.layer.borderWidth = 0.5;
    _getNumber.layer.cornerRadius = 5;
    _getNumber.layer.masksToBounds = YES;
    _getNumber.backgroundColor = [UIColor colorWithRed:52/255.0 green:122/255.0 blue:189/255.0 alpha:1];
    [_getNumber setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _getNumber.frame = CGRectMake(CGRectGetMaxX(self.nameField.frame)+10,10, (self.view1.frame.size.width-70)/3, 25);
    
    [_getNumber addTarget:self action:@selector(verify) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:_getNumber];
    

    
    self.passWordImage = [[UIImageView alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(self.line1.frame) + 12.5, 20, 20)];
    self.passWordImage.image = [UIImage imageNamed:@"yanzhengma.png"];
    [self.view1 addSubview:self.passWordImage];

    
    self.passWordField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.passWordImage.frame) + 10,CGRectGetMaxY(self.line1.frame) + 10, (self.view1.frame.size.width-45)/3*2, 25)];
    self.passWordField.textColor = [UIColor blackColor];
    self.passWordField.font = [UIFont systemFontOfSize:labelText];
    self.passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passWordField.placeholder = @"请输入验证码";
    [self.passWordField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.passWordField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.passWordField];
    

    
    self.safeWordImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.line2.frame) + 12.5, 20, 20)];
    self.safeWordImage.image = [UIImage imageNamed:@"tubiao.png"];
    [self.view1 addSubview:self.safeWordImage];

    
    self.safeWordField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.safeWordImage.frame)+10, CGRectGetMaxY(self.line2.frame) + 10, ScreenWidth/3*2, 25)];

    self.safeWordField.textColor = [UIColor blackColor];
    self.safeWordField.font = [UIFont systemFontOfSize:labelText];
    self.safeWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.safeWordField.secureTextEntry = YES;
    self.safeWordField.placeholder = @"请输入密码";
    [self.safeWordField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.safeWordField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.safeWordField];

      self.registBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 180, ScreenWidth-40, 40)];
    
    
    [self.registBtn setBackgroundImage:[UIImage imageNamed:@"home_6_btn1.png"] forState:UIControlStateNormal];
    [self.registBtn setBackgroundImage:[UIImage imageNamed:@"home_6_btn1_col.png"] forState:UIControlStateSelected];
    //[self.registBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:166/255.0 blue:238/255.0 alpha:1]];
    [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registB:) forControlEvents:UIControlEventTouchUpInside];
    self.registBtn.layer.cornerRadius = 20;
    self.registBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.registBtn];

        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/4, CGRectGetMaxY(self.registBtn.frame)+20, ScreenWidth/2, ScreenWidth/2/1.2)];
        self.logo.image = [UIImage imageNamed:@"LOGO.png"];
        
        [self.view addSubview:self.logo];
    
    //}
    
  
    
}
-(void)verify
{
    NSString *regex = @"^((1[0-9][0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self.nameField.text];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else{
    
    [JZQHttpTools postWithPath:CODE params:@{@"telephone":self.nameField.text}
                       success:^(id JSON)
     {
         self.timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
         [_getNumber setEnabled:NO];
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:JSON[@"msg"] message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
         [alert show];
         
         
     }
        failure:^(NSError *error)
     {
         NSLog(@"error:%@",[error localizedDescription]);
     }];

    }
    
    

}
#pragma mark 更新时间
-(void)updateTime
{
    
    if (count > 0) {
        [self.getNumber setTitle:[NSString stringWithFormat:@"%d秒重新获取", count] forState:UIControlStateDisabled];
        count--;
    } else {
        count = 60;
        [_timer invalidate];
        _timer = nil;
        [self.getNumber setTitle:@"60秒重新获取" forState:UIControlStateDisabled];
        [self.getNumber setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getNumber setEnabled:YES];
    }


}
//注册
-(void)registB:(UIButton*)sender{
   
        [JZQHttpTools postWithPath:regist params:@{@"telephone":self.nameField.text,@"code":self.passWordField.text,@"password":self.safeWordField.text}
                           success:^(id JSON)
         {
            
             
             if ([JSON[@"return"] isEqualToString:@"200"]) {
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:JSON[@"msg"] message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                 alert.tag=1;
                 [alert show];
             }else{
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:JSON[@"msg"] message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                 alert.tag=2;
                 [alert show];
                 
             }
         }
                           failure:^(NSError *error)
         {
             NSLog(@"error:%@",[error localizedDescription]);
         }];
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


@end
