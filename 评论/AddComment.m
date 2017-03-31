//
//  AddComment.m
//  一路通
//
//  Created by Yangsl on 2017/3/28.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "AddComment.h"

@implementation AddComment

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)changeBtnSelect:(UIButton *)sender
{
    UIButton * oneBtn = (UIButton *)[self viewWithTag:100];
     UIButton * twoBtn = (UIButton *)[self viewWithTag:101];
     UIButton * threeBtn = (UIButton *)[self viewWithTag:102];
    if (sender.tag == 100) {

            sender.selected = YES;
            twoBtn.selected = NO;
            threeBtn.selected = NO;
    }
    if (sender.tag == 101) {

            sender.selected = YES;
            oneBtn.selected = NO;
            threeBtn.selected = NO;

    }
    if (sender.tag == 102) {

            sender.selected = YES;
            twoBtn.selected = NO;
            oneBtn.selected = NO;
    }
 
}
@end
