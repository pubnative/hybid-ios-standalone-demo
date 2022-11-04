#import "NativeViewController.h"
// Step 1: Import HyBid into your class
#import <HyBid/HyBid.h>
#if __has_include(<HyBid/HyBid-Swift.h>)
    #import <HyBid/HyBid-Swift.h>
#else
    #import "HyBid-Swift.h"
#endif

@interface NativeViewController () <HyBidNativeAdLoaderDelegate, HyBidNativeAdDelegate, HyBidNativeAdFetchDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
// Step 2: Create all the UI elements in your UI that will hold the native ad elements.
@property (weak, nonatomic) IBOutlet UIView *nativeAdContentInfo;
@property (weak, nonatomic) IBOutlet UIImageView *nativeAdIcon;
@property (weak, nonatomic) IBOutlet UILabel *nativeAdTitle;
@property (weak, nonatomic) IBOutlet HyBidStarRatingView *nativeAdRating;
@property (weak, nonatomic) IBOutlet UIView *nativeAdBanner;
@property (weak, nonatomic) IBOutlet UILabel *nativeAdBody;
@property (weak, nonatomic) IBOutlet UIButton *nativeCallToAction;
@property (weak, nonatomic) IBOutlet UIView *nativeAdContainer;
// Step 3: Create a HyBidNativeAdLoader property
@property (nonatomic, strong) HyBidNativeAdLoader *nativeAdLoader;
// Step 6: Create a HyBidNativeAd property
@property (nonatomic, strong) HyBidNativeAd *nativeAd;

@end

@implementation NativeViewController

- (void)dealloc {
    self.nativeAdLoader = nil;
// Step 12: Stop tracking the nativeAd
    [self.nativeAd stopTracking];
    self.nativeAd = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Standalone Native";
}

- (IBAction)loadAdTouchUpInside:(id)sender {
    self.nativeAdContainer.hidden = YES;
    [self.activityIndicator startAnimating];
// Step 4: Initialize the HyBidNativeAdLoader property
    self.nativeAdLoader = [[HyBidNativeAdLoader alloc] init];
    [self.nativeAdLoader loadNativeAdWithDelegate:self withZoneID:@"7"];
}

// Step 5: Implement the HyBidNativeAdLoaderDelegate methods
#pragma mark - HyBidNativeAdLoaderDelegate

- (void)nativeLoaderDidLoadWithNativeAd:(HyBidNativeAd *)nativeAd {
// Step 7: Fetch nativeAd's elements
    self.nativeAd = nativeAd;
    [self.nativeAd fetchNativeAdAssetsWithDelegate:self];
}

- (void)nativeLoaderDidFailWithError:(NSError *)error {
    NSLog(@"Native Ad did fail with error: %@",error.localizedDescription);
    [self.activityIndicator stopAnimating];
}

// Step 8: Implement the HyBidNativeAdFetchDelegate methods
#pragma mark - HyBidNativeAdFetchDelegate

- (void)nativeAdDidFinishFetching:(HyBidNativeAd *)nativeAd {
// Step 9: Create a HyBidNativeAdRenderer property and bind all view elements
    HyBidNativeAdRenderer *renderer = [[HyBidNativeAdRenderer alloc] init];
    renderer.contentInfoView = self.nativeAdContentInfo;
    renderer.iconView = self.nativeAdIcon;
    renderer.titleView = self.nativeAdTitle;
    renderer.starRatingView = self.nativeAdRating;
    renderer.bannerView = self.nativeAdBanner;
    renderer.bodyView = self.nativeAdBody;
    renderer.callToActionView = self.nativeCallToAction;
    
    [self.nativeAd renderAd:renderer];
    self.nativeAdContainer.hidden = NO;
// Step 10: Start tracking the nativeAd
    [self.nativeAd startTrackingView:self.nativeAdContainer withDelegate:self];
    [self.activityIndicator stopAnimating];
}

- (void)nativeAd:(HyBidNativeAd *)nativeAd didFailFetchingWithError:(NSError *)error {
    NSLog(@"Native Ad did fail with error: %@",error.localizedDescription);
    [self.activityIndicator stopAnimating];
}

// Step 11: Implement the HyBidNativeAdDelegate methods
#pragma mark - HyBidNativeAdDelegate

- (void)nativeAd:(HyBidNativeAd *)nativeAd impressionConfirmedWithView:(UIView *)view {
    NSLog(@"Native Ad did track impression:");
}

- (void)nativeAdDidClick:(HyBidNativeAd *)nativeAd {
    NSLog(@"Native Ad did track click:");
}

@end
