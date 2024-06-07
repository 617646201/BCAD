//
//  BCADWebViewController.m
//  BCAD
//
//  Created by 罗志勇 on 2024/6/2.
//

#import "BCADWebViewController.h"
#import <WebKit/WebKit.h>
#import "BCAD.h"

static NSString * javaScript_initAndShowSplash = @"initAndShowSplash";
static NSString * javaScript_showSplash = @"showSplash";
static NSString * javaScript_showScreen = @"showScreen";
static NSString * javaScript_showReward = @"showReward";
static NSString * javaScript_showBanner = @"showBanner";
static NSString * javaScript_closeBanner = @"closeBanner";
static NSString * javaScript_exitApp = @"exitApp";


@interface BCADWebViewController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) WKWebViewConfiguration * configuration;

@end

@implementation BCADWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildLayout];
    [self loadJavaScript];
    [self reuqestWeb];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSString * js = [NSString stringWithFormat:@"window.webkit.messageHandlers.%@.postMessage({'adId': '958049996'});", javaScript_showScreen];
////        NSString * js = [NSString stringWithFormat:@"window.webkit.messageHandlers.%@.postMessage({'adId': '958049997'});", javaScript_showReward];
////        NSString * js = [NSString stringWithFormat:@"window.webkit.messageHandlers.%@.postMessage({'adId': '958050004', 'x':0, 'y':100, 'width':300 , 'height':75 });", javaScript_showBanner];
//
////        [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable, NSError * _Nullable error) {
////            if (error) {
////                NSLog([error localizedDescription]);
////            }
////        }];
//    });
    
}

- (void)buildLayout
{
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController * userContent = [[WKUserContentController alloc] init];
    self.configuration.userContentController = userContent;
    
    /// 禁止copy 选中效果
    WKUserScript * javaScript = [[WKUserScript alloc] initWithSource:@"document.documentElement.style.webkitTouchCallout='none';"
                                                       injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                    forMainFrameOnly: NO];
    [userContent addUserScript: javaScript];
    
    self.configuration.preferences = [[WKPreferences alloc] init];
    self.configuration.preferences.javaScriptEnabled = YES;
    self.configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    self.configuration.processPool = [[WKProcessPool alloc] init];
    self.configuration.allowsInlineMediaPlayback = YES;

    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:self.configuration];
    self.webView.scrollView.backgroundColor = UIColor.whiteColor;
    self.webView.backgroundColor = UIColor.clearColor;
    self.webView.autoresizesSubviews = YES;
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.webView];
}

- (void)reuqestWeb
{
    NSURL * url = [NSURL URLWithString: self.mainUrl];
    if (url == nil) {
        return;
    }
    
    NSURLRequest * resuest = [[NSURLRequest alloc] initWithURL: url];
    if (resuest == nil) {
        return;
    }
    
    [self.webView loadRequest: resuest];
}

- (void)loadJavaScript
{
    NSMutableArray * javaScript = [[NSMutableArray alloc] init];
    [javaScript addObject: javaScript_initAndShowSplash];
    [javaScript addObject: javaScript_showSplash];
    [javaScript addObject: javaScript_showScreen];
    [javaScript addObject: javaScript_showReward];
    [javaScript addObject: javaScript_showBanner];
    [javaScript addObject: javaScript_closeBanner];
    [javaScript addObject: javaScript_exitApp];
    
    
    for (NSString * name in javaScript) {
        [self.webView.configuration.userContentController addScriptMessageHandler:self name: name];
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if (message.name == javaScript_initAndShowSplash) {
        NSString * appId = message.body[@"appId"];
        NSString * adId = message.body[@"adId"];
        if (appId != nil) {
            // 初始化广告库
            __weak typeof(self) weakSelf = self;
            [BCAD initWithAppId: appId result:^(BOOL success) {
                if (success && adId != nil) {
                    [BCAD showSplashWithSlotID: adId rootVC: weakSelf];
                }
            }];
        }
    } else if (message.name == javaScript_showSplash) {
        NSString * adId = message.body[@"adId"];
        if (adId == nil) {
            return;
        }
        [BCAD showSplashWithSlotID: adId rootVC: self];
    } else if (message.name == javaScript_showScreen) {
        NSString * adId = message.body[@"adId"];
        if (adId == nil) {
            return;
        }
        [BCAD showScreenWithSlotID: adId rootVC: self];
    } else if (message.name == javaScript_showReward) {
        NSString * adId = message.body[@"adId"];
        if (adId == nil) {
            return;
        }
        [BCAD showRewardWithSlotID: adId rootVC: self];
    } else if (message.name == javaScript_showBanner) {
        NSString * adId = message.body[@"adId"];
        CGFloat x = [message.body[@"x"] doubleValue];
        CGFloat y = [message.body[@"y"] doubleValue];
        CGFloat width = [message.body[@"width"] doubleValue];
        CGFloat height = [message.body[@"height"] doubleValue];
        
        if (adId == nil) {
            return;
        }
        CGRect frame = CGRectMake(x, y, width, height);
        [BCAD showBannerWithSlotID:adId frame:frame rootVC:self contentView: self.webView.scrollView];
    } else if (message.name == javaScript_closeBanner) {
        [BCAD removeBanner];
    } else if (message.name == javaScript_exitApp) {
        exit(0);
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
//    NSString * js = [NSString stringWithFormat:@"window.webkit.messageHandlers.%@.postMessage({'appId': '5125303', 'adId': '889335039'});", javaScript_initAndShowSplash];
//
//    [webView evaluateJavaScript:js completionHandler:^(id _Nullable, NSError * _Nullable error) {
//        if (error) {
//            NSLog([error localizedDescription]);
//        }
//    }];
}


@end
