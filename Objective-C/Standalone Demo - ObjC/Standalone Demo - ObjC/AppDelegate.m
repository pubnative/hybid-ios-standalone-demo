#import "AppDelegate.h"
// Step 1: Import HyBid into your class
#import <HyBid/HyBid.h>
#if __has_include(<HyBid/HyBid-Swift.h>)
    #import <HyBid/HyBid-Swift.h>
#else
    #import "HyBid-Swift.h"
#endif

#define APP_TOKEN @"543027b8e954474cbcd9a98481622a3b"
#define APP_STORE_ID @"1530210244"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
// Step 2: Setup & Initialize HyBid SDK
        [HyBid initWithAppToken:APP_TOKEN completion:nil];
// Step 3: Set COPPA (Optional)
        [HyBid setCoppa:NO];
// Step 4: Set Test Mode (Optional)
        [HyBid setTestMode:YES];
// Step 5: Set Location Tracking (Optional)
        [HyBid setLocationTracking:YES];
// Step 6: Set HTML Interstitial skipOffset (Optional)
        [HyBid setHTMLInterstitialSkipOffset:2];
// Step 7: Set Video Interstitial skipOffset (Optional)
        [HyBid setVideoInterstitialSkipOffset:5];
// Step 8: Set Custom Click Behavior (Optional)
        [HyBid setInterstitialActionBehaviour:HB_CREATIVE];
// Step 9: Set Targeting (Optional)
        HyBidTargetingModel *targeting = [[HyBidTargetingModel alloc] init];
        targeting.age = [NSNumber numberWithInt:28];
        targeting.interests = @[@"music"];
        targeting.gender = @"f";     // "f" for female, "m" for male
        [HyBid setTargeting:targeting];
// Step 10: Set SKOverlay for Interstitial (Optional)
        [HyBid setInterstitialSKOverlay:YES];
// Step 11: Set SKOverlay for Rewarded (Optional)
        [HyBid setRewardedSKOverlay:YES];
// Step 12: Set HyBid log level (Optional)
        [HyBidLogger setLogLevel:HyBidLogLevelDebug];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
