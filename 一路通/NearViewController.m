//
//  NearViewController.m
//  一路通
//
//  Created by 杨森林 on 17/2/7.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import "NearViewController.h"
#import "PubDefine.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#define APIKey    @"21b8446931ac17b9f2d93f2f32266695"
#import <AFNetworking.h>

@interface NearViewController ()
{
    MAMapView * _mapView;
  
}

@end

@implementation NearViewController
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"view will appear");
//    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
//    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
//        NSString * urlStr1 = @"www.b1ss.com/app/admin/index.php?m=goods&c=api&a=seller";
//          NSDictionary * pp = [NSDictionary dictionaryWithObjectsAndKeys:@"30.560705",@"lat",@"104.071588",@"lon", nil];
//       NSDictionary * pp1 = [NSDictionary dictionaryWithObjectsAndKeys:@1,@"id", nil];
//
//    
//    [session POST:urlStr1 parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"请求数据");
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"请求成功");
//        NSLog(@"res = %@",responseObject);
////        
////        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithDictionary:responseObject]];
////        NSString * str = [dic valueForKey:@"data"];
////        NSData * data = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
////        NSError * error;
////        NSArray * arr = [NSArray array];
////        arr = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
////        NSLog(@"arr = %@",arr);
//        
//        
//        
//        //        NSLog(@"parm = %@",parm);
////        NSLog(@"dic = %@",dic);
////        NSLog(@"arr = %@",arr);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败--");
//        
//    }];
    //get 请求
        AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    NSString * urlSttr = @"http://www.b1ss.com/app/admin/index.php?m=order&c=api_order&a=settlement";
           NSDictionary * pp1 = [NSDictionary dictionaryWithObjectsAndKeys:@"8;3",@"skuids",nil];
       
    [session GET:urlSttr parameters:pp1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSLog(@"responseObject = %@ ",responseObject);
        NSLog(@"data = %@",[responseObject objectForKey:@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,64, 320, 480)];
   

    [_mapView setMapType:MAMapTypeSatellite];
     self.view = _mapView;
    [AMapServices sharedServices].apiKey = APIKey;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:_mapView];
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
