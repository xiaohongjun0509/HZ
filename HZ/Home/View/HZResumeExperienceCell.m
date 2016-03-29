//
//  HZResumeExperienceCell.m
//  HZ
//
//  Created by hongjunxiao on 16/3/29.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZResumeExperienceCell.h"

@implementation HZResumeExperienceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HZResumeExperienceModel *)model{
    self.timeLabel.text = [NSString stringWithFormat:@"%@  -  %@",model.intervalstart, model.intervalstop];
    self.schoolLabel.text = [NSString stringWithFormat:@"学校 %@", model.school];
    self.xueliLabel.text = [NSString stringWithFormat:@"专科 %@",model.level];
    self.zhuanyeLabel.text = [NSString stringWithFormat:@"专业 %@",model.specialty];
}



- (void)setBussModel:(HZResumeBusinessModel *)model{
    self.timeLabel.text = [NSString stringWithFormat:@"%@  -  %@",model.timestart, model.timestop];
    self.schoolLabel.text = [NSString stringWithFormat:@"公司 %@", model.corporate];
    self.xueliLabel.text = [NSString stringWithFormat:@"职位 %@",model.position];
    self.zhuanyeLabel.text = [NSString stringWithFormat:@"工作内容 %@",model.content];
}

+ (CGFloat)cellHeight{
    return 128;
}

@end
