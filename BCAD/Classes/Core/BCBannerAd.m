//
//  BCBannerAd.m
//  BCAD
//
//  Created by 罗志勇 on 2024/6/3.
//

#import "BCBannerAd.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BCBannerAd () <BUNativeExpressBannerViewDelegate>

@property (nonatomic, strong) BUNativeExpressBannerView * adView;
@property (nonatomic, weak) UIViewController * rootVC;
@property (nonatomic, weak) UIView * contentView;

@end

@implementation BCBannerAd

+ (instancetype)instance
{
    static BCBannerAd * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)showWithSlotID:(NSString *)slotID frame:(CGRect)frame rootVC:(UIViewController * )rootVC contentView:(UIView * )contentView
{
    [BCBannerAd instance].rootVC = rootVC;
    
    BUNativeExpressBannerView * adView = [self initWithSlotID:slotID frame:frame rootVC:rootVC];
    [adView loadAdData];
    
    [BCBannerAd instance].adView = adView;
    [BCBannerAd instance].contentView = contentView;
}

+ (void)close
{
    [[BCBannerAd instance].adView removeFromSuperview];
}

+ (BUNativeExpressBannerView * )initWithSlotID:(NSString *)slotID frame:(CGRect)frame rootVC:(UIViewController * )rootVC
{
    BUNativeExpressBannerView * adView = [[BUNativeExpressBannerView alloc] initWithSlotID:slotID rootViewController:rootVC adSize:frame.size];
    adView.frame = frame;
    adView.delegate = [BCBannerAd instance];
    
    return adView;
}

#pragma mark - BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    [self.contentView addSubview: bannerAdView];
}

// 广告加载失败
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error
{
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords
{
    [bannerAdView removeFromSuperview];
}
@end
