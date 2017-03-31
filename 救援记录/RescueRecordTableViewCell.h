//
//  RescueRecordTableViewCell.h
//  FreightProject
//
//  Created by L on 2017/3/9.
//  Copyright © 2017年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RescueRecordTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *rec_shopNameLab;
@property (strong, nonatomic) IBOutlet UILabel *rec_disLab;
@property (strong, nonatomic) IBOutlet UILabel *rec_addressLab;
@property (strong, nonatomic) IBOutlet UILabel *rec_servicerLab;
@property (strong, nonatomic) IBOutlet UILabel *rec_servicerNumLab;
@property (strong, nonatomic) IBOutlet UILabel *rec_estTimeLab;// 预计等待时间
@property (strong, nonatomic) IBOutlet UILabel *rec_submitTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *rec_maintainMoneyLab;
@property (strong, nonatomic) IBOutlet UILabel *rec_sumMoneyLab;
@property (strong, nonatomic) IBOutlet UILabel *rec_chargeMothod_Lab;
@property (strong, nonatomic) IBOutlet UILabel *rec_statusLab;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;


@end
