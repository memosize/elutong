//
//  RescueTableViewCell.m
//  一路通
//
//  Created by 杨森林 on 17/2/14.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "RescueTableViewCell.h"

@implementation RescueTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.chargeLab.adjustsFontSizeToFitWidth = YES;
//    self.openLab.adjustsFontSizeToFitWidth = YES;
//    self.elecCarLab.adjustsFontSizeToFitWidth = YES;
//    self.motoBycleLab.adjustsFontSizeToFitWidth = YES;
    self.rescueBtn.layer.borderWidth = 0.5;
    self.rescueBtn.layer.cornerRadius = 4;
    self.rescueBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.navigateBtn.layer.borderWidth = 0.5;
    self.navigateBtn.layer.cornerRadius = 4;
    self.navigateBtn.layer.borderColor = [UIColor grayColor].CGColor;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)rescue:(UIButton *)sender {
}

- (IBAction)navigate:(UIButton *)sender {
}
@end
