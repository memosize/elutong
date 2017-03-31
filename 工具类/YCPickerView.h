//
//  YCPickerView.h
//  YCPickerView
//
//  Created by 袁灿 on 16/2/29.
//  Copyright © 2016年 yuancan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyBasicBlock)(id result);

@interface YCPickerView : UIView

@property (retain, nonatomic) NSArray *arrPickerData;
@property (retain, nonatomic) UIPickerView *pickerView;

@property (nonatomic, copy) MyBasicBlock selectBlock;

- (void)popPickerView;

@end
