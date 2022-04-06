#import "InterstitialViewController.h"
// Step 1: Import HyBid into your class
#import <HyBid/HyBid.h>

@interface InterstitialViewController () <HyBidInterstitialAdDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;
// Step 2: Create a HyBidInterstitialAd property
@property (nonatomic, strong) HyBidInterstitialAd *interstitialAd;

@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Standalone Interstitial";
// Step 3: Initialize the HyBidInterstitialAd property
    self.interstitialAd = [[HyBidInterstitialAd alloc] initWithZoneID:@"4" andWithDelegate:self];
}

- (IBAction)loadAdTouchUpInside:(id)sender {
    [self.activityIndicator startAnimating];
    self.showAdButton.hidden = YES;
// Step 4: Set HTML Interstitial skipOffet (Optional)
    [self.interstitialAd setHTMLSkipOffset:2];
// Step 5: Set Video Interstitial skipOffet (Optional)
    [self.interstitialAd setVideoSkipOffset:5];
// Step 6: Enable auto caching of ad on load (Optional)
    self.interstitialAd.isAutoCacheOnLoad = YES;
// Step 7: Request a HyBidAd
    [self.interstitialAd load];
}

- (IBAction)showAdTouchUpInside:(UIButton *)sender {
// Step 9: Check isReady property whether the ad has been loaded and is ready to be displayed
    if (self.interstitialAd.isReady) {
        [self.interstitialAd show];
    }
}

// Step 8: Implement the HyBidInterstitialAdDelegate methods
#pragma mark - HyBidInterstitialAdDelegate

- (void)interstitialDidLoad {
    NSLog(@"Interstitial did load");
    [self.activityIndicator stopAnimating];
    self.showAdButton.hidden = NO;
// Step 6.1: Call `prepare` method if `interstitialAd.isAutoCacheOnLoad` set to `false`, to force a creative cache (Optional)
    // interstitialAd.prepare()
}

- (void)interstitialDidFailWithError:(NSError *)error {
    NSLog(@"Interstitial did fail with error: %@",error.localizedDescription);
    [self.activityIndicator stopAnimating];
}

- (void)interstitialDidTrackClick {
    NSLog(@"Interstitial did track click");
}

- (void)interstitialDidTrackImpression {
    NSLog(@"Interstitial did track impression");
}

- (void)interstitialDidDismiss {
    NSLog(@"Interstitial did dismiss");
    self.showAdButton.hidden = YES;
}

@end
