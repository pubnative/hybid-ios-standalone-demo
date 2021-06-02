import UIKit
// Step 1: Import HyBid into your class
import HyBid

class MRect: UIViewController {

    @IBOutlet weak var mRectAdContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
// Step 2: Create a HyBidAdView property
    var mRectAdView : HyBidAdView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Standalone MRect"
// Step 3: Initialize the HyBidAdView property with a HyBidAdSize
        mRectAdView = HyBidAdView(size: HyBidAdSize.size_300x250)
        mRectAdContainer.addSubview(mRectAdView)
    }

    @IBAction func loadAdTouchUpInside(_ sender: UIButton) {
        activityIndicator.startAnimating()
        mRectAdContainer.isHidden = true
// Step 4: Request a HyBidAd
        mRectAdView.load(withZoneID: "3", andWith: self)
    }
}

// Step 5: Implement the HyBidAdViewDelegate methods
extension MRect : HyBidAdViewDelegate {
    func adViewDidLoad(_ adView: HyBidAdView!) {
        print("MRect Ad View did load:")
        mRectAdContainer.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func adView(_ adView: HyBidAdView!, didFailWithError error: Error!) {
        print("MRect Ad View did fail with error: \(error.localizedDescription)")
        activityIndicator.stopAnimating()
    }
    
    func adViewDidTrackClick(_ adView: HyBidAdView!) {
        print("MRect Ad View did track click:")
    }
    
    func adViewDidTrackImpression(_ adView: HyBidAdView!) {
        print("MRect Ad View did track impression:")
    }
}
