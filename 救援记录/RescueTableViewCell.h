//
//  RescueTableViewCell.h
//  一路通
//
//  Created by 杨森林 on 17/2/14.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RescueTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *shopImageView;//店铺图片
@property (strong, nonatomic) IBOutlet UILabel *carLab;//交通工具
@property (strong, nonatomic) IBOutlet UILabel *addLab;
@property (strong, nonatomic) IBOutlet UILabel *disLab;
@property (strong, nonatomic) IBOutlet UILabel *numLaB;
@property (strong, nonatomic) IBOutlet UILabel *openLab;
@property (strong, nonatomic) IBOutlet UILabel *chargeLab;
@property (strong, nonatomic) IBOutlet UILabel *elecCarLab;
@property (strong, nonatomic) IBOutlet UIButton *rescueBtn;
@property (strong, nonatomic) IBOutlet UIButton *navigateBtn;
@property (strong, nonatomic) IBOutlet UILabel *motoBycleLab;

- (IBAction)rescue:(UIButton *)sender;
- (IBAction)navigate:(UIButton *)sender;




@end
