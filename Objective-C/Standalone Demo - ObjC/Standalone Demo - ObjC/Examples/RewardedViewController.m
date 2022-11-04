#import "RewardedViewController.h"
// Step 1: Import HyBid into your class
#import <HyBid/HyBid.h>
#if __has_include(<HyBid/HyBid-Swift.h>)
    #import <HyBid/HyBid-Swift.h>
#else
    #import "HyBid-Swift.h"
#endif

@interface RewardedViewController () <HyBidRewardedAdDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;
// Step 2: Create a HyBidRewardedAd property
@property (nonatomic, strong) HyBidRewardedAd *rewardedAd;

@end

@implementation RewardedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Standalone Rewarded";
// Step 3: Initialize the HyBidRewardedAd property
    self.rewardedAd = [[HyBidRewardedAd alloc] initWithZoneID:@"6" andWithDelegate:self];
}

- (IBAction)loadAdTouchUpInside:(id)sender {
    [self.activityIndicator startAnimating];
    self.showAdButton.hidden = YES;
// Step 4: Enable auto caching of ad on load (Optional)
    self.rewardedAd.isAutoCacheOnLoad = YES;
// Step 5: Request a HyBidAd
    [self.rewardedAd load];
}

- (IBAction)showAdTouchUpInside:(UIButton *)sender {
// Step 7: Check isReady property whether the ad has been loaded and is ready to be displayed
    if (self.rewardedAd.isReady) {
        [self.rewardedAd show];
    }
}

// Step 6: Implement the HyBidRewardedAdDelegate methods
#pragma mark - HyBidRewardedAdDelegate

- (void)rewardedDidLoad {
    NSLog(@"Rewarded Ad did load");
    [self.activityIndicator stopAnimating];
    self.showAdButton.hidden = NO;
// Step 4.1: Call `prepare` method if `rewardedAd.isAutoCacheOnLoad` set to `false`, to force a creative cache (Optional)
    // rewardedAd.prepare()
}

- (void)rewardedDidFailWithError:(NSError *)error {
    NSLog(@"Rewarded Ad did fail with error: %@",error.localizedDescription);
    [self.activityIndicator stopAnimating];
}

- (void)rewardedDidTrackClick {
    NSLog(@"Rewarded Ad did track click");
}

- (void)rewardedDidTrackImpression {
    NSLog(@"Rewarded Ad did track impression");
}

- (void)rewardedDidDismiss {
    NSLog(@"Rewarded Ad did dismiss");
    self.showAdButton.hidden = YES;
}

- (void)onReward {
    NSLog(@"Rewarded.");
}

@end
