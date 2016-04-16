//
//  UIImageView+Extension.m
//  HZ
//
//  Created by hongjunxiao on 16/3/26.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)
- (void)setImageUrl:(NSString *)url{
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}
@end
