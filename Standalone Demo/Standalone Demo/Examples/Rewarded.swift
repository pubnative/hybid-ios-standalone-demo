import UIKit
// Step 1: Import HyBid into your class
import HyBid
class Rewarded: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var showAdButton: UIButton!
    
// Step 2: Create a HyBidRewardedAd property
    var rewardedAd : HyBidRewardedAd!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Standalone Rewarded"
// Step 3: Initialize the HyBidRewardedAd property
        rewardedAd = HyBidRewardedAd(zoneID: "6", andWith: self)
    }

    @IBAction func loadAdTouchUpInside(_ sender: UIButton) {
        activityIndicator.startAnimating()
        showAdButton.isHidden = true
// Step 3.1: Enable auto caching of ad on load (Optional)
        rewardedAd.isAutoCacheOnLoad = true
// Step 4: Request a HyBidAd
        rewardedAd.load()
    }
    
    @IBAction func showAdTouchUpInside(_ sender: UIButton) {
// Step 6: Check isReady property whether the ad has been loaded and is ready to be displayed
        if rewardedAd.isReady {
            rewardedAd.show()
        }
    }
}

// Step 5: Implement the HyBidRewardedAdDelegate methods
extension Rewarded : HyBidRewardedAdDelegate {
    func rewardedDidLoad() {
        print("Rewarded Ad did load:")
        activityIndicator.stopAnimating()
        showAdButton.isHidden = false
    }
    
    func rewardedDidFailWithError(_ error: Error!) {
        print("Rewarded Ad did fail with error: \(error.localizedDescription)")
        activityIndicator.stopAnimating()
    }
    
    func rewardedDidTrackClick() {
        print("Rewarded Ad did track click:")
    }
    
    func rewardedDidTrackImpression() {
        print("Rewarded Ad did track impression:")
    }
    
    func rewardedDidDismiss() {
        print("Rewarded Ad did dismiss:")
        showAdButton.isHidden = true
    }
    
    func onReward() {
        print("Rewarded.")
    }
}
