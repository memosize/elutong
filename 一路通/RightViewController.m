//
//  RightViewController.m
//  侧滑菜单demo
//
//  Created by 杨森林 on 15/8/21.
//  Copyright (c) 2015年 Yangsl. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    SWRevealViewController * revealController = self.revealViewController;
//    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
//    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(160, 240, 40, 40)];
//    button.backgroundColor = [UIColor redColor];
//    [button addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
