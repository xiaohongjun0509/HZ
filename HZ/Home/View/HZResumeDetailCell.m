//
//  HZResumeDetailCell.m
//  HZ
//
//  Created by hongjunxiao on 16/3/29.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZResumeDetailCell.h"

@implementation HZResumeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (CGFloat)cellHeight:(NSString *)content{
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(ScreenWidth - 102 - 15, 1000)];
    return size.height + 28;
}

@end
