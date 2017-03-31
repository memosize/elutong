//
//  LoginState.m
//  一路通
//
//  Created by 杨森林 on 17/2/26.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "LoginState.h"

@implementation LoginState
+ (LoginState *)LoginedPerson
{
    static LoginState *loginState = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        loginState = [[self alloc] init];
        
    });
    return loginState;
}
@end
