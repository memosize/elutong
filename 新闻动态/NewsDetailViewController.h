//
//  NewsDetailViewController.h
//  一路通
//
//  Created by 杨森林 on 17/3/6.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UIImageView *newsImageView;
@property (strong, nonatomic) IBOutlet UILabel *contentLab;
@property (nonatomic, strong)NSString * titleStr;
@property (nonatomic, strong)NSString * timeStr;
@property (nonatomic, strong)NSString * imageUrl;
@property (nonatomic, strong)NSString * contentStr;

@end
