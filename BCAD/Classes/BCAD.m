//
//  BCAD.m
//  BCAD
//
//  Created by 罗志勇 on 2024/5/28.
//

#import "BCAD.h"
#import <BUAdSDK/BUAdSDK.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import "BCLog.h"
#import "BCSplashAd.h"
#import "BCScreenAd.h"
#import "BCRewardAd.h"
#import "BCBannerAd.h"


@implementation BCAD

+ (void)initWithAppId:(NSString *)appID result:(void(^)(BOOL success))completion
{
    [self requestIdfa:^{
        BUAdSDKConfiguration * configuration = [BUAdSDKConfiguration configuration];
        // 请更换为在平台申请的appid
        configuration.appID = appID;
        // SDK异步初始化
        [BUAdSDKManager startWithAsyncCompletionHandler:^(BOOL success, NSError *error) {
            if (success) {
                [BCLog log:@"初始化成功"];
            } else {
                [BCLog log:@"初始化失败"];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(success);
            });
        }];
    }];
}

+ (void)requestIdfa:(void(^)(void))completion
{
    NSDictionary * infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString * idfaTracking = infoDic[@"NSUserTrackingUsageDescription"];
    
    if (idfaTracking == nil) {
        completion();
    } else if ([[UIDevice currentDevice] systemVersion].doubleValue >= 14.0 && 
               [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
        // 加一个延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                completion();
            }];
        });
    } else {
        completion();
    }
}

#pragma mark - 开屏广告
+ (void)showSplashWithSlotID:(NSString *)slotID rootVC:(UIViewController * )rootVC
{
    [BCSplashAd showWithSlotID:slotID rootVC:rootVC];
}

#pragma mark - 插屏广告
+ (void)showScreenWithSlotID:(NSString *)slotID rootVC:(UIViewController * )rootVC
{
    [BCScreenAd showWithSlotID:slotID rootVC:rootVC];
}

#pragma mark - 插屏广告
+ (void)showRewardWithSlotID:(NSString *)slotID rootVC:(UIViewController * )rootVC
{
    [BCRewardAd showWithSlotID:slotID rootVC:rootVC];
}

#pragma mark - banner广告
+ (void)showBannerWithSlotID:(NSString *)slotID frame:(CGRect)frame rootVC:(UIViewController * )rootVC contentView:(UIView * )contentView
{
    [BCBannerAd showWithSlotID:slotID frame:frame rootVC:rootVC contentView:contentView];
}

+ (void)removeBanner
{
    [BCBannerAd close];
}


@end
