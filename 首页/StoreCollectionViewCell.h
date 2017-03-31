//
//  StoreCollectionViewCell.h
//  一路通
//
//  Created by 杨森林 on 17/3/6.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *proImageView;
@property (strong, nonatomic) IBOutlet UILabel *proNameLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;

@end
