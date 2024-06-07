//
//  BCSplashAd.m
//  BCAD
//
//  Created by 罗志勇 on 2024/5/28.
//

#import "BCSplashAd.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BCSplashAd () <BUSplashAdDelegate>

@property (nonatomic, strong) BUSplashAd * splashAd;
@property (nonatomic, weak) UIViewController * rootVC;

@end

@implementation BCSplashAd

+ (instancetype)instance
{
    static BCSplashAd * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)showWithSlotID:(NSString *)slotID rootVC:(UIViewController * )rootVC
{
    BUSplashAd * splashAd = [self initWithSlotID: slotID];
    [splashAd loadAdData];
    
    [BCSplashAd instance].splashAd = splashAd;
    [BCSplashAd instance].rootVC = rootVC;
}

+ (BUSplashAd * )initWithSlotID:(NSString *)slotID
{
    BUSplashAd * splashAd = [[BUSplashAd alloc] initWithSlotID:slotID adSize: [UIScreen mainScreen].bounds.size];
    splashAd.delegate = [BCSplashAd instance];
//    splashAd.cardDelegate = [BCSplashAd instance];
//    splashAd.zoomOutDelegate = [BCSplashAd instance];
    
    return splashAd;
}

#pragma mark - BUSplashAdDelegate
- (void)splashAdLoadSuccess:(nonnull BUSplashAd *)splashAd {
    // 方式一 使用应用keyWindow的rootViewController（接入简单，推荐）！！！
    [splashAd showSplashViewInRootViewController: self.rootVC];
}

- (void)splashAdLoadFail:(BUSplashAd *)splashAd error:(BUAdError *_Nullable)error
{
    
}

- (void)splashAdDidClose:(BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType
{

}

//关闭时调用广告销毁方法 避免关闭后广告不移除等异常场景
- (void)splashDidCloseOtherController:(BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
  
}

@end
