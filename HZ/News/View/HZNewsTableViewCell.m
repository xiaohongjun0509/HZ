//
//  MbNewsTableViewCell.m
//  好筑
//
//  Created by tusm on 16/2/4.
//  Copyright (c) 2016年 Zs. All rights reserved.
//

#import "HZNewsTableViewCell.h"

@implementation HZNewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //标题图片
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(viewWidth-viewWidth/4-15, 15, viewWidth/4, viewWidth/4/4*3)];
        self.image.image = [UIImage imageNamed:@"1.png"];
        [self addSubview:self.image];
        
    //标题
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = @"习近平唔克里：妥善处理重要国际问题";
        self.titleLabel.font = [UIFont systemFontOfSize:labelText];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(viewWidth/4*3-45, 3000) lineBreakMode:NSLineBreakByCharWrapping];
        self.titleLabel.frame = CGRectMake(15, 15, titleSize.width, titleSize.height);
        [self addSubview:self.titleLabel];
        
    }

    return self;

}

+(CGFloat)cellHeight{
    return 90;
}

@end
