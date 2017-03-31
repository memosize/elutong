//
//  CenterTabbarViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/7.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "CenterTabbarViewController.h"

#import "SearchViewController.h"
#import "LoginViewController.h"
#import "LeftTableViewCell.h"
#import "LoginState.h"
#import <UIImageView+WebCache.h>
#import "LeftViewController.h"
#import "IndexViewController.h"
#import "PubDefine.h"
#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>
@interface CenterTabbarViewController ()<UISearchBarDelegate,clickDelegate,UIAlertViewDelegate>
{
    UISearchBar * searchBar;
    UITableView * leftTableView;
    NSArray * itemArry;
    NSMutableArray * imageArray;
    UILabel * nameLab;
    UIImageView * iconImageView;
    UIView * leftView;

    
}

@end

@implementation CenterTabbarViewController
- (void)viewWillAppear:(BOOL)animated
{
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];

//    self.navigationController.navigationBarHidden = YES;
    LeftViewController * left = [[LeftViewController alloc] init];
    left.delegate = self;
   }

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"nav (3)"] forState:UIControlStateNormal];
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(300, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"nav (6)"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.8 alpha:0.4];

    //1、设置导航栏的按钮

    
    //3、添加两个手指双击手势
    UITapGestureRecognizer * twoFingerDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerDoubleTap:)];
    //3.1、双击
    [twoFingerDoubleTap setNumberOfTapsRequired:2];
    //3.2、两个手指  默认为一个
    [twoFingerDoubleTap setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:twoFingerDoubleTap];
    [[UITabBar appearance] setBackgroundColor:[UIColor grayColor]];//设置tabbar背景颜色
}

-(void)leftBtn{
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(void)rightBtn{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

/**
 *  添加点击手势  一个手指双击
 */
-(void)doubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

/**
 *  添加点击手势  两个个手指双击
 */
-(void)twoFingerDoubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideRight completion:nil];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    SearchViewController * searchVC = [[SearchViewController alloc] init];
//    [[SlideNavigationController sharedInstance]switchToViewController:searchVC withCompletion:nil];
    [searchBar resignFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [searchBar resignFirstResponder];
}

- (void)initIcon
{
    if ([LoginState LoginedPerson].iconStr) {
        NSLog(@"initIcon");
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 64, 100, 100)];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:[LoginState LoginedPerson].iconStr]];
        [self.view addSubview:iconImageView];
    }
}
- (void)initUsername
{
    if ([LoginState LoginedPerson].nameStr) {
        
        nameLab = [[UILabel alloc ] initWithFrame:CGRectMake(120, 80, 60, 20)];
        nameLab.text =  [LoginState LoginedPerson].nameStr;
        [self.view addSubview:nameLab];
    }
}
//- (void)shouAlert
//{
//    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"退出当前账号？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    [alertView show];
//}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isExit"]) {
        NSLog(@"改变");
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"退出当前账号？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self loginOut];
        [LoginState LoginedPerson].isLogin = NO;
    }
    else{
        return;
    }
    
}
- (void)loginOut
{
    
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
