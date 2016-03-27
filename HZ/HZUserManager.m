//
//  HZUserModel.m
//  HZ
//
//  Created by hongjunxiao on 16/3/27.
//  Copyright © 2016年 ihj. All rights reserved.
//

#import "HZUserManager.h"

@interface HZUserManager (){
    NSString *_name;
    NSString *_passwd;
    NSString *_userid;
}

@end

@implementation HZUserManager

+ (instancetype)manager{
    return [[self class] new];
}

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


- (NSString *)userid{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"];
}

- (void)setUserid:(NSString *)userid{
    _userid = [userid copy];
    [[NSUserDefaults standardUserDefaults] setValue:userid forKey:@"passwd"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
