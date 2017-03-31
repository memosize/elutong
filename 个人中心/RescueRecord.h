//
//  RescueRecord.h
//  一路通
//
//  Created by Yangsl on 2017/3/25.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RescueRecord.h"
@interface RescueRecord : NSObject
@property(nonatomic,strong)NSString * shopName;
@property(nonatomic,strong)NSString * distance;
@property(nonatomic,strong)NSString * address;
@property(nonatomic,strong)NSString * maintainer;//维修员
@property(nonatomic,strong)NSString * number;//维修员电话
@property(nonatomic,strong)NSString * waittime;//等待时间
@property(nonatomic,strong)NSString * ordertime;//下单时间
@property(nonatomic,strong)NSString * maintaincost;//维修费用
@property(nonatomic,strong)NSString * sumcost;  //总费用
@property(nonatomic,strong)NSString * chargemethod;//支付方式
@property(nonatomic,strong)NSString * chargestatus;//支付状态
@property(nonatomic, strong)NSString * rescue_id;//救援id


@end
