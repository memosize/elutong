//
//  Comment.h
//  一路通
//
//  Created by Yangsl on 2017/3/29.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (nonatomic, strong)NSString *date;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *mood;
@property (nonatomic, strong)NSString *iconUrl;
@property (nonatomic, strong)NSString *content;
@end
