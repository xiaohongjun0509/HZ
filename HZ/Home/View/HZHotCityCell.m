//
//  HZHotCityCell.m
//  HZ
//
//  Created by hongjunxiao on 16/4/25.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZHotCityCell.h"
#import "UIView+YYAdd.h"
@interface HZHotCityCell(){
    CGFloat width;
    CGFloat beginY;
}
@property (nonatomic, strong)NSArray *hotcity;
@end

@implementation HZHotCityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    width = (ScreenWidth - 70)/3;
    
    beginY = 20;
    self.hotcity = @[@"北京市",@"上海市",@"广州市",@"深圳市",@"杭州市",@"南京市",@"天津市",@"武汉市",@"重庆市"];
    [self.hotcity enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:obj forState:UIControlStateNormal];
        button.tag = 1000 + idx;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(update:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
    }];
}

- (void)update:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    NSString *city = self.hotcity[index];
    if(self.updateCity){
        self.updateCity(city);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat padding = 70 / 4;
    CGFloat height = 30;
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger col = idx % 3;
        NSInteger row = idx / 3;
        
        obj.left = padding * (col + 1) + col * width;
        
        obj.top = (1 + row) * padding + row * height;
        
        obj.width = width;
        
        obj.height = height;
    }];
}

@end
