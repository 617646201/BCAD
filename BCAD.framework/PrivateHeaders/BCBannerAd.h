//
//  BCBannerAd.h
//  BCAD
//
//  Created by 罗志勇 on 2024/6/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCBannerAd : NSObject

+ (void)showWithSlotID:(NSString *)slotID frame:(CGRect)frame rootVC:(UIViewController * )rootVC contentView:(UIView * )contentView;

+ (void)close;

@end

NS_ASSUME_NONNULL_END
