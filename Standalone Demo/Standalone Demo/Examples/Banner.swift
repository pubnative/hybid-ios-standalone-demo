import UIKit
// Step 1: Import HyBid into your class
import HyBid

class Banner: UIViewController {

    @IBOutlet weak var bannerAdContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
// Step 2: Create a HyBidAdView property
    var bannerAdView : HyBidAdView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Standalone Banner"
// Step 3: Initialize the HyBidAdView property with a HyBidAdSize
        bannerAdView = HyBidAdView(size: HyBidAdSize.size_320x50)
        bannerAdContainer.addSubview(bannerAdView)
    }

    @IBAction func loadAdTouchUpInside(_ sender: UIButton) {
        activityIndicator.startAnimating()
        bannerAdContainer.isHidden = true
// Step 4: Enable auto caching of ad on load (Optional)
        bannerAdView.isAutoCacheOnLoad = true
// Step 5: Request a HyBidAd
        bannerAdView.load(withZoneID: "2", andWith: self)
    }
}

// Step 6: Implement the HyBidAdViewDelegate methods
extension Banner : HyBidAdViewDelegate {
    func adViewDidLoad(_ adView: HyBidAdView!) {
        print("Banner Ad View did load:")
        bannerAdContainer.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func adView(_ adView: HyBidAdView!, didFailWithError error: Error!) {
        print("Banner Ad View did fail with error: \(error.localizedDescription)")
        activityIndicator.stopAnimating()
    }
    
    func adViewDidTrackClick(_ adView: HyBidAdView!) {
        print("Banner Ad View did track click:")
    }
    
    func adViewDidTrackImpression(_ adView: HyBidAdView!) {
        print("Banner Ad View did track impression:")
    }
}
