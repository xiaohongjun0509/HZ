//
//  MbModifyViewController.m
//  好筑
//
//  Created by tusm on 16/2/1.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import "MbModifyViewController.h"

#import "MbPaser.h"
#import "HZLoginViewController.h"
@interface MbModifyViewController ()<UITextFieldDelegate,UIAlertViewDelegate>


@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UIImageView* headImage;    //账号
@property(nonatomic,strong)UILabel* telePhone;
@property(nonatomic,strong)UITextField* telePhoneField;

@property(nonatomic,strong)UIImageView* oldImage;    //旧密码
@property(nonatomic,strong)UILabel* oldName;
@property(nonatomic,strong)UITextField* oldField;

@property(nonatomic,strong)UIImageView* neImage;     //新密码
@property(nonatomic,strong)UILabel* nePassWord;
@property(nonatomic,strong)UITextField* nePassWordField;

@property(nonatomic,strong)UIImageView* sureImage;   //确认新密码
@property(nonatomic,strong)UILabel* surePassWord;
@property(nonatomic,strong)UITextField* surePassWordField;

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

@property(nonatomic,strong)UIButton* sureBtn;          //确认修改
@end

@implementation MbModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
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
    
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 10, viewWidth-30, 138)];
    self.view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.view1];
    
    
  
    
    self.line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, viewWidth-30, 1)];
    self.line2.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    [self.view1 addSubview:self.line2];
    
    self.line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 89, viewWidth-30, 1)];
    self.line3.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1];
    [self.view1 addSubview:self.line3];
    
    
   
    self.oldImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.line1.frame) + 12.5, 20, 20)];
    self.oldImage.image = [UIImage imageNamed:@"yanzhengma.png"];
    [self.view1 addSubview:self.oldImage];
    
    
    self.oldField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.oldImage.frame)+10,CGRectGetMaxY(self.line1.frame) + 10, (self.view1.frame.size.width-70)/3*2, 25)];
    self.oldField.textColor = [UIColor blackColor];
    self.oldField.font = [UIFont systemFontOfSize:labelText];
    self.oldField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.oldField.placeholder = @"请输入旧密码";
    self.oldField.secureTextEntry = YES;
    self.oldField.delegate = self;
    [self.oldField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.oldField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.oldField];
    

    
    self.neImage = [[UIImageView alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(self.line2.frame) + 12.5, 20, 20)];
    self.neImage.image = [UIImage imageNamed:@"tubiao.png"];
    [self.view1 addSubview:self.neImage];
    

    
    self.nePassWordField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.neImage.frame) + 10,CGRectGetMaxY(self.line2.frame) + 10, (self.view1.frame.size.width-45)/3*2, 25)];
    self.nePassWordField.textColor = [UIColor blackColor];
    self.nePassWordField.font = [UIFont systemFontOfSize:labelText];
    self.nePassWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nePassWordField.placeholder = @"请输入新密码";
    self.nePassWordField.secureTextEntry = YES;
    self.nePassWordField.delegate = self;
    [self.nePassWordField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.nePassWordField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.nePassWordField];
    
    

    
    self.sureImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.line3.frame) + 12.5, 20, 20)];
    self.sureImage.image = [UIImage imageNamed:@"tubiao.png"];
    [self.view1 addSubview:self.sureImage];
    
 
    
    self.surePassWordField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sureImage.frame)+10, CGRectGetMaxY(self.line3.frame) + 10, viewWidth/3*2, 25)];
    
    self.surePassWordField.textColor = [UIColor blackColor];
    self.surePassWordField.font = [UIFont systemFontOfSize:labelText];
    self.surePassWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.surePassWordField.secureTextEntry = YES;
    self.surePassWordField.placeholder = @"确认新密码";
    self.surePassWordField.delegate = self;
    [self.surePassWordField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
    [self.surePassWordField setValue:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view1 addSubview:self.surePassWordField];

 
    self.sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 216, viewWidth-40, 40)];
    
   
    [self.sureBtn setBackgroundImage:[UIImage imageNamed:@"home_6_btn1.png"] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundImage:[UIImage imageNamed:@"home_6_btn1_col.png"] forState:UIControlStateSelected];
    
    //[self.sureBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:166/255.0 blue:238/255.0 alpha:1]];
    [self.sureBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(sureBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.sureBtn.layer.cornerRadius = 20;
    self.sureBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.sureBtn];
    
    //logo
    
  
    self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth/4, CGRectGetMaxY(self.sureBtn.frame)+20, viewWidth/2, viewWidth/2/1.2)];
    self.logo.image = [UIImage imageNamed:@"LOGO.png"];
    
    [self.view addSubview:self.logo];
    
  
    
    
    
}
//确认修改
-(void)sureBtn:(UIButton*)sender{
    [MbPaser modifyPassWordByPhone:self.telePhoneField.text oldWord:self.oldField.text newWordOne:self.nePassWordField.text newWordTwo:self.surePassWordField.text result:^(ModifyPassWordResponse *response, NSError *error) {
        if (response) {
                    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:response.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alertView.tag = response.turn;
                    [alertView show];
        }
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==200) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"telephone"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self dismissModalViewControllerAnimated:YES];
    }else{
    
    
    }

}

#pragma mark 触摸屏幕回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    [self.telePhoneField resignFirstResponder];
    [self.oldField resignFirstResponder];
    [self.nePassWordField resignFirstResponder];
    [self.surePassWordField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
