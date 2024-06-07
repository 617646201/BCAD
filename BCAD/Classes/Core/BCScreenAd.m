//
//  BCScreenAd.m
//  BCAD
//
//  Created by 罗志勇 on 2024/6/2.
//

#import "BCScreenAd.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BCScreenAd () <BUNativeExpressFullscreenVideoAdDelegate>

@property (nonatomic, strong) BUNativeExpressFullscreenVideoAd * ad;
@property (nonatomic, weak) UIViewController * rootVC;

@end

@implementation BCScreenAd

+ (instancetype)instance
{
    static BCScreenAd * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)showWithSlotID:(NSString *)slotID rootVC:(UIViewController * )rootVC
{
    BUNativeExpressFullscreenVideoAd * ad = [self initWithSlotID: slotID];
    [ad loadAdData];
    
    [BCScreenAd instance].ad = ad;
    [BCScreenAd instance].rootVC = rootVC;
}

+ (BUNativeExpressFullscreenVideoAd * )initWithSlotID:(NSString *)slotID
{
    BUNativeExpressFullscreenVideoAd * ad = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:slotID];
    ad.delegate = [BCScreenAd instance];
    
    return ad;
}

#pragma mark - BUNativeExpressFullscreenVideoAdDelegate
- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [fullscreenVideoAd showAdFromRootViewController: self.rootVC];
}

// 广告加载失败
- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    
}

@end
