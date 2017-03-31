//
//  Orders.h
//  一路通
//
//  Created by 杨森林 on 17/3/7.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Orders : NSObject
@property (strong, nonatomic)NSString * proName;
@property (strong, nonatomic)NSString * price;//单价
@property (strong, nonatomic)NSString * num;// 数量
@property (strong, nonatomic)NSString * sumPrice;//总价
@property (strong, nonatomic)NSString * proUrlStr;//图片地址

@end
