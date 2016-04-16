//
//  MbEnterpriseTableViewCell.m
//  Recruitment
//
//  Created by tusm on 15/11/2.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbEnterpriseTableViewCell.h"
@interface MbEnterpriseTableViewCell()

@end

@implementation MbEnterpriseTableViewCell
@synthesize delegate;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{


    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.array = @[@"钢结构一",@"钢结构二",@"钢结构三",@"钢结构四",@"钢结构五",@"钢结构六",@"钢结构七",@"钢结构八",@"......."];
        
      //公司名称
        self.nameLabel = [[UILabel alloc]init];
        //self.nameLabel.text = @"浙江广发建设发展有限公司";
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.font = [UIFont systemFontOfSize:labelText+2];

        [self addSubview:self.nameLabel];
        
        //地区
        self.placeLabel = [[UILabel alloc]init];
        //self.placeLabel.text = @"朝阳";
        self.placeLabel.font = [UIFont systemFontOfSize:labelText];
        [self addSubview:self.placeLabel];
        //日期
        self.dateLabel = [[UILabel alloc]init];
        //self.dateLabel.text = @"2015-06-01";
        self.dateLabel.font = [UIFont systemFontOfSize:labelText-1];
        [self addSubview:self.dateLabel];
        
      _finalH = CGRectGetMaxY(self.dateLabel.frame) + 10;
    }
    return self;
    
}
- (void)loadContent:(MbUserInfo*)data{

    self.nameLabel.text = data.company;
    
    CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(viewWidth-30, 400) lineBreakMode:NSLineBreakByWordWrapping];
    self.nameLabel.frame = CGRectMake(15, 10, viewWidth-30, nameSize.height);
    self.placeLabel.text = data.area;
    CGSize placeSize = [self.placeLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:labelText]}];
    self.placeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.nameLabel.frame) + 15, placeSize.width, placeSize.height);
    
    
    
    NSTimeInterval time=[data.comtime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    self.dateLabel.text = currentDateStr;
    CGSize dateSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(300, 300) lineBreakMode:NSLineBreakByWordWrapping];
    self.dateLabel.frame = CGRectMake(viewWidth-15-dateSize.width, CGRectGetMaxY(self.nameLabel.frame)+15, dateSize.width, dateSize.height);
     _finalH = CGRectGetMaxY(self.dateLabel.frame) + 10;
}
@end
