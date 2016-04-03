//
//  MbPickerView.m
//  Recruitment
//
//  Created by tusm on 15/12/4.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbPickerView.h"
@interface MbPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@end


@implementation MbPickerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.list = @[@"专科",@"本科",@"硕士",@"博士"];
        [self onCreate];
    }
    return self;
}
#pragma mark 建立控件

-(void)onCreate
{
    //选择学历
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 40)];
    label.text = @"选择学历";
    label.font = [UIFont systemFontOfSize:labelText];
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
    
    line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, 1)];
    line1.backgroundColor = [UIColor colorWithRed:247/255.0 green:114/255.0 blue:111/255.0 alpha:1];
    [self addSubview:line1];
    //pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 41, ScreenWidth, 180)];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self addSubview:self.pickerView];
    
    //横线2
    line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 221, ScreenWidth, 1)];
    line2.backgroundColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    [self addSubview:line2];
    
    //取消按钮
    self.cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 222, ScreenWidth/2, 40)];
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancleBtn.tag = 6001;
    [self addSubview:self.cancleBtn];
    //确定按钮
    self.sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2, 222, ScreenWidth/2, 40)];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    [self.sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.sureBtn.tag = 6002;
    [self addSubview:self.sureBtn];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.list.count;
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSString *name = self.list[row];
    
    return name;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        
        //pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:labelText]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
@end
