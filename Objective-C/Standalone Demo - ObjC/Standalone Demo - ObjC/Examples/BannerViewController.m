#import "BannerViewController.h"
// Step 1: Import HyBid into your class
#import <HyBid/HyBid.h>

@interface BannerViewController () <HyBidAdViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bannerAdContainer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
// Step 2: Create a HyBidAdView property
@property (nonatomic, strong) HyBidAdView *bannerAdView;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Standalone Banner";
// Step 3: Initialize the HyBidAdView property with a HyBidAdSize
    self.bannerAdView = [[HyBidAdView alloc] initWithSize:HyBidAdSize.SIZE_320x50];
    [self.bannerAdContainer addSubview:self.bannerAdView];
}

- (IBAction)loadAdTouchUpInside:(id)sender {
    [self.activityIndicator startAnimating];
    self.bannerAdContainer.hidden = YES;
// Step 4: Enable auto caching of ad on load (Optional)
    self.bannerAdView.isAutoCacheOnLoad = YES;
// Step 5: Request a HyBidAd
    [self.bannerAdView loadWithZoneID:@"2" andWithDelegate:self];
}

// Step 6: Implement the HyBidAdViewDelegate methods
#pragma mark - HyBidAdViewDelegate

- (void)adViewDidLoad:(HyBidAdView *)adView {
    NSLog(@"Banner Ad View did load:");
    self.bannerAdContainer.hidden = NO;
    [self.activityIndicator stopAnimating];
    
// Step 4.1: Call `prepare` method if `bannerAdView.isAutoCacheOnLoad` set to `false`, to force a creative cache (Optional)
    // bannerAdView.prepare()
}

- (void)adView:(HyBidAdView *)adView didFailWithError:(NSError *)error {
    NSLog(@"Banner Ad View did fail with error: %@",error.localizedDescription);
    [self.activityIndicator stopAnimating];
}

- (void)adViewDidTrackClick:(HyBidAdView *)adView {
    NSLog(@"Banner Ad View did track click:");
}

- (void)adViewDidTrackImpression:(HyBidAdView *)adView {
    NSLog(@"Banner Ad View did track impression:");
}

@end
