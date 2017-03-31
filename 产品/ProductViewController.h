//
//  ProductViewController.h
//  一路通
//
//  Created by 杨森林 on 17/2/21.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *stockLab;
@property (strong, nonatomic) IBOutlet UIButton *addPur;
@property (strong, nonatomic) IBOutlet UIButton *goShopBtn;
@property (strong, nonatomic) IBOutlet UIButton *messageBtn;
@property (strong, nonatomic) IBOutlet UITableView *proTab;
@property (strong, nonatomic) IBOutlet UIImageView *logImageView;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong,nonatomic) NSString * sku_id;
@property (strong,nonatomic)NSString * seller_id;
@property (strong,nonatomic)NSString * proImageUrl;
@property (strong,nonatomic)NSString * proPrice;
@end
