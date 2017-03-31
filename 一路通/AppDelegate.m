//
//  AppDelegate.m
//  侧滑菜单demo
//
//  Created by 杨森林 on 15/8/21.
//  Copyright (c) 2015年 Yangsl. All rights reserved.
//

#import "AppDelegate.h"
#import "RightViewController.h"
#import "CenterTabbarViewController.h"
#import <MMDrawerController.h>
#import "ViewController.h"
@interface AppDelegate ()
{
    

}
@property(nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
     //1、初始化控制器
     UIViewController *centerVC = [[LitterLCenterViewController alloc]init];
     UIViewController *leftVC = [[LitterLLeftViewController alloc]init];
     UIViewController *rightVC = [[LitterLRightViewController alloc]init];
     //2、初始化导航控制器
     UINavigationController *centerNvaVC = [[UINavigationController alloc]initWithRootViewController:centerVC];
     UINavigationController *leftNvaVC = [[UINavigationController alloc]initWithRootViewController:leftVC];
     UINavigationController *rightNvaVC = [[UINavigationController alloc]initWithRootViewController:rightVC];
     
     //3、使用MMDrawerController
     self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:centerNvaVC leftDrawerViewController:leftNvaVC rightDrawerViewController:rightNvaVC];
     
     //4、设置打开/关闭抽屉的手势
     self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
     self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
     //5、设置左右两边抽屉显示的多少
     self.drawerController.maximumLeftDrawerWidth = 200.0;
     self.drawerController.maximumRightDrawerWidth = 200.0;
     
     
     //6、初始化窗口、设置根控制器、显示窗口
     self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
     [self.window setRootViewController:self.drawerController];
     [self.window makeKeyAndVisible];
     return YES;

     */
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
        UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    

    LeftViewController * leftVC = [[LeftViewController alloc] init];
//    RightViewController * rightVC = [[RightViewController alloc] init];
    //2、初始化导航控制器
    UINavigationController *centerNvaVC = [[UINavigationController alloc]initWithRootViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"center"]];
    UINavigationController *leftNvaVC = [[UINavigationController alloc]initWithRootViewController:leftVC];
//    UINavigationController *rightNvaVC = [[UINavigationController alloc]initWithRootViewController:rightVC];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerNvaVC leftDrawerViewController:leftNvaVC rightDrawerViewController:nil];
//    [drawer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//    UINavigationController * centernav = [[UINavigationController alloc] initWithRootViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"center"] ];
//    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:drawer];
    //4、设置打开/关闭抽屉的手势
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = 200.0;
    self.drawerController.maximumRightDrawerWidth = 200.0;
    
    
    //6、初始化窗口、设置根控制器、显示窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:self.drawerController];
    [self.window makeKeyAndVisible];
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    UIView *launchView = viewController.view;
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    [UIView animateWithDuration:3.0 delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 2.0f);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
    return YES;

    

  
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)setLaunchImage{
    CGSize viewSize =self.window.bounds.size;//获取当前屏幕Size
    NSString*viewOrientation =@"Portrait";//横屏请设置成 @"Landscape"
    NSString*launchImage =nil;
    
    //从info.plist文件中获取启动图的数组，这里会返回一个数组（里满是你设置好的启动图）
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for(NSDictionary* dict in imagesDict) {
        CGSize imageSize =CGSizeFromString(dict[@"UILaunchImageSize"]);
        //这里取出数组里面和当前屏幕尺寸相同的iamge
        if(CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    
    UIImageView * launchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImage]];
    
    launchView.frame=self.window.bounds;
    launchView.contentMode=UIViewContentModeScaleAspectFill;
    [self.window addSubview:launchView];
    //动画效果(你也可以这只其他，这种timeOut效果不错，用过MBProgressHUD人都知道)
    //在两秒内将alpha设置为0，之后在移除
    [UIView animateWithDuration:2.0f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         launchView.alpha=0.0f;
                         launchView.layer.transform=CATransform3DScale(CATransform3DIdentity,1.2,1.2,1);
                     }
                     completion:^(BOOL finished) {
                         [launchView removeFromSuperview];
                     }];
}
@end
