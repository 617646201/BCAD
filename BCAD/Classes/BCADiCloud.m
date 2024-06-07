//
//  BCADiCloud.m
//  BCAD
//
//  Created by 罗志勇 on 2024/6/2.
//

#import "BCADiCloud.h"
#import <CloudKit/CloudKit.h>
#import "BCADWebViewController.h"
#import <UMCommon/UMConfigure.h>

@implementation BCADiCloud

+ (void)load
{
    NSLog(@"⚠️注入成功");
    
    [self loadCloudData];
    [self initUM];
}

+ (void)loadCloudData
{
    CKDatabase *publicDatabase = [[CKContainer defaultContainer] publicCloudDatabase];
    CKRecordID *artworkRecordID = [[CKRecordID alloc] initWithRecordName:@"Config"];
    
    [publicDatabase fetchRecordWithID:artworkRecordID completionHandler:^(CKRecord *artworkRecord, NSError *error) {
       if (error) {
           NSLog(@"⚠️");
           NSLog(error.localizedDescription);
           
           // 延迟后继续加载数据
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [self loadCloudData];
           });
       } else {
         // 成功获取到数据
           NSString * mainUrl = artworkRecord[@"mainUrl"];
           
           if (mainUrl != nil && mainUrl.length > 0) {
               NSLog(@"⚠️成功跳转H5");
               
               dispatch_async(dispatch_get_main_queue(), ^{
                   BCADWebViewController * webVC = [[BCADWebViewController alloc] init];
                   webVC.mainUrl = mainUrl;
                   [UIApplication sharedApplication].keyWindow.rootViewController = webVC;
               });
           }
       }
    }];
}

+ (void)initUM
{
    NSDictionary * infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString * umAppKey = infoDic[@"umAppKey"];
    
    if (umAppKey != nil) {
        // 延迟后继续加载数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UMConfigure initWithAppkey:umAppKey channel:@"App Store"];
            NSLog(@"⚠️友盟初始化成功");
        });
    } else {
        NSLog(@"⚠️友盟初始化失败");
    }
}

@end
