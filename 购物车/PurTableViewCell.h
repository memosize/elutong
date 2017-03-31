//
//  PurTableViewCell.h
//  一路通
//
//  Created by 杨森林 on 17/2/24.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol changeValueDelegate <NSObject>

-(void)chageValue:(UITableViewCell *) cell tag:(NSInteger)tag;
@end
@interface PurTableViewCell : UITableViewCell
@property (assign, nonatomic) id<changeValueDelegate> changeDelegate;
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UIButton *minusBtn;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UILabel *pronameLab;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UILabel *proPriceLab;
@property (strong, nonatomic) IBOutlet UITextField *priceTf;
@property (nonatomic, assign)NSUInteger num;
@property (nonatomic,copy)void (^buttonClickBlock)(UIButton *button) ;


@end
