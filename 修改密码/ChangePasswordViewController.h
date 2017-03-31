//
//  ChangePasswordViewController.h
//  一路通
//
//  Created by 杨森林 on 17/3/10.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *nnewPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *surePwdTF;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)confirm:(UIButton *)sender;


@end
