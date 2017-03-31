//
//  LeftViewController.h
//  侧滑菜单demo
//
//  Created by 杨森林 on 15/8/21.
//  Copyright (c) 2015年 Yangsl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol clickDelegate
- (void)shouAlert;
@end
@interface LeftViewController : UIViewController
@property (nonatomic, weak)id <clickDelegate>delegate;
@property (nonatomic, copy)NSString * iconStr;
@property (nonatomic, copy)NSString * nameStr;
@end
