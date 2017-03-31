//
//  PurTableViewCell.m
//  一路通
//
//  Created by 杨森林 on 17/2/24.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "PurTableViewCell.h"
@implementation PurTableViewCell
{
    NSInteger count ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
//    count = [self.priceTf.text integerValue];
    count = 0;
    self.num = 0;
    self.num = count;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
//    self.contentView.backgroundColor = [UIColor redColor];
}
- (IBAction)add:(UIButton *)sender {

    count ++;
    self.priceTf.text = [NSString stringWithFormat:@"%ld",(long)count];

    
}
- (IBAction)minus:(UIButton *)sender{
    if (count > 0) {
        count --;
    }
     self.priceTf.text = [NSString stringWithFormat:@"%ld",(long)count];
}



@end
