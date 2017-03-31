//
//  NewsDetailViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/6.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <UIImageView+WebCache.h>

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLab.text = self.titleStr;
    self.timeLab.text = self.timeStr;
    self.contentLab.text = self.contentStr;
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
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
