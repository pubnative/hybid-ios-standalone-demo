//
//  Copyright © 2018 PubNative. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#if __has_include(<HyBid/HyBid-Swift.h>)
    #import <UIKit/UIKit.h>
    #import <HyBid/HyBid-Swift.h>
#else
    #import <UIKit/UIKit.h>
    #import "HyBid-Swift.h"
#endif
#import <Foundation/Foundation.h>
#import "HyBidAdTrackerRequest.h"
#import "HyBidAd.h"

extern NSString *const PNLiteAdTrackerClick;
extern NSString *const PNLiteAdTrackerImpression;
extern NSString *const PNLiteAdCustomEndCardImpression;
extern NSString *const PNLiteAdCustomEndCardClick;
extern NSString *const PNLiteAdCustomCTAImpression;
extern NSString *const PNLiteAdCustomCTAClick;
extern NSString *const PNLiteAdCustomCTAEndCardClick;

@interface HyBidAdTracker : NSObject

@property (nonatomic, assign) BOOL impressionTracked;

- (instancetype)initWithImpressionURLs:(NSArray *)impressionURLs
       withCustomEndcardImpressionURLs:(NSArray *)customEndcardImpressionURLs
                         withClickURLs:(NSArray *)clickURLs
            withCustomEndcardClickURLs:(NSArray *)customEndcardClickURLs
                 withCustomCTATracking:(HyBidCustomCTATracking *)customCTATracking
                                 forAd:(HyBidAd *)ad;
- (void)trackClickWithAdFormat:(NSString *)adFormat;
- (void)trackImpressionWithAdFormat:(NSString *)adFormat;
- (void)trackCustomEndCardImpressionWithAdFormat:(NSString *)adFormat;
- (void)trackCustomEndCardClickWithAdFormat:(NSString *)adFormat;
- (void)trackCustomCTAImpressionWithAdFormat:(NSString *)adFormat;
- (void)trackCustomCTAClickWithAdFormat:(NSString *)adFormat onEndCard:(BOOL)onEndCard;
- (void)trackSKOverlayAutomaticClickWithAdFormat:(NSString *)adFormat;
- (void)trackSKOverlayAutomaticDefaultEndCardClickWithAdFormat:(NSString *)adFormat;
- (void)trackSKOverlayAutomaticCustomEndCardClickWithAdFormat:(NSString *)adFormat;
- (void)trackStorekitAutomaticClickWithAdFormat:(NSString *)adFormat;
- (void)trackStorekitAutomaticDefaultEndCardClickWithAdFormat:(NSString *)adFormat;
- (void)trackStorekitAutomaticCustomEndCardClickWithAdFormat:(NSString *)adFormat;

@end
