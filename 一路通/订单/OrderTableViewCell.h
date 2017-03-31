//
//  OrderTableViewCell.h
//  一路通
//
//  Created by 杨森林 on 17/3/7.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *OrderNumLab;
@property (strong, nonatomic) IBOutlet UIImageView *proImageView;
@property (strong, nonatomic) IBOutlet UILabel *proNameLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *sumLab;
@property (strong, nonatomic) IBOutlet UILabel *totalLab;
@property (strong, nonatomic) IBOutlet UIButton *checkOrderBtn;
@property (strong, nonatomic) IBOutlet UIButton *payOrderBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteOrderBtn;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@end
