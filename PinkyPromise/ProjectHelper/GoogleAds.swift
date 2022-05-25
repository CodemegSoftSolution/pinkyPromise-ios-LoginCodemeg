//
//  GoogleAds.swift
//  Dream Catcher
//
//  Created by iMac on 01/12/20.
//

import UIKit
import GoogleMobileAds

//MARK: - SCREEN
struct GOOGLE_AD
{
    //LIVE
    static var Banner = "ca-app-pub-2918649210990626/5448500747"
    static var Intertitial = "ca-app-pub-2918649210990626/6885527883"
    
    //TEST
//    static var Banner = "ca-app-pub-3940256099942544/2934735716"
//    static var Intertitial = "ca-app-pub-3940256099942544/4411468910"
}


class GoogleBannerAds: NSObject, GADBannerViewDelegate
{
    var view: UIView!
    var backView: UIView!
    
    func loadAds(view : UIView, backView: UIView)
    {
        
        self.view = view
        self.backView = backView
        
//        let bannerAdView = GADBannerView(adSize: kGADAdSizeMediumRectangle)
//        bannerAdView.adUnitID = GOOGLE_AD.Banner
//        bannerAdView.delegate = self
//        bannerAdView.rootViewController = UIApplication.topViewController().self
//        view.backgroundColor = UIColor.clear
//        bannerAdView.adSize = GADAdSizeFromCGSize(CGSize(width: (SCREEN.WIDTH - 80), height: 200))
//        self.view.addSubview(bannerAdView)
//        bannerAdView.load(GADRequest())
        
//        AppDelegate().sharedDelegate().requestIDFA { (permission) in
//            if permission
//            {
//                self.view = view
//
//                let bannerAdView = GADBannerView(adSize: kGADAdSizeBanner)
//                bannerAdView.adUnitID = GOOGLE_AD.Banner
//                bannerAdView.delegate = self
//                bannerAdView.rootViewController = UIApplication.topViewController().self
//                view.backgroundColor = UIColor.clear
//                bannerAdView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
//                self.view.addSubview(bannerAdView)
//                bannerAdView.load(GADRequest())
//            }
//            else
//            {
//                // Permission Denite
//            }
//        }
    }
    
    func loadAdsWithShortHeight(view : UIView)
    {
        self.view = view
        self.backView = UIView()
        
//        let bannerAdView = GADBannerView(adSize: kGADAdSizeMediumRectangle)
//        bannerAdView.adUnitID = GOOGLE_AD.Banner
//        bannerAdView.delegate = self
//        bannerAdView.rootViewController = UIApplication.topViewController().self
//        view.backgroundColor = UIColor.clear
//        bannerAdView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
//        self.view.addSubview(bannerAdView)
//        bannerAdView.load(GADRequest())
    }

    
    // MARK:- GADBannerViewDelegate Methods
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        // print("adViewDidReceiveAd")
        if googleBannerShow {
            view.isHidden = false
            backView.isHidden = false
        }
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        // print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        view.isHidden = true
        backView.isHidden = true
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        // print("adViewWillPresentScreen")
    }
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        // print("adViewWillDismissScreen")
    }
    
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        // print("adViewDidDismissScreen")
    }

}

class GoogleInterstitialAds: NSObject, GADFullScreenContentDelegate
{
    static let shared = GoogleInterstitialAds()
    var interstitial: GADInterstitialAd?
    var completion: (() -> Void)?
    
    func initAds()
    {
        GADInterstitialAd.load(withAdUnitID: GOOGLE_AD.Intertitial, request: GADRequest(), completionHandler: { ad, error in
            if let error = error
            {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                // AppDelegate().sharedDelegate().removeLoader()
                // self.completion!()
                return
            }
            
            // Show Ads When Ads is load
            // AppDelegate().sharedDelegate().removeLoader()
            self.interstitial = ad!
            self.interstitial!.fullScreenContentDelegate = self
        })
    }
    
    func loadAds(_ completion: @escaping () -> Void)
    {
        self.completion = completion
        
        if self.interstitial != nil
        {
            self.interstitial!.present(fromRootViewController: UIApplication.topViewController()!.self)
        }
        else {
            completion()
        }

//        AppDelegate().sharedDelegate().requestIDFA { (permission) in
//            if permission
//            {
//                // AppDelegate().sharedDelegate().showLoader()
//                if self.interstitial != nil
//                {
//                    self.interstitial!.present(fromRootViewController: UIApplication.topViewController()!.self)
//                }
//            }
//            else
//            {
//                // Permission Denite
//                self.completion!()
//            }
//        }
    }
    
    // MARK:- GADInterstitialDelegate Methods
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        // print("Ad did fail to present full screen content.")
        // AppDelegate().sharedDelegate().removeLoader()
        completion!()
    }
    

//    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        // print("Ad did present full screen content.")
//        // AppDelegate().sharedDelegate().removeLoader()
//        // completion!()
//    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        // print("Ad did dismiss full screen content.")
        // AppDelegate().sharedDelegate().removeLoader()
        initAds()
        completion!()
    }
}
