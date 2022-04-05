import UIKit
// Step 1: Import HyBid into your class
import HyBid

class Native: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
// Step 2: Create all the UI elements in your UI that will hold the native ad elements.
    @IBOutlet weak var nativeAdContentInfo: UIView!
    @IBOutlet weak var nativeAdIcon: UIImageView!
    @IBOutlet weak var nativeAdTitle: UILabel!
    @IBOutlet weak var nativeAdRating: HyBidStarRatingView!
    @IBOutlet weak var nativeAdBanner: UIView!
    @IBOutlet weak var nativeAdBody: UILabel!
    @IBOutlet weak var nativeAdCallToAction: UIButton!
    @IBOutlet weak var nativeAdContainer: UIView!
    
// Step 3: Create a HyBidNativeAdLoader property
    var nativeAdLoader = HyBidNativeAdLoader()
// Step 6: Create a HyBidNativeAd property
    var nativeAd = HyBidNativeAd()
    
    deinit {
// Step 12: Stop tracking the nativeAd
        nativeAd.stopTracking()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Standalone Native"
    }
    
    @IBAction func loadAdTouchUpInside(_ sender: UIButton) {
        nativeAdContainer.isHidden = true
        activityIndicator.startAnimating()
// Step 4: Initialize the HyBidNativeAdLoader property
        nativeAdLoader.loadNativeAd(with: self, withZoneID: "7")
    }
}

// Step 5: Implement the HyBidNativeAdLoaderDelegate methods
extension Native : HyBidNativeAdLoaderDelegate {
    func nativeLoaderDidLoad(with nativeAd: HyBidNativeAd!) {
        // Step 7: Fetch nativeAd's elements
        self.nativeAd = nativeAd
        self.nativeAd.fetchAssets(with: self)
    }
    
    func nativeLoaderDidFailWithError(_ error: Error!) {
        print("Native Ad Loader did fail with error:\(error.localizedDescription)")
        activityIndicator.stopAnimating()
    }
}

// Step 8: Implement the HyBidNativeAdFetchDelegate methods
extension Native : HyBidNativeAdFetchDelegate {
    func nativeAdDidFinishFetching(_ nativeAd: HyBidNativeAd!) {
        // Step 9: Create a HyBidNativeAdRenderer property and bind all view elements
        let renderer = HyBidNativeAdRenderer()
        renderer.contentInfoView = self.nativeAdContentInfo;
        renderer.iconView = self.nativeAdIcon;
        renderer.titleView = self.nativeAdTitle;
        renderer.starRatingView = self.nativeAdRating;
        renderer.bannerView = self.nativeAdBanner;
        renderer.bodyView = self.nativeAdBody;
        renderer.callToActionView = self.nativeAdCallToAction;
        
        self.nativeAd.renderAd(renderer)
        
        nativeAdContainer.isHidden = false
        // Step 10: Start tracking the nativeAd
        self.nativeAd.startTrackingView(self.nativeAdContainer, with: self)
        
        activityIndicator.stopAnimating()
    }
    
    func nativeAd(_ nativeAd: HyBidNativeAd!, didFailFetchingWithError error: Error!) {
        print("Native Ad did fail fetching with error:\(error.localizedDescription)")
        activityIndicator.stopAnimating()
    }
}

// Step 11: Implement the HyBidNativeAdDelegate methods
extension Native : HyBidNativeAdDelegate {
    func nativeAd(_ nativeAd: HyBidNativeAd!, impressionConfirmedWith view: UIView!) {
        print("Native Ad did track impression:")
    }
    
    func nativeAdDidClick(_ nativeAd: HyBidNativeAd!) {
        print("Native Ad did track click:")
    }
}
