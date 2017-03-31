//
//  FankuiViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/27.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "FankuiViewController.h"

@interface FankuiViewController ()

@end

@implementation FankuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = [UIColor grayColor].CGColor;
    self.bgView.layer.cornerRadius = 4;
    self.closeBtn.layer.cornerRadius = 4;
    [self.closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
