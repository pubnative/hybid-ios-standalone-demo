//
//  HomeViewController.swift
//  Standalone Demo
//
//  Created by José Jacobo Contreras Trejo on 19.09.23.
//

import UIKit
import OTPublishersHeadlessSDK

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    
    @IBAction func showOneTrustBanner(_ sender: Any) {
        let mobile_app_ID = "a95608a4-82cd-4181-ad45-83a53c7c67be-test"
        let storageLocation = "cdn.cookielaw.org"
        
        OTPublishersHeadlessSDK.shared.startSDK(storageLocation: storageLocation, domainIdentifier: mobile_app_ID, languageCode: "en") { response in
            
            guard response.error == nil else {
                print("****** OTP Response error: \(response.error?.localizedDescription ?? "")")
                return
            }
            
            print("****** OTP Response status: \(response.status)")
            print("****** OTP Response response string: \(response.responseString ?? "")")
            
            if response.status {
                OTPublishersHeadlessSDK.shared.setupUI(self, UIType: .banner)
            }
        }
    }
}
