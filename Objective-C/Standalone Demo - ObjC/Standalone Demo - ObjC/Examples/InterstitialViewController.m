#import "InterstitialViewController.h"
// Step 1: Import HyBid into your class
#import <HyBid/HyBid.h>
#if __has_include(<HyBid/HyBid-Swift.h>)
    #import <HyBid/HyBid-Swift.h>
#else
    #import "HyBid-Swift.h"
#endif
#import <AVFoundation/AVFoundation.h>

@interface InterstitialViewController () <HyBidInterstitialAdDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;
// Step 2: Create a HyBidInterstitialAd property
@property (nonatomic, strong) HyBidInterstitialAd *interstitialAd;

// Publisher-like audio session & background music for ad SDK testing
@property (nonatomic, strong) AVAudioPlayer *musicPlayer;
@property (nonatomic, strong) UIButton *playMusicButton;
@property (nonatomic, strong) UILabel *audioSessionLabel;
@property (nonatomic, assign) BOOL musicWasPlayingBeforeAd;

@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Standalone Interstitial";
    // Step 3: Initialize the HyBidInterstitialAd property
    self.interstitialAd = [[HyBidInterstitialAd alloc] initWithZoneID:@"4" andWithDelegate:self];

    // Publisher-like audio: start with Ambient (app that doesn't play its own audio yet)
    [self configureAudioSessionAmbient];
    [self setupMusicControls];
}

#pragma mark - AVAudioSession (publisher-like behavior for SDK testing)

- (void)configureAudioSessionAmbient {
    NSError *error = nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryAmbient
             withOptions:AVAudioSessionCategoryOptionMixWithOthers
                   error:&error];
    if (error) {
        NSLog(@"[Audio] Failed to set Ambient: %@", error.localizedDescription);
        return;
    }
    [session setActive:YES withOptions:0 error:&error];
    if (error) {
        NSLog(@"[Audio] Failed to activate session: %@", error.localizedDescription);
    }
    [self updateAudioSessionLabel];
}

- (void)configureAudioSessionForPlayback {
    NSError *error = nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryAmbient
             withOptions:AVAudioSessionCategoryOptionMixWithOthers
                   error:&error];
    if (error) {
        NSLog(@"[Audio] Failed to set Playback: %@", error.localizedDescription);
        return;
    }
    [session setActive:YES withOptions:0 error:&error];
    if (error) {
        NSLog(@"[Audio] Failed to activate session: %@", error.localizedDescription);
    }
    [self updateAudioSessionLabel];
}

- (void)updateAudioSessionLabel {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSString *category = session.category;
    BOOL playing = (self.musicPlayer != nil && self.musicPlayer.isPlaying);
    self.audioSessionLabel.text = [NSString stringWithFormat:@"Audio: %@%@",
                                   category ?: @"?",
                                   playing ? @" (music playing)" : @""];
}

- (void)setupMusicControls {
    UIView *view = self.view;
    UILayoutGuide *safe = view.safeAreaLayoutGuide;

    self.playMusicButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.playMusicButton setTitle:@"Play music" forState:UIControlStateNormal];
    self.playMusicButton.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    self.playMusicButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.playMusicButton addTarget:self action:@selector(playMusicTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.playMusicButton];

    self.audioSessionLabel = [[UILabel alloc] init];
    self.audioSessionLabel.font = [UIFont systemFontOfSize:12];
    self.audioSessionLabel.textColor = [UIColor darkGrayColor];
    self.audioSessionLabel.text = @"Audio: Ambient";
    self.audioSessionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:self.audioSessionLabel];

    [NSLayoutConstraint activateConstraints:@[
        [self.playMusicButton.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor constant:16],
        [self.playMusicButton.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor constant:-16],
        [self.playMusicButton.topAnchor constraintEqualToAnchor:safe.topAnchor constant:90],
        [self.playMusicButton.heightAnchor constraintEqualToConstant:33],
        [self.audioSessionLabel.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor constant:16],
        [self.audioSessionLabel.topAnchor constraintEqualToAnchor:self.playMusicButton.bottomAnchor constant:6],
    ]];
}

- (IBAction)playMusicTouchUpInside:(id)sender {
    if (self.musicPlayer != nil && self.musicPlayer.isPlaying) {
        [self.musicPlayer stop];
        [self configureAudioSessionAmbient];
        [self.playMusicButton setTitle:@"Play music" forState:UIControlStateNormal];
    } else {
        [self configureAudioSessionForPlayback];
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"music" withExtension:@"mp3"];
        if (!url) {
            NSLog(@"[Audio] music.mp3 not found in bundle");
            return;
        }
        NSError *error = nil;
        self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (error) {
            NSLog(@"[Audio] Failed to create player: %@", error.localizedDescription);
            return;
        }
        self.musicPlayer.numberOfLoops = -1;
        [self.musicPlayer prepareToPlay];
        [self.musicPlayer play];
        [self.playMusicButton setTitle:@"Stop music" forState:UIControlStateNormal];
    }
    [self updateAudioSessionLabel];
}

- (IBAction)loadAdTouchUpInside:(id)sender {
    [self.activityIndicator startAnimating];
    self.showAdButton.hidden = YES;
// Step 4: Enable auto caching of ad on load (Optional)
    self.interstitialAd.isAutoCacheOnLoad = YES;
// Step 5: Request a HyBidAd
    [self.interstitialAd load];
}

- (IBAction)showAdTouchUpInside:(UIButton *)sender {
    // Step 7: Check isReady property whether the ad has been loaded and is ready to be displayed
    if (self.interstitialAd.isReady) {
        self.musicWasPlayingBeforeAd = (self.musicPlayer != nil && self.musicPlayer.isPlaying);
        [self.interstitialAd show];
    }
}

// Step 6: Implement the HyBidInterstitialAdDelegate methods
#pragma mark - HyBidInterstitialAdDelegate

- (void)interstitialDidLoad {
    NSLog(@"Interstitial did load");
    [self.activityIndicator stopAnimating];
    self.showAdButton.hidden = NO;
// Step 4.1: Call `prepare` method if `interstitialAd.isAutoCacheOnLoad` set to `false`, to force a creative cache (Optional)
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
    // Restore app audio session after SDK restores (or re-apply so background music resumes)
    if (self.musicWasPlayingBeforeAd) {
        [self configureAudioSessionForPlayback];
        if (self.musicPlayer) {
            [self.musicPlayer play];
        }
        [self.playMusicButton setTitle:@"Stop music" forState:UIControlStateNormal];
    } else {
        [self configureAudioSessionAmbient];
    }
    [self updateAudioSessionLabel];
}

@end
