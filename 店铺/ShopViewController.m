//
//  ShopViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/21.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "ShopViewController.h"
#import "PubDefine.h"
#import <AFNetworking.h>
#import "ShopTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    YUSegment *segment;
    UIView * proView;
    UIView * maintainView;
    UIView * commentView;
    UIPickerView * pickView;
    UIButton * categoryBtn;
    UIButton * sorrtBtn;
    UIButton * cateBtn;
    UIButton * sortBtn;
    UITableView * proTB;
    UITableView * maintainTB;
    UITableView * commTB;
    NSMutableArray * shopImageUrlArr;
    NSMutableArray * contentArr;
    NSMutableArray * shopNameArr;
    UIImageView * logoView;
}

@end

@implementation ShopViewController
 - (void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightButton)];
    self.navigationController.navigationItem.rightBarButtonItem = rightButton;
    [self.navigationController.navigationItem setTitle:@"sss"];
        [self initdata];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    [self performSelector:@selector(initView) withObject:self afterDelay:3];
    [self initView];
    }
- (void)initView
{
    NSLog(@"%@",shopImageUrlArr);
    self.view.backgroundColor = [UIColor whiteColor];
    logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 220)];
    [self.view addSubview:logoView];

    NSArray *titles = @[@"产品", @"维修", @"评价"];
    segment = [[YUSegment alloc] initWithTitles:titles];

    segment.frame = (CGRect){20, 283, [UIScreen mainScreen].bounds.size.width - 40, 44};
        [segment addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segment];
    proView = [[UIView alloc] initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, SCREEN_HEIGHT)];
    maintainView = [[UIView alloc] initWithFrame:CGRectMake(- SCREEN_HEIGHT, 400, SCREEN_WIDTH, SCREEN_HEIGHT)];
    commentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 400, SCREEN_WIDTH, SCREEN_HEIGHT)];
    categoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    [categoryBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    [categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sorrtBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 + 30, 10, 100, 30)];
    [sorrtBtn setTitle:@"智能排序" forState:UIControlStateNormal];
    [sorrtBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cateBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    [cateBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    [cateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sortBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 + 30, 10, 100, 30)];
    [sortBtn setTitle:@"智能排序" forState:UIControlStateNormal];
    [sortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    proTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT)];
    proTB.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    proTB.delegate = self;
//    proTB.dataSource = self;
    maintainTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    maintainTB.delegate = self;
//    maintainTB.dataSource = self;
    maintainTB.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    commTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
//    commTB.delegate = self;
//    commTB.dataSource = self;
    commTB.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [commentView addSubview:commTB];
    [self.view addSubview:commentView];
    [self.view addSubview:maintainView];
    [self.view addSubview:proView];
    [proView addSubview:proTB];
    [proView addSubview:sortBtn];
    [proView addSubview:cateBtn];
    [maintainView addSubview:maintainTB];
    [maintainView addSubview:sorrtBtn];
    [maintainView addSubview:categoryBtn];
}
- (void)initdata
{
    shopImageUrlArr = [NSMutableArray array];
    shopNameArr = [NSMutableArray array];
    shopNameArr = [NSMutableArray array];
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=seller";
    NSString * goodsListUrl = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_list";
    NSString * commentUrl = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=seller_comment";
    NSDictionary * commentParm = @{@"seller_id":self.shopId};
    NSDictionary * goodsParm = @{@"seller_id":self.shopId};
    NSDictionary * parm = [[NSDictionary alloc] initWithObjectsAndKeys:self.shopId,@"id", nil];
    
    [session GET:urlStr parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject)
        {
        NSLog(@"response = %@",responseObject);
        
            NSDictionary * prodic = [NSDictionary dictionaryWithDictionary:[responseObject valueForKey:@"data"]];
       
             [shopNameArr addObject:[prodic valueForKey:@"shopName"]];
              [shopImageUrlArr addObject:[prodic valueForKey:@"logo"]];
             [contentArr addObject:[prodic valueForKey:@"content"]];
    
//
//        NSArray * dataArr = [NSArray arrayWithArray:[responseObject valueForKey:@"data"]];
//        for (NSObject * obj in dataArr) {
//            NSLog(@"%@",[obj valueForKey:@"detail"]);
//            NSLog(@"%@",[obj valueForKey:@"status"]);
//        }
        [proTB reloadData];
            if (shopImageUrlArr.count > 0) {
                [logoView sd_setImageWithURL:[NSURL URLWithString:shopImageUrlArr[0]]];

            }
        NSLog(@"%d",shopImageUrlArr.count);
    }
        else{
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"暂无相关商品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
     
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        
    }];
    [session GET:goodsListUrl parameters:goodsParm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail -- ");
    }];
    //评论
    [session GET:commentUrl parameters:commentParm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"comRes = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];

}
- (void)changeView:(UISegmentedControl *)sengment
{
    
    NSInteger index = segment.selectedIndex;
    switch (index) {
        case 0:
        {
            proView.center = CGPointMake(0.5 * SCREEN_WIDTH, 400 + 0.5 * maintainView.frame.size.height);
            maintainView.center = CGPointMake(-1000, 0.5 * maintainView.frame.size.height);
            commentView.center = CGPointMake(-1000, 0.5 * maintainView.frame.size.height);

        }
            break;
        case 1:
        {
            maintainView.center = CGPointMake(0.5 * SCREEN_WIDTH, 400 + 0.5 * maintainView.frame.size.height);
            proView.center = CGPointMake(-0.5 * SCREEN_WIDTH, 0.5 * maintainView.frame.size.height);
            commentView.center = CGPointMake(-0.5 * SCREEN_WIDTH, 0.5 * maintainView.frame.size.height);

        }
            break;
        case 2:
        {
            commentView.center = CGPointMake(0.5 * SCREEN_WIDTH, 400 + 0.5 * maintainView.frame.size.height);
            proView.center = CGPointMake(-1000, 0.5 * maintainView.frame.size.height);
            maintainView.center = CGPointMake(-1000, 0.5 * maintainView.frame.size.height);

        }
            break;
            
        default:
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellid = @"shop";
    ShopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopTableViewCell" owner:nil options:nil]lastObject];
        cell.contentLab.text = contentArr[indexPath.row];
        
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return shopNameArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
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
