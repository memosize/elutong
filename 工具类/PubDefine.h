//
//  PubDefine.h
//  一路通
//
//  Created by 杨森林 on 17/2/9.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH   CGRectGetWidth([UIScreen mainScreen].bounds)
#define LRRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LRClearColor [UIColor clearColor]

@interface PubDefine : NSObject
@end
