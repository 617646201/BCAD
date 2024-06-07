//
//  BCRewardAd.m
//  BCAD
//
//  Created by 罗志勇 on 2024/6/3.
//

#import "BCRewardAd.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BCRewardAd () <BUNativeExpressRewardedVideoAdDelegate>

@property (nonatomic, strong) BUNativeExpressRewardedVideoAd * ad;
@property (nonatomic, weak) UIViewController * rootVC;

@end

@implementation BCRewardAd

+ (instancetype)instance
{
    static BCRewardAd * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)showWithSlotID:(NSString *)slotID rootVC:(UIViewController * )rootVC
{
    BUNativeExpressRewardedVideoAd * ad = [self initWithSlotID: slotID];
    [ad loadAdData];
    
    [BCRewardAd instance].ad = ad;
    [BCRewardAd instance].rootVC = rootVC;
}

+ (BUNativeExpressRewardedVideoAd * )initWithSlotID:(NSString *)slotID
{
    BURewardedVideoModel * model = [[BURewardedVideoModel alloc] init];
    
    BUNativeExpressRewardedVideoAd * ad = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:slotID rewardedVideoModel:model];
    ad.delegate = [BCRewardAd instance];
    
    return ad;
}

#pragma mark - BUNativeExpressRewardedVideoAdDelegate
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [rewardedVideoAd showAdFromRootViewController: self.rootVC];
}

// 广告加载失败
- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

@end
