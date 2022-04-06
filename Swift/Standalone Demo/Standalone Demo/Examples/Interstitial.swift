import UIKit
// Step 1: Import HyBid into your class
import HyBid

class Interstitial: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var showAdButton: UIButton!
    
// Step 2: Create a HyBidInterstitialAd property
    var interstitialAd : HyBidInterstitialAd!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Standalone Interstitial"
// Step 3: Initialize the HyBidInterstitialAd property
        interstitialAd = HyBidInterstitialAd(zoneID: "4", andWith: self)
    }

    @IBAction func loadAdTouchUpInside(_ sender: UIButton) {
        activityIndicator.startAnimating()
        showAdButton.isHidden = true
// Step 4: Set HTML Interstitial skipOffet (Optional)
        interstitialAd.setHTMLSkipOffset(2)
// Step 5: Set Video Interstitial skipOffet (Optional)
        interstitialAd.setVideoSkipOffset(5)
// Step 6: Enable auto caching of ad on load (Optional)
        interstitialAd.isAutoCacheOnLoad = true
// Step 7: Request a HyBidAd
        interstitialAd.load()
    }
    
    @IBAction func showAdTouchUpInside(_ sender: UIButton) {
// Step 9: Check isReady property whether the ad has been loaded and is ready to be displayed
        if interstitialAd.isReady {
            interstitialAd.show()
        }
    }
}

// Step 8: Implement the HyBidInterstitialAdDelegate methods
extension Interstitial : HyBidInterstitialAdDelegate {
    func interstitialDidLoad() {
        print("Interstitial did load:")
        activityIndicator.stopAnimating()
        showAdButton.isHidden = false
// Step 6.1: Call `prepare` method if `interstitialAd.isAutoCacheOnLoad` set to `false`, to force a creative cache (Optional)
        // interstitialAd.prepare()
    }
    
    func interstitialDidFailWithError(_ error: Error!) {
        print("Interstitial did fail with error: \(error.localizedDescription)")
        activityIndicator.stopAnimating()
    }
    
    func interstitialDidTrackClick() {
        print("Interstitial did track click:")
    }
    
    func interstitialDidTrackImpression() {
        print("Interstitial did track impression:")
    }
    
    func interstitialDidDismiss() {
        print("Interstitial did dismiss:")
        showAdButton.isHidden = true
    }
}
