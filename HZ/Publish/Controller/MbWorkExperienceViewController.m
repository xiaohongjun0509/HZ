//
//  MbWorkExperienceViewController.m
//  Recruitment
//
//  Created by tusm on 15/12/4.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbWorkExperienceViewController.h"

#import "SRMonthPicker.h"
#import "MbTimePickerView.h"
@interface MbWorkExperienceViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIButton *_ensureBtn;      //确定按钮
    UIButton *_cancelBtn;      //取消按钮
    SRMonthPicker *_datePicker; //时间选择器
    NSString *_datePickerDate; //时间
}
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* list;
@property(nonatomic,strong)MbTimePickerView* timePickerView;
@property(nonatomic,strong)UIButton* seleteBtn;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,strong)NSString* startTime;            //开始时间
@property(nonatomic,strong)NSString* endTime;              //结束时间
@property(nonatomic,strong)UITextField* companyField;      //填写公司名称
@property(nonatomic,strong)UITextField* position;          //填写专业
@property(nonatomic,strong)UITextField* inforField;        //工作内容
@property(nonatomic,strong)UILabel* mustChoice;            //必选
@property(nonatomic,strong)NSMutableArray* array1;
@property(nonatomic,strong)NSMutableArray* array2;
@property(nonatomic,strong)NSMutableArray* array3;
@property(nonatomic,strong)NSMutableDictionary* dic;
@end

@implementation MbWorkExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作经历";
    self.list = @[@"入职时间",@"离职时间",@"公司名称",@"职       位",@"工作内容"];
    self.array1 = [NSMutableArray array];
    self.array2 = [NSMutableArray array];
    self.dic = [[NSMutableDictionary alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    //选择时间视图
    [self initWithPickView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.list.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifire = @"Cell";
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.userInteractionEnabled = YES;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
    }
    cell.textLabel.text = [self.list objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:labelText];
    cell.textLabel.font = [UIFont systemFontOfSize:labelText];
    
    if(indexPath.row==0){
        self.seleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 44)];
        [self.seleteBtn setBackgroundColor:[UIColor clearColor]];
        self.seleteBtn.userInteractionEnabled = YES;
        self.seleteBtn.tag = 2;
        [self.seleteBtn addTarget:self action:@selector(seleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.seleteBtn];
        if (self.startTime==nil) {
            cell.detailTextLabel.text = @"必选";
            
        }else{
            cell.detailTextLabel.text = self.startTime;
            cell.detailTextLabel.textColor = [UIColor blackColor];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
        
    }else if (indexPath.row==1){
        
        self.seleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 44)];
        [self.seleteBtn setBackgroundColor:[UIColor clearColor]];
        self.seleteBtn.userInteractionEnabled = YES;
        self.seleteBtn.tag = 3;
        [self.seleteBtn addTarget:self action:@selector(seleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.seleteBtn];
        
        if (self.endTime==nil) {
            cell.detailTextLabel.text = @"必选";
            
        }else{
            cell.detailTextLabel.text = self.endTime;
            cell.detailTextLabel.textColor = [UIColor blackColor];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  

    }else if (indexPath.row==2){
        self.mustChoice = [[UILabel alloc]init];
        self.mustChoice.text = @"必填";
        self.mustChoice.font = [UIFont systemFontOfSize:labelText];
        CGSize size = [self.mustChoice.text sizeWithFont:self.mustChoice.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByCharWrapping];
        self.mustChoice.textColor = [UIColor colorWithRed:162/255.0 green:162/255.0 blue:166/255.0 alpha:1];
        self.mustChoice.frame = CGRectMake(viewWidth - size.width - 35, 22-size.height/2, size.width, size.height);
        //[cell addSubview:self.mustChoice];
        //输入框
        self.companyField = [[UITextField alloc]initWithFrame:CGRectMake(90, 0, viewWidth - 125, 44)];
        self.companyField.placeholder = @"必填";
        self.companyField.returnKeyType = UIReturnKeyDone;
        if (self.array1.count>0) {
            self.companyField.text = [self.array1 lastObject];
        }else if (self.array1.count==0){
            self.companyField.placeholder = @"必填";
            
        }
        self.companyField.font = [UIFont systemFontOfSize:labelText];
        self.companyField.delegate = self;
        self.companyField.textAlignment = NSTextAlignmentRight;
        self.companyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.companyField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
        [self.companyField setValue:[UIColor colorWithRed:159/255.0 green:159/255.0 blue:164/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [cell addSubview:self.companyField];
    }else if (indexPath.row==3){
        self.mustChoice = [[UILabel alloc]init];
        self.mustChoice.text = @"必填";
        self.mustChoice.font = [UIFont systemFontOfSize:labelText];
        CGSize size = [self.mustChoice.text sizeWithFont:self.mustChoice.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByCharWrapping];
        self.mustChoice.textColor = [UIColor colorWithRed:162/255.0 green:162/255.0 blue:166/255.0 alpha:1];
        self.mustChoice.frame = CGRectMake(viewWidth - size.width - 35, 0, size.width, 44);
        //[cell addSubview:self.mustChoice];
        
        //输入框
        self.position = [[UITextField alloc]initWithFrame:CGRectMake(90, 22-size.height/2, viewWidth - 125, size.height)];
        self.position.placeholder = @"必填";
        self.position.returnKeyType = UIReturnKeyDone;
        if (self.array2.count>0) {
            self.position.text = [self.array2 lastObject];
        }else if (self.array2.count==0){
            
            self.position.placeholder = @"必填";
        }
        self.position.font = [UIFont systemFontOfSize:labelText];
        self.position.delegate = self;
        self.position.textAlignment = NSTextAlignmentRight;
        self.position.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.position setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
        [self.position setValue:[UIColor colorWithRed:159/255.0 green:159/255.0 blue:164/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [cell addSubview:self.position];
    }else if (indexPath.row==4){
    
        self.mustChoice = [[UILabel alloc]init];
        self.mustChoice.text = @"选填";
        self.mustChoice.font = [UIFont systemFontOfSize:labelText];
        CGSize size = [self.mustChoice.text sizeWithFont:self.mustChoice.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByCharWrapping];
        self.mustChoice.textColor = [UIColor colorWithRed:162/255.0 green:162/255.0 blue:166/255.0 alpha:1];
        self.mustChoice.frame = CGRectMake(viewWidth - size.width - 35, 22-size.height/2, size.width, size.height);
        //[cell addSubview:self.mustChoice];
        //输入框
        self.inforField = [[UITextField alloc]initWithFrame:CGRectMake(90, 0, viewWidth - 125, 44)];
        self.inforField.placeholder = @"选填";
        if (self.array3.count>0) {
            self.inforField.text = [self.array3 lastObject];
        }else if (self.array3.count==0){
            self.inforField.placeholder = @"选填";
            
        }
        self.inforField.returnKeyType = UIReturnKeyDone;
        self.inforField.font = [UIFont systemFontOfSize:labelText];
        self.inforField.delegate = self;
        self.inforField.textAlignment = NSTextAlignmentRight;
        self.inforField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.inforField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
        [self.inforField setValue:[UIColor colorWithRed:159/255.0 green:159/255.0 blue:164/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [cell addSubview:self.inforField];

    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
}

#pragma mark 初始化选择时间视图
-(void)initWithPickView
{
    //弹出视图
    self.timePickerView = [[MbTimePickerView alloc]initWithFrame:CGRectMake(0, viewHeight, viewWidth, 347)];
    self.timePickerView.backgroundColor = [UIColor whiteColor];
    self.timePickerView.userInteractionEnabled = YES;
    _datePicker = (SRMonthPicker *)[self.timePickerView viewWithTag:6003];
    _cancelBtn = (UIButton *)[self.timePickerView viewWithTag:6004];
    _ensureBtn = (UIButton *)[self.timePickerView viewWithTag:6005];
    [_ensureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timePickerView];
}

//时间弹框
-(void)seleteBtn:(UIButton*)sender{
    self.tag = sender.tag;
    
    if (sender.tag==2) {
     
        
        if (self.seleteBtn.selected == NO) {
            self.seleteBtn.selected = YES;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect _smallHidden = self.timePickerView.frame;
                _smallHidden.origin.y = viewHeight - _smallHidden.size.height;
                self.timePickerView.frame =_smallHidden;
            }
                             completion:^(BOOL finished)
             {
                 self.timePickerView.hidden = NO;
                 CGRect _smallHidden = self.timePickerView.frame;
                 _smallHidden.origin.y = viewHeight - _smallHidden.size.height;
                 self.timePickerView.frame = _smallHidden;
             }];
            
            
        }else if (self.seleteBtn.selected == YES){
            self.seleteBtn.selected = NO;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect _smallHidden = self.timePickerView.frame;
                _smallHidden.origin.y = 347 + _smallHidden.size.height;
                self.timePickerView.frame =_smallHidden;
            }
                             completion:^(BOOL finished)
             {
                 self.timePickerView.hidden = YES;
                 CGRect _smallHidden = self.timePickerView.frame;
                 _smallHidden.origin.y = 347 + _smallHidden.size.height;
                 self.timePickerView.frame = _smallHidden;
             }];
            
        }
        
    }else if (sender.tag==3){


        if (self.seleteBtn.selected == NO) {
            self.seleteBtn.selected = YES;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect _smallHidden = self.timePickerView.frame;
                _smallHidden.origin.y = viewHeight - _smallHidden.size.height;
                self.timePickerView.frame =_smallHidden;
            }
                             completion:^(BOOL finished)
             {
                 self.timePickerView.hidden = NO;
                 CGRect _smallHidden = self.timePickerView.frame;
                 _smallHidden.origin.y = viewHeight - _smallHidden.size.height;
                 self.timePickerView.frame = _smallHidden;
             }];
            
            
        }else if (self.seleteBtn.selected == YES){
            self.seleteBtn.selected = NO;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect _smallHidden = self.timePickerView.frame;
                _smallHidden.origin.y = 347 + _smallHidden.size.height;
                self.timePickerView.frame =_smallHidden;
            }
                             completion:^(BOOL finished)
             {
                 self.timePickerView.hidden = YES;
                 CGRect _smallHidden = self.timePickerView.frame;
                 _smallHidden.origin.y = 347 + _smallHidden.size.height;
                 self.timePickerView.frame = _smallHidden;
             }];
            
        }
        
        
    }
        
    [self.companyField resignFirstResponder];
     [self.position resignFirstResponder];
    [self.inforField resignFirstResponder];
    
}
//确定选择时间
-(void)sure:(UIButton*)sender{
    
    
        //获取pickerView上的值
//        NSInteger row=[self.pickerView.pickerView selectedRowInComponent:0];
//        self.degree = [self.pickerView.list objectAtIndex:row];
     if (sender.tag==6005){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM"];
        NSDate* date = _datePicker.date;
        if (self.tag==2) {
            self.startTime = [dateFormat stringFromDate:date];
        }else if (self.tag==3){
            
            self.endTime = [dateFormat stringFromDate:date];
        }
        
        self.seleteBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect _smallHidden = self.timePickerView.frame;
            _smallHidden.origin.y = 347 + _smallHidden.size.height;
            self.timePickerView.frame =_smallHidden;
        }
                         completion:^(BOOL finished)
         {
             self.timePickerView.hidden = YES;
             CGRect _smallHidden = self.timePickerView.frame;
             _smallHidden.origin.y = 347 + _smallHidden.size.height;
             self.timePickerView.frame = _smallHidden;
         }];
        
    }
    [self.array1 addObject:self.companyField.text];
    [self.array2 addObject:self.position.text];
    [self.array3 addObject:self.inforField.text];
    
    [self.tableView reloadData];
    
    
    
    
    
}
//取消时间弹框
-(void)cancle:(UIButton*)sender{
    
   if (sender.tag==6004){
        
        self.seleteBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect _smallHidden = self.timePickerView.frame;
            _smallHidden.origin.y = 347 + _smallHidden.size.height;
            self.timePickerView.frame =_smallHidden;
        }
                         completion:^(BOOL finished)
         {
             self.timePickerView.hidden = YES;
             CGRect _smallHidden = self.timePickerView.frame;
             _smallHidden.origin.y = 347 + _smallHidden.size.height;
             self.timePickerView.frame = _smallHidden;
         }];
        
    }
    
    
    
    
    
}
//保存
-(void)done{
    if (self.startTime.length==0||self.endTime.length==0||self.companyField.text.length==0||self.position.text.length==0) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
    [self.navigationController popViewControllerAnimated:YES];
    [self.dic setObject:self.companyField.text forKey:@"corporate"];
    [self.dic setObject:self.position.text forKey:@"position"];
    [self.dic setObject:self.startTime forKey:@"timestart"];
    [self.dic setObject:self.endTime forKey:@"timestop"];
        [self.dic setObject:self.inforField.text?self.inforField.text:@"" forKey:@"content"];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self.dic options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    self.resumeVC.jsonString2 = jsonString;
    self.resumeVC.workDic = self.dic;
    }
}
#pragma mark 触摸屏幕回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark textfield收起键盘方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.20];
        [UIView setAnimationBeginsFromCurrentState: YES];
        self.tableView.frame = CGRectMake(self.view.frame.origin.x, self.tableView.frame.origin.y - 70, self.tableView.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    
}
#pragma mark 编辑之后frame弹回
-(void)textFieldDidEndEditing:(UITextField *)textField
{

        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.20];
        [UIView setAnimationBeginsFromCurrentState: YES];
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y + 70, self.tableView.frame.size.width, self.tableView.frame.size.height);
        [UIView commitAnimations];

}
- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField == self.inforField) {
        if (textField.text.length > 60) {
            textField.text = [textField.text substringToIndex:60];
        }
    }}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    
//    [self.introduction resignFirstResponder];
//    return YES;
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
