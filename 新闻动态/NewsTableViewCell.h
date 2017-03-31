//
//  NewsTableViewCell.h
//  一路通
//
//  Created by 杨森林 on 17/2/25.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *newsImageView;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@end
