//
//  proDetailViewController.h
//  一路通
//
//  Created by 杨森林 on 17/3/10.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface proDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *proImageView;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong,nonatomic) NSString * proImageUrl;
@property (strong,nonatomic)NSString * proPrice;
@property (strong,nonatomic)NSString * sku_id;
@end
