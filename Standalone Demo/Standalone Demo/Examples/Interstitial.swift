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
// Step 4: Set an optional skipOffset value
        interstitialAd.setSkipOffset(5)
// Step 3.1: Enable auto caching of ad on load (Optional)
        interstitialAd.isAutoCacheOnLoad = true
// Step 5: Request a HyBidAd
        interstitialAd.load()
    }
    
    @IBAction func showAdTouchUpInside(_ sender: UIButton) {
// Step 7: Check isReady property whether the ad has been loaded and is ready to be displayed
        if interstitialAd.isReady {
            interstitialAd.show()
        }
    }
}

// Step 6: Implement the HyBidInterstitialAdDelegate methods
extension Interstitial : HyBidInterstitialAdDelegate {
    func interstitialDidLoad() {
        print("Interstitial did load:")
        activityIndicator.stopAnimating()
        showAdButton.isHidden = false
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
