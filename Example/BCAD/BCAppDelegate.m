//
//  BCAppDelegate.m
//  BCAD
//
//  Created by 617646201 on 05/28/2024.
//  Copyright (c) 2024 617646201. All rights reserved.
//

#import "BCAppDelegate.h"
#import "BCViewController.h"

@implementation BCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BCViewController * vc = [[BCViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    // 最低支持14.0
    
    // 复制以下代码到info.plist文件
    
    /**
     <key>NSAppTransportSecurity</key>
     <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
     </dict>
     */
    
    /*广告追踪
     <key>SKAdNetworkItems</key>
     <array>
         <dict>
             <key>SKAdNetworkIdentifier</key>
             <string>238da6jt44.skadnetwork</string>
         </dict>
         <dict>
             <key>SKAdNetworkIdentifier</key>
             <string>x2jnk7ly8j.skadnetwork</string>
         </dict>
     </array>
     */
    
    /*idfa
     <key>NSUserTrackingUsageDescription</key>
     <string>允许后，可以减少你不感兴趣的推广内容和广告</string>
     */
    
    // 在 Capabilities 打开 iCloud 选项，勾选key-value 和 cloudKit
    // Containers格式：iCloud.+你的bundleId
    
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
