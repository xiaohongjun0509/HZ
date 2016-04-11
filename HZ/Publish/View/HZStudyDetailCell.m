//
//  HZStudyDetailCell.m
//  HZ
//
//  Created by hongjunxiao on 16/4/10.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZStudyDetailCell.h"

@interface HZStudyDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *xueli;
@property (weak, nonatomic) IBOutlet UILabel *zhuanye;

@end

@implementation HZStudyDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-  (void)setModel:(HZEditDetailStudyModel *)model{
    _model = model;
    if(self.isStudy){
        self.timeLabel.text =[NSString stringWithFormat:@"%@ - %@",model.startTime, model.endTime];
        self.school.text = [NSString stringWithFormat:@"学校  %@",model.school];
        
        self.xueli.text = [NSString stringWithFormat:@"学历  %@",model.degree];
        self.zhuanye.text = [NSString stringWithFormat:@"专业  %@", model.professional];
    }else{
        self.timeLabel.text =[NSString stringWithFormat:@"%@ - %@",model.startTime, model.endTime];
        self.school.text = [NSString stringWithFormat:@"公司  %@",model.school];
        
        self.xueli.text = [NSString stringWithFormat:@"职位  %@",model.degree];
        self.zhuanye.text = [NSString stringWithFormat:@"工作内容  %@", model.professional];
    }
    
    
    
}

@end
