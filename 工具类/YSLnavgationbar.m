//
//  YSLnavgationbar.m
//  一路通
//
//  Created by 杨森林 on 17/2/27.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "YSLnavgationbar.h"
#import "PubDefine.h"
@implementation YSLnavgationbar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 40, 40)];
        self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 15, 40, 40)];
        [self addSubview:_rightBtn];
        [self addSubview:_leftBtn];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
