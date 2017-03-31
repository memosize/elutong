//
//  CommentViewController.h
//  一路通
//
//  Created by 杨森林 on 17/3/10.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *commmentTb;
@property (nonatomic, strong)NSString * sku_id;
@property (nonatomic, strong)NSString * seller_id;
@property (nonatomic, assign)BOOL isPro;// 判断是否为产品评论
@end
