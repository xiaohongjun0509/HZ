//
//  MbZhaoBiaoTableViewCell.m
//  好筑
//
//  Created by tusm on 15/12/10.
//  Copyright (c) 2015年 Zs. All rights reserved.
//

#import "MbZhaoBiaoTableViewCell.h"

@interface MbZhaoBiaoTableViewCell()

@end

@implementation MbZhaoBiaoTableViewCell
@synthesize delegate;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //公司名称
        self.companyLabel = [UILabel new];
        self.companyLabel.text = @"金华市第二医院精神科病房楼改建项目—装修及暖通工程";
        self.companyLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1];
        self.companyLabel.numberOfLines = 0;
        self.companyLabel.font = [UIFont systemFontOfSize:labelText+2];
        CGSize size = [self.companyLabel.text sizeWithFont:self.companyLabel.font constrainedToSize:CGSizeMake(viewWidth - 30, viewWidth) lineBreakMode:NSLineBreakByWordWrapping];
        self.companyLabel.frame = CGRectMake(15, 7, size.width, size.height);
        [self addSubview:self.companyLabel];
        
        //时间
        self.dateLabel = [UILabel new];
        self.dateLabel.text = @"2016-01-01";
        self.dateLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        self.dateLabel.font = [UIFont systemFontOfSize:labelText];
        CGSize size1 = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(200, viewWidth - 30) lineBreakMode:NSLineBreakByWordWrapping];
        self.dateLabel.frame = CGRectMake(viewWidth - size1.width - 15, CGRectGetMaxY(self.companyLabel.frame)+10, size1.width, size1.height);
        [self addSubview:self.dateLabel];
        
        self.finalH = CGRectGetMaxY(self.dateLabel.frame)+10;
        
    }
    return self;
    
}

@end
