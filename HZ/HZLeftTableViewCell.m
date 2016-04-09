//
//  HZLeftTableViewCell.m
//  HZ
//
//  Created by hongjunxiao on 16/4/9.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZLeftTableViewCell.h"

@implementation HZLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected){
        self.contentView.backgroundColor = HEXCOLOR(0xf6f6f6);
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

@end
