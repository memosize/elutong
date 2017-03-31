//
//  AddComment.h
//  一路通
//
//  Created by Yangsl on 2017/3/28.
//  Copyright © 2017年 dasousuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddComment : UIView
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;
// 好评
@property (weak, nonatomic) IBOutlet UIButton *midBtn;
// 中评
@property (weak, nonatomic) IBOutlet UIButton *badBtn;
// 差评
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;
@property (weak, nonatomic) IBOutlet UITextView *commentTV;
- (IBAction)changeBtnSelect:(UIButton *)sender;
@end
