//
//  Copyright © 2021 PubNative. All rights reserved.
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

#import "HyBidVASTIconUtils.h"
#import "HyBidVideoAdProcessor.h"
#import "HyBidVASTAd.h"
#import "HyBidLogger.h"

@implementation HyBidVASTIconUtils

- (void)getVASTIconFrom:(NSString *)adContent completion:(vastIconCompletionBlock)block
{
    HyBidVideoAdProcessor *videoAdProcessor = [[HyBidVideoAdProcessor alloc] init];
    [videoAdProcessor processVASTString:adContent completion:^(HyBidVASTModel *vastModel, NSError *error) {
        if (error) {
            block(nil, error);
        } else {
            HyBidVASTAd *ad = [[vastModel ads] firstObject];
            HyBidVASTCreative *adCreative;
            for (HyBidVASTCreative *creative in [[ad inLine] creatives]) {
                if ([creative linear] != nil) {
                    adCreative = creative;
                    break;
                }
            }

            HyBidVASTLinear *linear = [adCreative linear];
            HyBidVASTIcon *icon = [[linear icons] firstObject];
            
            block(icon, nil);
        }
    }];
}

- (HyBidContentInfoView *)parseContentInfo:(HyBidVASTIcon *)icon
{
    if (!icon) {
        return nil;
    }
    
    HyBidContentInfoView *contentInfoView = [[HyBidContentInfoView alloc] init];
    contentInfoView.icon = [[[icon staticResources] firstObject] content];
    contentInfoView.link = [[[icon iconClicks] iconClickThrough] content];
    contentInfoView.viewTrackers = [icon iconViewTracking];
    contentInfoView.text = @"Learn about this ad";

    return contentInfoView;
}

@end
