//
//  News.h
//  一路通
//
//  Created by 杨森林 on 17/3/1.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (nonatomic,strong)NSMutableArray * newsArr;
@property (nonatomic,strong)NSMutableArray * movieArr;
@property(nonatomic,strong)NSMutableArray * otherArr;
- (NSMutableArray *)newsArr;
- (NSMutableArray *)movieArr;

- (NSMutableArray *)otherArr;

@end
