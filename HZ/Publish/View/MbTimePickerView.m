//
//  MbTimePickerView.m
//  Recruitment
//
//  Created by tusm on 15/12/4.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbTimePickerView.h"
@interface MbTimePickerView()
{
    UILabel* _titleLabel;      //请选择时间
    UILabel* _line;            //横线
    UILabel* _line2;
    SRMonthPicker *_monthPicker; //时间抓取器
    NSString *_datePickerDate; //时间
}
@end



@implementation MbTimePickerView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self onCreate];
    }
    return self;
}
- (NSString*)formatDate:(NSDate *)date
{
    // A convenience method that formats the date in Month-Year format
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM y";
    return [formatter stringFromDate:date];
}
#pragma mark 建立控件
-(void)onCreate
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 40)];
    _titleLabel.text = @"选择时间";
    _titleLabel.textColor = [UIColor blackColor];
 
    _titleLabel.font = [UIFont systemFontOfSize:labelText];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:_titleLabel];
    
    //横线
    _line = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, ScreenWidth, 1)];
    _line.backgroundColor = [UIColor colorWithRed:247/255.0 green:113/255.0 blue:111/255.0 alpha:1];
    [self addSubview:_line];
    
    
    
    _monthPicker = [[SRMonthPicker alloc]init];
    _monthPicker.frame = CGRectMake(0, 41, ScreenWidth, 216);
    _monthPicker.monthPickerDelegate = self;
    
    _monthPicker.maximumYear = @2120;
    _monthPicker.minimumYear = @1900;
    _monthPicker.yearFirst = YES;
    _monthPicker.tag = 6003;
    [self addSubview:_monthPicker];
    
//横线2
    _line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-105, ScreenWidth, 1)];
    _line2.backgroundColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
    [self addSubview:_line2];
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    //cancelBtn.frame = CGRectMake(0, 0, selectView.frame.size.height, selectView.frame.size.height);
    //cancelBtn.center = CGPointMake(selectView.frame.size.width / 10, selectView.center.y);
    cancelBtn.frame = CGRectMake(0, self.frame.size.height-104, ScreenWidth/2, 40);
    cancelBtn.tag = 6004;
    [self addSubview:cancelBtn];
    //确定按钮
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [ensureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ensureBtn.titleLabel.font = [UIFont systemFontOfSize:labelText];
    //ensureBtn.frame = CGRectMake(0, 0, selectView.frame.size.height, selectView.frame.size.height);
    //ensureBtn.center = CGPointMake(selectView.frame.size.width - selectView.frame.size.width / 10, selectView.center.y);
    ensureBtn.frame = CGRectMake(ScreenWidth/2, self.frame.size.height-104, ScreenWidth/2, 40);
    ensureBtn.tag = 6005;
    [self addSubview:ensureBtn];

    
    
    
}
@end