//
//  BCAD.h
//  BCAD
//
//  Created by 罗志勇 on 2024/5/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCAD : NSObject

#pragma mark - 初始化SDK
+ (void)initWithAppId:(NSString *)appID result:(void(^)(BOOL success))completion;

#pragma mark - 开屏广告
+ (void)showSplashWithSlotID:(NSString *)slotID rootVC:(UIViewController * )rootVC;

#pragma mark - 插屏广告
+ (void)showScreenWithSlotID:(NSString *)slotID rootVC:(UIViewController * )rootVC;

#pragma mark - 插屏广告
+ (void)showRewardWithSlotID:(NSString *)slotID rootVC:(UIViewController * )rootVC;

#pragma mark - banner广告
+ (void)showBannerWithSlotID:(NSString *)slotID frame:(CGRect)frame rootVC:(UIViewController * )rootVC contentView:(UIView * )contentView;
+ (void)removeBanner;

@end

NS_ASSUME_NONNULL_END
