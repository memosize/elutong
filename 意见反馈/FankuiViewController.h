//
//  FankuiViewController.h
//  一路通
//
//  Created by 杨森林 on 17/2/27.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FankuiViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *suggestTf;
@property (strong, nonatomic) IBOutlet UIButton *suggetSubBtn;
@property (strong, nonatomic) IBOutlet UITextField *complaintTF;
@property (strong, nonatomic) IBOutlet UIButton *complaintBtn;

@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@end
