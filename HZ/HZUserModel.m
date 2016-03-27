//
//  HZUserModel.m
//  HZ
//
//  Created by hongjunxiao on 16/3/27.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZUserModel.h"

@interface HZUserModel (){
    NSString *_name;
    NSString *_passwd;
}

@end

@implementation HZUserModel

-(void)setName:(NSString *)name{
    _name = [name copy];
    [[NSUserDefaults standardUserDefaults] setValue:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSString *)name{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
}


-(void)setPasswd:(NSString *)passwd{
    _passwd = [passwd copy];
    [[NSUserDefaults standardUserDefaults] setValue:passwd forKey:@"passwd"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSString *)passwd{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"passwd"];
}


@end
