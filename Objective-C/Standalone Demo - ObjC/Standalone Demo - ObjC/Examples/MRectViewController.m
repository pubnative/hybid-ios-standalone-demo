#import "MRectViewController.h"
// Step 1: Import HyBid into your class
#import <HyBid/HyBid.h>
#if __has_include(<HyBid/HyBid-Swift.h>)
    #import <HyBid/HyBid-Swift.h>
#else
    #import "HyBid-Swift.h"
#endif

@interface MRectViewController () <HyBidAdViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mRectAdContainer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
// Step 2: Create a HyBidAdView property
@property (nonatomic, strong) HyBidAdView *mRectAdView;

@end

@implementation MRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Standalone MRect";
// Step 3: Initialize the HyBidAdView property with a HyBidAdSize
    self.mRectAdView = [[HyBidAdView alloc] initWithSize:HyBidAdSize.SIZE_300x250];
    [self.mRectAdContainer addSubview:self.mRectAdView];
}

- (IBAction)loadAdTouchUpInside:(id)sender {
    [self.activityIndicator startAnimating];
    self.mRectAdContainer.hidden = YES;
// Step 4: Request a HyBidAd
    [self.mRectAdView loadWithZoneID:@"3" andWithDelegate:self];
}

// Step 5: Implement the HyBidAdViewDelegate methods
#pragma mark - HyBidAdViewDelegate

- (void)adViewDidLoad:(HyBidAdView *)adView {
    NSLog(@"MRect Ad View did load:");
    self.mRectAdContainer.hidden = NO;
    [self.activityIndicator stopAnimating];
}

- (void)adView:(HyBidAdView *)adView didFailWithError:(NSError *)error {
    NSLog(@"MRect Ad View did fail with error: %@",error.localizedDescription);
    [self.activityIndicator stopAnimating];
}

- (void)adViewDidTrackClick:(HyBidAdView *)adView {
    NSLog(@"MRect Ad View did track click:");
}

- (void)adViewDidTrackImpression:(HyBidAdView *)adView {
    NSLog(@"MRect Ad View did track impression:");
}

@end
