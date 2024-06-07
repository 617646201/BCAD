//
//  BCSplashAd.h
//  BCAD
//
//  Created by 罗志勇 on 2024/5/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCSplashAd : NSObject

+ (void)showWithSlotID:(NSString *)slotID rootVC:(UIViewController * )rootVC;

@end

NS_ASSUME_NONNULL_END
