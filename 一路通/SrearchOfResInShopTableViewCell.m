//
//  SrearchOfResInShopTableViewCell.m
//  一路通
//
//  Created by 杨森林 on 17/2/27.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "SrearchOfResInShopTableViewCell.h"

@implementation SrearchOfResInShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.goShopBtn.layer.cornerRadius = 4;
    self.shopNameLab.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
