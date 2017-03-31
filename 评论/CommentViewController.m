//
//  CommentViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/10.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "CommentViewController.h"
#import <AFNetworking.h>
#import "CommentTableViewCell.h"
#import <UIImageView+WebCache.h>
#define PRO_COMMENT  @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_comment"
#define SHOP_COMMENT @"http://www.b1ss.com/index.php?m=goods&c=api&a=seller_comment"
#import "PubDefine.h"
@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * dateTimeArr;
    NSMutableArray * contentArr;
    NSMutableArray * member_imageArr;
    NSMutableArray * modeArr;
    NSMutableArray * member_name;
}

@end

@implementation CommentViewController
- (void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add.jpg"] style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    self.navigationController.navigationItem.rightBarButtonItem = rightBarItem;
    [self initData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.commmentTb.delegate = self;
    self.commmentTb.dataSource = self;
    self.commmentTb.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)initData
{
    NSString * urlStr;
    NSDictionary * parm;
    dateTimeArr = [NSMutableArray array];
    contentArr = [NSMutableArray array];
    member_name = [NSMutableArray array];
    member_imageArr = [NSMutableArray array];
    modeArr = [NSMutableArray array];
    if (self.isPro) {
        urlStr = PRO_COMMENT;
        parm = [[NSDictionary alloc] initWithObjectsAndKeys:self.sku_id,@"sku_id", nil];
        NSLog(@"self.sku_id = %@",self.sku_id);
    }
    else{
        urlStr = SHOP_COMMENT;
        parm = [[NSDictionary alloc] initWithObjectsAndKeys:self.seller_id,@"seller_id", nil];
    }

    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
        session.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
        session.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    NSString * uu = @"www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_comment";
    [session GET:urlStr parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"请求中...");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
//        NSLog(@"response = %@",responseObject);
//        NSLog(@"%@",[responseObject valueForKey:@"data"]);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"dic = %@",dic);
        NSArray * dataArr = [[NSArray alloc] initWithObjects:[dic valueForKey:@"data"], nil];
        NSLog(@"dataarr = %@",dataArr);
//        NSLog(@"%@",[dic valueForKey:@"data"][0]);
   
        for (int i = 0; i < dataArr.count; i++) {
            NSLog(@"%@",[dataArr[i] valueForKey:[NSString stringWithFormat:@"%d",i]]);
            [member_imageArr addObject:[[dataArr[i] valueForKey:[NSString stringWithFormat:@"%d",i]]valueForKey:@"member_img"]];
             [member_name addObject:[[dataArr[i] valueForKey:[NSString stringWithFormat:@"%d",i]]valueForKey:@"member_name"]];
              [modeArr addObject:[[dataArr[i] valueForKey:[NSString stringWithFormat:@"%d",i]]valueForKey:@"mood"]];
              [dateTimeArr addObject:[[dataArr[i] valueForKey:[NSString stringWithFormat:@"%d",i]]valueForKey:@"_datetime"]];
          [contentArr addObject:[[dataArr[i] valueForKey:[NSString stringWithFormat:@"%d",i]]valueForKey:@"content"]];
        
        }
        [self.commmentTb reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        NSLog(@"error = %@",error);
    }];
}
#pragma mark -- UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"comment";
    CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentTableViewCell" owner:nil options:nil]lastObject];
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:member_imageArr[indexPath.row]]];
        cell.iconImageView.layer.cornerRadius =36/2;
        cell.iconImageView.clipsToBounds = YES;
        cell.userNameLab.text = member_name[indexPath.row] ;
        cell.timeLab.text = dateTimeArr[indexPath.row];
        cell.timeLab.adjustsFontSizeToFitWidth = YES;
        cell.contentLab.text = contentArr[indexPath.row];
        cell.evaluateLab.text = modeArr[indexPath.row];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [modeArr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}
- (void)add
{
    NSLog(@"add");
    
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
