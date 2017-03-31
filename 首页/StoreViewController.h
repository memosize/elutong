//
//  StoreViewController.h
//  一路通
//
//  Created by 杨森林 on 17/3/6.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *proImageVIew;
@property (strong, nonatomic) IBOutlet UICollectionView *proCollection;
@property (strong, nonatomic)NSMutableArray *proUrlArr;
@property (strong, nonatomic)NSMutableArray * proNameArr;
@property (strong, nonatomic)NSMutableArray * proPriceArrl;
- (IBAction)tapSort:(id)sender;
- (IBAction)tapCate:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sortBtn;
@property (strong, nonatomic) IBOutlet UIButton *cateBtn;




@end
