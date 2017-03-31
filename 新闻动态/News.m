//
//  News.m
//  一路通
//
//  Created by 杨森林 on 17/3/1.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "News.h"

@interface News ()

@end

@implementation News
- (NSMutableArray *)newsArr
{
    if (_newsArr == nil) {
        _newsArr = [NSMutableArray array];
    }
    return _newsArr;
}
- (NSMutableArray *)movieArr
{
    if (_movieArr == nil) {
        _movieArr = [NSMutableArray array];
    }
    return _movieArr;
}
- (NSMutableArray *)otherArr
{
    if (_otherArr == nil) {
        _otherArr = [NSMutableArray array];
    }
    return _otherArr;
}

@end
