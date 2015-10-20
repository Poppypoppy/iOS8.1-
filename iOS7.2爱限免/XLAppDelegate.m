//
//  XLAppDelegate.m
//  iOS7.2爱限免
//
//  Created by MS on 15-9-9.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import "XLAppDelegate.h"

@implementation XLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //<1>读取plist文件的内容
    NSString * path = [[NSBundle mainBundle] pathForResource:@"LoveFree" ofType:@"plist"];
    NSDictionary * allDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //<2>定义所有的键的值
    NSArray * keysArr = @[@"one",@"two",@"three",@"four",@"five"];
    
    //<3>定义一个可变数组 存放所有的子视图控制器
    NSMutableArray * controllers = [[NSMutableArray alloc]init];
    
    //<4>遍历字典 获取所需内容
    for(int i = 0;i<keysArr.count;i++)
    {
        NSDictionary * smallDic = [allDic objectForKey:keysArr[i]];
        
        //<5>获取视图控制的名称
        NSString * controllerStr = smallDic[@"controllerName"];
        
        //<6>将视图控制器的字符串名称转换成类名
        Class controllerClass = NSClassFromString(controllerStr);
        
        //<7>创建视图控制器对象
        UIViewController * viewCtr = [[controllerClass alloc]init];
        
        //<8>定义导航控制器
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewCtr];
        
        //<9>为导航条及tabBar添加标题
        NSString * titleName = smallDic[@"titleName"];
        viewCtr.navigationItem.title = titleName;
        nav.tabBarItem.title = titleName;
        
        //<10>为tabBar添加图片
        NSString * normalImage = smallDic[@"imageName"];
        NSString * selectImage = smallDic[@"selectedImage"];
        nav.tabBarItem.image = [UIImage imageNamed:normalImage];
        nav.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
        
        //<11>将所有子视图控制器添加到数组中
        [controllers addObject:nav];
        
        [viewCtr.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    //<12>创建标签栏控制器对象
    UITabBarController * tabBarCtr = [[UITabBarController alloc]init];
    tabBarCtr.viewControllers = controllers;
    
    
    //<13>将tabBarController添加到窗口上
    self.window.rootViewController = tabBarCtr;
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
