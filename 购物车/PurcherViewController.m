//
//  PurcherViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/20.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "PurcherViewController.h"
#import <AFNetworking.h>
#import "PurTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "PubDefine.h"
#import "LoginState.h"
#import "StoreViewController.h"
#import <Masonry.h>
#import "SureOrderViewController.h"

@interface PurcherViewController ()<UITableViewDelegate,UITableViewDataSource,changeValueDelegate>
{
    __block float sumPrice;
   __block NSInteger sumKinds;//产品种类数
  __block  NSInteger sumPros;//产品总数
    NSMutableArray * proIDArr;//商品id
    NSMutableArray *  sumOfThisProArr;//单个商品的总数
    NSMutableArray * priceOfThisProArr;//单个商品的价格
    NSMutableArray * proImageUrlArr;//图片地址
    NSMutableArray * proNameArr;
    NSMutableArray * sumPriceOfThisProArr;
    
    UITableView * proTB;
    UILabel * sumLab;
    UIButton * jiesuanBtn;
    UIButton * goShopBtn;
    NSInteger  sumOfSelected;
    float sumPriceOfSelected;
    UIView * footView;
    UIView * nullView;
    __block NSInteger count;// 记录剩余cell 数
    UIView * noGoodsView;
    
}

@end

@implementation PurcherViewController
- (void)viewWillAppear:(BOOL)animated
{
    if ([LoginState LoginedPerson].isLogin) {
         [self initData];
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请先登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//   [self initData];
//    [self performSelector:@selector(initView) withObject:self afterDelay:2.0];


}
- (void)initNoGoods
{
    UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(60, 26, 100, 20)];
    label.text = @"没有更多的商品";
    label.adjustsFontSizeToFitWidth = YES;
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(200, 16, 90, 30)];
    [button setTitle:@"继续购物" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(backToStore) forControlEvents:UIControlEventTouchUpInside];
//    button.titleLabel set
    noGoodsView =[[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 100)];
    
    [noGoodsView addSubview:label];
    [noGoodsView addSubview:button];
    [self.view addSubview:noGoodsView];
}
- (void)initView
{
//        if (sumPros == 0) {
//            UILabel * alertLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
//            alertLab.center = CGPointMake(0.5 * SCREEN_WIDTH, 40);
//            [self.view addSubview:alertLab];
//        }
    
//        NSLog(@"%d",proImageUrlArr.count);
//        nullView = [[UIView alloc] initWithFrame:CGRectMake(0, -400, SCREEN_WIDTH, 150)];
//        nullView.backgroundColor = [UIColor redColor];
    if (proTB == nil) {
        proTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), SCREEN_HEIGHT-150-120) style:UITableViewStylePlain];
        [proTB setEditing:YES];
        
        
        proTB.delegate = self;
        proTB.dataSource = self;
        footView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44 - 150, SCREEN_WIDTH, 150)];
        //    footView.backgroundColor = [UIColor redColor];
        sumLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 100 , 40, 200, 30)];
        [sumLab setAdjustsFontSizeToFitWidth:YES];
        sumLab.text = [NSString stringWithFormat:@"共计 0件         金额:   0.0"];
        jiesuanBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 100, 100, 30)];
        jiesuanBtn.center = CGPointMake(SCREEN_WIDTH*0.5 - 80 ,115);
        [jiesuanBtn setTitle:@"结算订单" forState:UIControlStateNormal];
        [jiesuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [jiesuanBtn setBackgroundColor:[UIColor redColor]];
        jiesuanBtn.layer.cornerRadius = 4;
        [jiesuanBtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
        goShopBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 100, 100, 30)];
        goShopBtn.center = CGPointMake(SCREEN_WIDTH*0.5 + 80, 115);
        
        [goShopBtn setTitle:@"继续购物" forState:UIControlStateNormal];
        [goShopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [goShopBtn setBackgroundColor:[UIColor redColor]];
        goShopBtn.layer.cornerRadius = 4;
        [goShopBtn addTarget:self action:@selector(backToStore) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [footView addSubview:sumLab];
        [footView addSubview:goShopBtn];
        [footView addSubview:jiesuanBtn];
        [self.view addSubview:footView];
        //    [proTB setTableFooterView:footView];
        //        [self.view addSubview:nullView];
        
        
        [self.view addSubview:proTB];

    }
}

- (void)initData
{
    proIDArr = [NSMutableArray array];
    priceOfThisProArr = [NSMutableArray array];
    sumOfThisProArr = [NSMutableArray array];
    proImageUrlArr = [NSMutableArray array];
    proNameArr = [NSMutableArray array];
    sumPriceOfThisProArr = [NSMutableArray array];
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
//    session.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
//    session.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=order&c=api_cart&a=get_carts";
    NSString * urlSS = @"http://www.b1ss.com/app/admin/index.php?m=order&c=api_order&a=settlement&skus_id=1;10;18";
    NSDictionary * parm = [[NSDictionary alloc] initWithObjectsAndKeys:@14,@"skuids",nil];

    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSDictionary * dic = [[NSDictionary  alloc] initWithDictionary:[responseObject objectForKey:@"data"]];
        NSLog(@"dic = %@",dic);
            sumPrice = [[dic valueForKey:@"all_prices"] floatValue];
            sumKinds = [dic valueForKey:@"sku_counts"];
            sumPros = [dic valueForKey:@"sku_numbers"];
        NSLog(@"sumpros = %@",sumPros);
        
        if ([[dic valueForKey:@"sku_numbers"] isEqual:@0] && [[dic valueForKey:@"sku_counts"] isEqual:@0] ) {
                [self initNoGoods];
             }
            else {
            NSDictionary * skuDic = [[NSDictionary alloc] initWithDictionary:[dic valueForKey:@"skus"]];
            for (NSDictionary * dic in [skuDic allValues]) {
                NSLog(@"-- dic = %@",dic);
                NSLog(@"shopPrice = %@",[dic valueForKey:@"shop_price"]);
                [proIDArr addObject:[dic valueForKey:@"sku_id"]];
                [priceOfThisProArr addObject:[[dic valueForKey:@"_sku_"] valueForKey:@"shop_price"]];
                [sumOfThisProArr addObject:[dic valueForKey:@"number"]];
                [proImageUrlArr addObject:[dic valueForKey:@"img"]];
                [proNameArr addObject:[[dic valueForKey:@"_sku_"] valueForKey:@"name"]];
                [sumPriceOfThisProArr addObject:[dic valueForKey:@"prices"]];
            }
        count = proNameArr.count;
            
                   [self initView];

            [proTB reloadData];

    }
}
     
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];

}
#pragma mark -- TableVIewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"purches";
     PurTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PurTableViewCell" owner:nil options:nil]lastObject];
        cell.changeDelegate = self;
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:proImageUrlArr[indexPath.row]]];
        
        cell.pronameLab.text = proNameArr[indexPath.row];
        cell.proPriceLab.text = sumPriceOfThisProArr[indexPath.row] ;
        cell.priceTf.text = sumOfThisProArr[indexPath.row];
        [cell.proPriceLab adjustsFontSizeToFitWidth];
        [cell.addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
          [cell.minusBtn addTarget:self action:@selector(minus:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteBtn.layer.cornerRadius = 4;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"proNamearr = %d",proNameArr.count);
    return [proNameArr count];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}
#pragma mark -- TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self coutSum];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self coutSum];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


- (void)add:(UIButton *)sender
{
    PurTableViewCell * cell = (PurTableViewCell *)[[sender superview]superview];
    // 获取点击的cell
    NSIndexPath *indexPath = [proTB indexPathForCell:cell];
    NSInteger count = [cell.priceTf.text integerValue];
    NSString * sku_id = proIDArr[indexPath.row];
    float price =  [priceOfThisProArr[indexPath.row] floatValue];
    // 获取当前cell 的相关数值
    NSLog(@"%d",count);
    count ++;
    cell.priceTf.text = [NSString stringWithFormat:@"%d",count];
    cell.proPriceLab.text = [NSString stringWithFormat:@"%.2f",count * price];
   
    [self coutSum];
    //计算商品总数，总价格

}
- (void)minus:(UIButton *)sender
{
    PurTableViewCell * cell = (PurTableViewCell *)[[sender superview]superview];
    NSIndexPath *indexPath = [proTB indexPathForCell:cell];
    // 获取点击的cell
    NSInteger num = [cell.priceTf.text integerValue];
    float price =  [priceOfThisProArr[indexPath.row] floatValue];
    NSString * sku_id = proIDArr[indexPath.row];
    // 得到cell 中相关的数值
    NSLog(@"%d",count);
    if (num > 1) {
        num --;
    }
    NSLog(@"count =  %d",count);
    cell.priceTf.text = [NSString stringWithFormat:@"%d",num];
    cell.proPriceLab.text = [NSString stringWithFormat:@"%.2f",num * price];
    [self coutSum];
}

- (void)delete:(UIButton *)sender
{
    
    int row =  [proTB indexPathForCell:((PurTableViewCell*)[[sender superview]superview])].row;
    NSLog(@"row = %d",row);
    NSString * sku_id = proIDArr[row];
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=order&c=api_cart&a=delpro";
    NSDictionary * parm = [[NSDictionary alloc] initWithObjectsAndKeys:sku_id,@"sku_id" ,nil];
    [session GET:urlStr parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"加载中..");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"加载成功");
        NSLog(@"%d",row);
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:row inSection:0];
        if (proNameArr.count >0 && count >0) {
            NSLog(@"count = %d",count);
            [priceOfThisProArr removeObjectAtIndex:row];
            [sumOfThisProArr  removeObjectAtIndex:row];
            [proImageUrlArr removeObjectAtIndex:row];
            [proNameArr removeObjectAtIndex:row];
            [proIDArr removeObjectAtIndex:row];
           [proTB deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationFade];
            [proTB reloadData];
            proTB.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

            
            
             [self coutSum];
            if (proNameArr.count == 0) {
                NSLog(@"没有数据了~");
                [footView removeFromSuperview];
                [proTB removeFromSuperview];
                [self initNoGoods];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"加载失败");
    }];
}
- (void)coutSum
{
        NSMutableArray * numArr = [NSMutableArray array];
        NSMutableArray * priceArr = [NSMutableArray array];
        for (int i = 0; i < proNameArr.count; i ++) {
            PurTableViewCell * pcell = [proTB cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (pcell.selected) {
                [numArr addObject:[NSNumber numberWithInteger:pcell.priceTf.text.integerValue]];
                [priceArr addObject:[NSNumber numberWithFloat:pcell.proPriceLab.text.floatValue]];
            }
    
        }
        int sum = 0;
        float prices = 0.00;
        for (int  k = 0; k < numArr.count; k++) {
            if ([numArr[k] integerValue] > 0) {
                sum += [numArr[k] integerValue];
                prices +=  [priceArr[k] floatValue];
            }
    
        }
        sumLab.text = [NSString stringWithFormat:@"共计%d件     金额:  %.2f",sum,prices];

}
- (void)tapSelected:(UIButton *)sender {
    if (sender.selected == NO) {
        sender.selected = YES;
    }
    else{
        sender.selected =  NO;
    }
           [self coutSum];
    
}
- (void)backToStore
{
    StoreViewController * storeVC = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
    [self.navigationController pushViewController:storeVC animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
//    [proTB removeFromSuperview];
//    [footView removeFromSuperview];
//    [noGoodsView removeFromSuperview];
    // 设置商品数量
    NSMutableArray * proNumArr = [NSMutableArray array];
    NSDictionary * parm = [NSDictionary dictionary];
    for (int i = 0; i < proNameArr.count; i ++) {
        PurTableViewCell * pcell = [proTB cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];

            [proNumArr addObject:[NSNumber numberWithInteger:pcell.priceTf.text.integerValue]];
    }
    NSLog(@"proidarr = %@",proIDArr);
//    for (int i = 0; i < proIDArr.count; i++) {
//        if (proNumArr[i]) {
//             [parm setValue:proNumArr[i] forKey:[NSString stringWithFormat:@"%d",proIDArr[i]]];
//        }
//       
//    }
    NSLog(@"parm = %@",parm);
}
- (void)pay
{
    SureOrderViewController * sureVC = [[SureOrderViewController alloc] initWithNibName:@"SureOrderViewController" bundle:nil];
    [self.navigationController pushViewController:sureVC animated:YES];
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
