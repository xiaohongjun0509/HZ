//
//  HZEducationalExperienceViewController.m
//  Recruitment
//
//  Created by tusm on 15/12/4.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "HZEducationalExperienceViewController.h"

#import "MbTimePickerView.h"
#import "MbPickerView.h"
#import "SRMonthPicker.h"
#import "HZEditDetailStudyModel.h"
@interface HZEducationalExperienceViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIButton *_ensureBtn;      //确定按钮
    UIButton *_cancelBtn;      //取消按钮
    SRMonthPicker *_datePicker; //时间选择器
     NSString *_datePickerDate; //时间
}
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* list;
@property(nonatomic,strong)MbPickerView* pickerView;
@property(nonatomic,strong)MbTimePickerView* timePickerView;
@property(nonatomic,strong)UITextField* schoolField;       //填写学校名称
@property(nonatomic,strong)UITextField* professional;      //填写专业
@property(nonatomic,strong)UILabel* mustChoice;            //必选
@property(nonatomic,strong)UIButton* seleteBtn;
@property(nonatomic,strong)NSString* degree;               //学历
@property(nonatomic,strong)NSString* startTime;            //开始时间
@property(nonatomic,strong)NSString* endTime;              //结束时间
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,strong)NSMutableArray* array1;
@property(nonatomic,strong)NSMutableArray* array2;
@property(nonatomic,strong)NSMutableDictionary* dic;

@end

@implementation HZEducationalExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"教育经历";
    self.list = @[@"入学时间",@"毕业时间",@"学校名称",@"学       历",@"专       业"];
    self.array1 = [NSMutableArray array];
    self.array2 = [NSMutableArray array];
    self.dic = [[NSMutableDictionary alloc]init];
    self.startTime = nil;
    self.endTime = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    //选择时间视图
    [self initWithPickView];
    //学历视图
    [self initPickView];
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
        
        self.seleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
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
        
        
       
        
    }else if (indexPath.row==1) {
        
        self.seleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
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
            self.mustChoice.frame = CGRectMake(ScreenWidth - size.width - 35, 22-size.height/2, size.width, size.height);
            //[cell addSubview:self.mustChoice];
            //输入框
            
            self.schoolField = [[UITextField alloc]initWithFrame:CGRectMake(90, 0, ScreenWidth - 125, 44)];
            self.schoolField.placeholder = @"必填";
            if (self.array1.count>0) {
                self.schoolField.text = [self.array1 lastObject];
            }else if(self.array1.count==0){
                self.schoolField.placeholder = @"必填";
                
            }
            self.schoolField.returnKeyType = UIReturnKeyDone;
            self.schoolField.delegate = self;
            self.schoolField.textAlignment = NSTextAlignmentRight;
            self.schoolField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            self.schoolField.font = [UIFont systemFontOfSize:labelText];
            [self.schoolField setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
            [self.schoolField setValue:[UIColor colorWithRed:159/255.0 green:159/255.0 blue:164/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
            [cell addSubview:self.schoolField];
        }else if (indexPath.row==3){
            
            self.seleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
            [self.seleteBtn setBackgroundColor:[UIColor clearColor]];
            self.seleteBtn.userInteractionEnabled = YES;
            self.seleteBtn.tag = 1;
            [self.seleteBtn addTarget:self action:@selector(seleteBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:self.seleteBtn];
            if (self.degree==nil) {
                cell.detailTextLabel.text = @"必选";
                
            }else{
                cell.detailTextLabel.text = self.degree;
                cell.detailTextLabel.textColor = [UIColor blackColor];
            }

            

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.row==4){
    
    
        self.mustChoice = [[UILabel alloc]init];
        self.mustChoice.text = @"选填";
        self.mustChoice.font = [UIFont systemFontOfSize:labelText];
        CGSize size = [self.mustChoice.text sizeWithFont:self.mustChoice.font constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByCharWrapping];
        self.mustChoice.textColor = [UIColor colorWithRed:162/255.0 green:162/255.0 blue:166/255.0 alpha:1];
        self.mustChoice.frame = CGRectMake(ScreenWidth - size.width - 35, 0, size.width, 44);
        //[cell addSubview:self.mustChoice];
        
        
        
        //输入框
        self.professional = [[UITextField alloc]initWithFrame:CGRectMake(90, 22-size.height/2, ScreenWidth - 125, size.height)];
          self.professional.placeholder = @"选填";
        if (self.array2.count>0) {
            self.professional.text = [self.array2 lastObject];
        }else{
            self.professional.placeholder = @"选填";
            
        }
        self.professional.returnKeyType = UIReturnKeyDone;
        self.professional.font = [UIFont systemFontOfSize:labelText];
        self.professional.delegate = self;
        self.professional.textAlignment = NSTextAlignmentRight;
        self.professional.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.professional setValue:[UIFont systemFontOfSize:labelText] forKeyPath:@"_placeholderLabel.font"];
        [self.professional setValue:[UIColor colorWithRed:159/255.0 green:159/255.0 blue:164/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [cell addSubview:self.professional];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;

}


#pragma mark 初始化学历选择器
-(void)initPickView{
    //弹出视图
    self.pickerView = [[MbPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 326)];
    self.pickerView.userInteractionEnabled = YES;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    _cancelBtn = (UIButton*)[self.pickerView viewWithTag:6001];
    _ensureBtn = (UIButton*)[self.pickerView viewWithTag:6002];
    [_cancelBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [_ensureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pickerView];
}


#pragma mark 初始化选择时间视图
-(void)initWithPickView
{
    //弹出视图
    self.timePickerView = [[MbTimePickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 347)];
    self.timePickerView.backgroundColor = [UIColor whiteColor];
    self.timePickerView.userInteractionEnabled = YES;
     _datePicker = (SRMonthPicker *)[self.timePickerView viewWithTag:6003];
    _cancelBtn = (UIButton *)[self.timePickerView viewWithTag:6004];
    _ensureBtn = (UIButton *)[self.timePickerView viewWithTag:6005];
    [_ensureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    //[_datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.timePickerView];
}
#pragma mark 赋值给日期
- (void)chooseDate:(UIDatePicker *)sender
{
    if (sender == _datePicker)
    {
        NSDate *selectedDate = sender.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM";
        _datePickerDate = [formatter stringFromDate:selectedDate];
       
        //[_titleText setTitle:_datePickerDate forState:UIControlStateNormal];
    }
}
//时间弹框
-(void)seleteBtn:(UIButton*)sender{
     self.tag = sender.tag;
    
    if (sender.tag==1) {
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

        if (self.seleteBtn.selected == NO) {
            self.seleteBtn.selected = YES;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect _smallHidden = self.pickerView.frame;
                _smallHidden.origin.y = ScreenHeight - _smallHidden.size.height;
                self.pickerView.frame =_smallHidden;
            }
                             completion:^(BOOL finished)
             {
                 self.pickerView.hidden = NO;
                 CGRect _smallHidden = self.pickerView.frame;
                 _smallHidden.origin.y = ScreenHeight - _smallHidden.size.height;
                 self.pickerView.frame = _smallHidden;
             }];
            
            
        }else if (self.seleteBtn.selected == YES){
            self.seleteBtn.selected = NO;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect _smallHidden = self.pickerView.frame;
                _smallHidden.origin.y = 347 + _smallHidden.size.height;
                self.pickerView.frame =_smallHidden;
            }
                             completion:^(BOOL finished)
             {
                 self.pickerView.hidden = YES;
                 CGRect _smallHidden = self.pickerView.frame;
                 _smallHidden.origin.y = 347 + _smallHidden.size.height;
                 self.pickerView.frame = _smallHidden;
             }];
            
        }

    }else if (sender.tag==2){
        self.seleteBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect _smallHidden = self.pickerView.frame;
            _smallHidden.origin.y = 347 + _smallHidden.size.height;
            self.pickerView.frame =_smallHidden;
        }
                         completion:^(BOOL finished)
         {
             self.pickerView.hidden = YES;
             CGRect _smallHidden = self.pickerView.frame;
             _smallHidden.origin.y = 347 + _smallHidden.size.height;
             self.pickerView.frame = _smallHidden;
         }];

        
        
        
        if (self.seleteBtn.selected == NO) {
            self.seleteBtn.selected = YES;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect _smallHidden = self.timePickerView.frame;
                _smallHidden.origin.y = ScreenHeight - _smallHidden.size.height;
                self.timePickerView.frame =_smallHidden;
            }
                             completion:^(BOOL finished)
             {
                 self.timePickerView.hidden = NO;
                 CGRect _smallHidden = self.timePickerView.frame;
                 _smallHidden.origin.y = ScreenHeight - _smallHidden.size.height;
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
        
        self.seleteBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect _smallHidden = self.pickerView.frame;
            _smallHidden.origin.y = 347 + _smallHidden.size.height;
            self.pickerView.frame =_smallHidden;
        }
                         completion:^(BOOL finished)
         {
             self.pickerView.hidden = YES;
             CGRect _smallHidden = self.pickerView.frame;
             _smallHidden.origin.y = 347 + _smallHidden.size.height;
             self.pickerView.frame = _smallHidden;
         }];
        
        
        if (self.seleteBtn.selected == NO) {
            self.seleteBtn.selected = YES;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect _smallHidden = self.timePickerView.frame;
                _smallHidden.origin.y = ScreenHeight - _smallHidden.size.height;
                self.timePickerView.frame =_smallHidden;
            }
                             completion:^(BOOL finished)
             {
                 self.timePickerView.hidden = NO;
                 CGRect _smallHidden = self.timePickerView.frame;
                 _smallHidden.origin.y = ScreenHeight - _smallHidden.size.height;
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

    [self.schoolField resignFirstResponder];
        [self.professional resignFirstResponder];

}
//确定选择时间
-(void)sure:(UIButton*)sender{
   
    
    if (sender.tag==6002) {
        //获取pickerView上的值
        NSInteger row=[self.pickerView.pickerView selectedRowInComponent:0];
        self.degree = [self.pickerView.list objectAtIndex:row];
        
        self.seleteBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect _smallHidden = self.pickerView.frame;
            _smallHidden.origin.y = 326 + _smallHidden.size.height;
            self.pickerView.frame =_smallHidden;
        }
                         completion:^(BOOL finished)
         {
             self.pickerView.hidden = YES;
             CGRect _smallHidden = self.pickerView.frame;
             _smallHidden.origin.y = 326 + _smallHidden.size.height;
             self.pickerView.frame = _smallHidden;
         }];
        
    

    
    
    }else if (sender.tag==6005){
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
    
    [self.array1 addObject:self.schoolField.text];
    [self.array2 addObject:self.professional.text];
    
    [self.tableView reloadData];
   
    
    
    
   
}
//取消时间弹框
-(void)cancle:(UIButton*)sender{
    
    if (sender.tag==6001) {
 
        self.seleteBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect _smallHidden = self.pickerView.frame;
            _smallHidden.origin.y = 326 + _smallHidden.size.height;
            self.pickerView.frame =_smallHidden;
        }
                         completion:^(BOOL finished)
         {
             self.pickerView.hidden = YES;
             CGRect _smallHidden = self.pickerView.frame;
             _smallHidden.origin.y = 326 + _smallHidden.size.height;
             self.pickerView.frame = _smallHidden;
         }];

    }else if (sender.tag==6004){
    
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

#pragma mark 触摸屏幕回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark textfield收起键盘方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (ScreenHeight==480&&[self.professional isEditing]) {
        CGRect frame = textField.frame;
        int offset = frame.origin.y + 32 - (ScreenHeight - 494.0);//键盘高度216
   
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0)
            self.tableView.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];

    }
    
    
    }
#pragma mark 编辑之后frame弹回
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.tableView.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight);
}



//完成
-(void)done{
    
    if (self.startTime.length==0||self.endTime.length==0||self.schoolField.text.length==0||self.degree.length==0) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
    
    [self.dic setObject:self.schoolField.text forKey:@"school"];
    [self.dic setObject:self.degree forKey:@"degree"];
    [self.dic setObject:self.startTime forKey:@"startTime"];
    [self.dic setObject:self.endTime forKey:@"endTime"];
    [self.dic setObject:self.professional.text forKey:@"professional"];
        
    
    HZEditDetailStudyModel *model = [[HZEditDetailStudyModel alloc]init];
    model.school = self.schoolField.text;
    model.degree = self.degree;
    model.startTime = self.startTime;
    model.endTime = self.endTime;
    model.professional = self.professional.text;
    [self.item.studyList addObject:model];
    [self dismissViewControllerAnimated:YES completion:nil];

    }
}
    @end
