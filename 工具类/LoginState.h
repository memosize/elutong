//
//  LoginState.h
//  一路通
//
//  Created by 杨森林 on 17/2/26.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginState : NSObject
@property(nonatomic,assign)BOOL isLogin;
@property (nonatomic,strong)NSString * iconStr;
@property (nonatomic,strong)NSString * nameStr;
@property (nonatomic, assign)BOOL isExit;

+ (LoginState *)LoginedPerson;
@end
