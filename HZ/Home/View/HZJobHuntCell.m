//
//  HZJobHuntCell.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZJobHuntCell.h"

@interface HZJobHuntCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *wageLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation HZJobHuntCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HZJobModel *)model{
    self.titleLabel.text = model.title;
    self.addressLabel.text = model.address;
    self.descLabel.text = model.company;
    self.jobLabel.text = model.position;
    self.wageLabel.text = model.wages;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.rectime.integerValue];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt  setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [fmt stringFromDate:date];
    self.timeLabel.text = time;
}

- (void)setResumeModel:(HZResumeModel *)resumeModel{
    self.titleLabel.text = resumeModel.username;
    NSString *sex = [resumeModel.sex isEqualToString:@"1"]? @"男" : @"女";
    NSString *desc = [NSString stringWithFormat:@"%@   %@   %@   %@",sex,resumeModel.age,resumeModel.diploma,resumeModel.experience];
    self.addressLabel.text = resumeModel.title;
    self.jobLabel.text = desc;
    self.descLabel.text = resumeModel.title;
    self.wageLabel.text = resumeModel.wages;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:resumeModel.restime.integerValue];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt  setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [fmt stringFromDate:date];
    self.timeLabel.text = time;
}

+(CGFloat)cellHeight{
    return 93;
}
@end
