//
//  ShopCollectionViewCell.m
//  一路通
//
//  Created by 杨森林 on 17/2/22.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "ShopCollectionViewCell.h"

@implementation ShopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"ShopCollectionViewCell" owner:self options:nil].lastObject;
    }
  
    return self;
}

@end
