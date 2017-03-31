//
//  StoreViewController.m
//  一路通
//
//  Created by 杨森林 on 17/3/6.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "StoreViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "StoreCollectionViewCell.h"
#import <AFNetworking.h>
@interface StoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView * catePickView;
    UIPickerView * sortPickView;
    NSArray * cateArr;
    NSArray * sortArr;
}

@end

@implementation StoreViewController
- (void)viewWillAppear:(BOOL)animated
{
        [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initPickerView];
    [self initCollection];
    

}
- (void)initPickerView
{
    catePickView = [[UIPickerView alloc] initWithFrame:CGRectMake(50, 0, 150, 100)];
    catePickView.backgroundColor = [UIColor grayColor];
    sortPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(200, 100, 150, 100)];
    sortPickView.backgroundColor = [UIColor grayColor];
    catePickView.hidden = YES;
    sortPickView.hidden = YES;
    sortPickView.delegate = self;
    sortPickView.dataSource = self;
    catePickView.dataSource = self;
    catePickView.delegate = self;
    [_proCollection addSubview:catePickView];
    [_proCollection addSubview:sortPickView];
    
}
- (void)initData
{
    self.proUrlArr  = [NSMutableArray array];
    self.proNameArr  = [NSMutableArray array];
    self.proPriceArrl = [NSMutableArray array];
    if (cateArr.count == 0) {
        cateArr = [[NSArray alloc] initWithObjects:@"全部分类",@"电瓶车",@"摩托车",@"零件配件", nil];
    }
    if (sortArr.count == 0) {
        sortArr = [[NSArray alloc] initWithObjects:@"默认排序", @"价格从高到低",@"价格从低到高",@"销量从高到低",@"销量从低到高", nil];
    }
    
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=goods_list";
    NSDictionary * parm = [NSDictionary dictionaryWithObjectsAndKeys:@10,@"num",nil];
    [session GET:urlStr parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求数据");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res = %@",responseObject);
        NSArray * listArr = [[NSArray alloc] initWithArray:[[responseObject valueForKey:@"data"] valueForKey:@"lists"]];
        for (int i = 0; i < listArr.count; i++) {
            [self.proNameArr addObject:[listArr[i] valueForKey:@"name"]];
            [self.proUrlArr addObject:[listArr[i] valueForKey:@"thumb"]];
             [self.proPriceArrl addObject:[listArr[i] valueForKey:@"shop_price"]];
            
            
        }
        NSLog(@"%lu,%lu",[self.proNameArr count],[self.proUrlArr count]);
        // 需要商品id 店铺id 商品名 商品图片url
        [self.proCollection reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
}
- (void)initCollection
{
    UICollectionViewFlowLayout * shoplayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为横向流布局
    shoplayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    //设置每个item的大小为100*100
    shoplayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 100);
    shoplayout.minimumInteritemSpacing = 50;
    
    UICollectionViewFlowLayout * prolayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为横向流布局
    prolayout.scrollDirection = UICollectionViewScrollPositionCenteredHorizontally;
    //设置每个item的大小为100*100
    prolayout.itemSize = CGSizeMake(100, 168);
    [self.proCollection setCollectionViewLayout:prolayout];
    //代理设置
    
    //注册item类型 这里使用系统的类型
    [self.proCollection registerNib:[UINib nibWithNibName:@"StoreCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"procellId"];
    self.proCollection.backgroundColor = [UIColor whiteColor];
    self.proCollection.delegate=self;
    self.proCollection.dataSource=self;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.proNameArr count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"procellId" forIndexPath:indexPath];
    cell.proNameLab.text = self.proNameArr[indexPath.row];
    [cell.proImageView sd_setImageWithURL:[NSURL URLWithString:self.proUrlArr[indexPath.row]]];
    cell.priceLab.text = [NSString stringWithFormat:@"￥ %@",self.proPriceArrl[indexPath.row]];
    cell.priceLab.textColor = [UIColor redColor];
    return cell;
}
#pragma mark --- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == catePickView) {
        return cateArr.count;
    }else{
        return sortArr.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    
    if (pickerView == catePickView) {
        return cateArr[row];
    }else{
        return sortArr[row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == sortPickView) {
        [self.sortBtn setTitle:sortArr[row] forState:UIControlStateNormal];
        [self requestData];
        
    }
    else{
        [self.cateBtn setTitle:cateArr[row] forState:UIControlStateNormal];
    }
}
- (void)requestData
{
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    NSString * urlStr = @"http://www.b1ss.com/app/admin/index.php?m=goods&c=api&a=category";
    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"请求数据中...");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"res = %@",responseObject);
        NSLog(@"name = %@",[[responseObject valueForKey:@"data"][0] valueForKey:@"name"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tapSort:(id)sender {
    if (sortPickView.hidden == YES) {
        sortPickView.hidden = NO;
    }else{
        sortPickView.hidden = YES;
    }
    
}
- (IBAction)tapCate:(id)sender
{
    if (catePickView.hidden == YES) {
        catePickView.hidden = NO;
    }else{
        catePickView.hidden = YES;
    }
}


@end
