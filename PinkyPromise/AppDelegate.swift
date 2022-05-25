//
//  AppDelegate.swift
//  PinkyPromise
//
//  Created by iMac on 9/28/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import IQKeyboardManagerSwift
import UserNotifications
import GoogleSignIn
import Firebase
import FBSDKLoginKit
import FirebaseMessaging
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport
import FirebaseRemoteConfig

var currentVersion: String = ""
var previousVersion: String = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var customTabbarVc : CustomTabBarController!
    var activityLoader : NVActivityIndicatorView!
    let signInConfig = GIDConfiguration.init(clientID: CLIENT_ID)
    private var RegisterVM: RegisterViewModel = RegisterViewModel()
    private var LoginVM : LoginViewModel = LoginViewModel()
    private var UpdateDeviceTokenVM: UpdateDeviceTokenViewModel = UpdateDeviceTokenViewModel()
    let fbLoginManager = LoginManager()
    private var UpdateAppVM: UpdateAppViewModel = UpdateAppViewModel()
    private var BadgesVM: BadgesViewModel = BadgesViewModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //IQKeyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        
        //Push Notification
        registerPushNotification(application)
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        loadCountryCodes()
        
        RegisterVM.delegate = self
        LoginVM.delegate = self
        autoLogin()
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
       // appVersionAPI()
        //appUpdateAvailable()
        
        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
//    func requestIDFA() {
//        if #available(iOS 14, *) {
//            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//                // Tracking authorization completed. Start loading ads here.
//                // loadAd()
//            })
//        } else {
//            // Fallback on earlier versions
//        }
//    }
    
    func appVersionAPI() {
        UpdateAppVM.updateApp { (response) in
            if response.data != nil {
                currentVersion = response.data!.currentVersion
                previousVersion = response.data!.previousVersion
                
                let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
                if appVersion! != currentVersion {
                    showAlert("Update", message: "Please update new version.", completion: {
                        let instagramHooks = "https://apps.apple.com/us/app/pinky-promise-health/id1595654815"
                        let instagramUrl = NSURL(string: instagramHooks)
                        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
                        {
                            UIApplication.shared.openURL(instagramUrl! as URL)
                            delay(0.1) {
                                exit(0)
                            }
                        }
                    })
                }
            }
        }
    }

    //MARK:- Share Appdelegate
    func storyboard() -> UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func sharedDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }

    //MARK:- Tab bar
    func showTabBar() {
        if customTabbarVc != nil {
            customTabbarVc.setTabBarHidden(tabBarHidden: false)
        }
    }
    
    func hideTabBar() {
        if customTabbarVc != nil {
            customTabbarVc.setTabBarHidden(tabBarHidden: true)
        }
    }
    
    func navigateToOnboarding() {
        let navigationVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "InfoVCNav") as! UINavigationController
        self.window?.rootViewController = navigationVC
    }

    func navigateToChangeLanguage() {
        let navigationVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "LanguageVCNav") as! UINavigationController
        self.window?.rootViewController = navigationVC
    }
    
    func navigateToVerifyPhoneNumber() {
        let navigationVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "PhoneVCNav") as! UINavigationController
        self.window?.rootViewController = navigationVC
    }
    
    func navigateToProfileComplete() {
        let navigationVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "ProfileCompleteVCNav") as! UINavigationController
        self.window?.rootViewController = navigationVC
//        UIApplication.shared.keyWindow?.rootViewController = navigationVC
        //CompleteYorProfileVC
    }

    //MARK:- Navigation
    func navigateToDashBoard() {
        customTabbarVc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController
        if let rootNavigatioVC : UINavigationController = self.window?.rootViewController as? UINavigationController
        {
            rootNavigatioVC.pushViewController(customTabbarVc, animated: false)
        }
    }
    
    func continueToLogout() {
        totalQuestion = 0
        removeUserDefaultValues()
        AppModel.shared.resetAllModel()
        AppModel.shared.fcmToken = getFCMToken()
        self.navigateToOnboarding()
    }
    
    //MARK:- autoLogin
    private func autoLogin() {
        if getLoginUserData() != nil {
            AppModel.shared.currentUser = getLoginUserData()
            AppModel.shared.token = AppModel.shared.currentUser.accesstoken

            log.info("USER INFO:::::::::::::::")/
            log.info("\(AppModel.shared.currentUser.userdata ?? UserModel())")/
            
            if AppModel.shared.currentUser.userdata == nil {
                navigateToOnboarding()
                return
            }
            if AppModel.shared.currentUser.userdata!.profilecomplete {
                navigateToDashBoard()
            }
            else if AppModel.shared.currentUser.userdata!.defaultLanguage == ""  {
                navigateToChangeLanguage()
            }
//            else if AppModel.shared.currentUser.userdata!.mobilenumber == "" {
//                if AppModel.shared.currentUser.userdata?.socialmedialogintype == "APPLE" {
//                    navigateToProfileComplete()
//                }
//                else{
//                    navigateToVerifyPhoneNumber()
//                }
//            }
            else if !AppModel.shared.currentUser.userdata!.profilecomplete {
                navigateToProfileComplete()
            }
        }
        else {
            AppModel.shared.currentUser = UserDataModel.init()
            navigateToOnboarding()
        }
    }
    
    //MARK:- loadCountryCodes
    func loadCountryCodes() {
        if let url = Bundle.main.url(forResource: "country", withExtension: "json") {
            do {
                let data =  try Data(contentsOf: url)
                do {
                    let success = try JSONDecoder().decode([CountryCodeModel].self, from: data) // decode the response into success model
                    AppModel.shared.countryCodes = success
                    log.success("\(Log.stats()) Successfully parsed country code,name,countyname")/
                }
                catch let err {
                    log.error("\(Log.stats())\(err)")/
                }
            } catch let err{
                log.error("\(Log.stats())\(err)")/
            }
        }
    }
    
    func changeLanguage()
    {
        if L102Language.currentAppleLanguage() == "en" {
            UserDefaults.standard.set(["hi"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            // Update the language by swaping bundle
            Bundle.setLanguage("hi")
        //    UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else {
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            // Update the language by swaping bundle
            Bundle.setLanguage("en")
       //     UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        //redirection code here
//        navigateToDashBoard()
    }
    
    func setDefaultLanguage() {
        if L102Language.currentAppleLanguage() != "hi" {
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            // Update the language by swaping bundle
            Bundle.setLanguage("en")
    //        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        if getLoginUserData() != nil {
            if AppModel.shared.currentUser != nil {
                BadgesVM.serviceCallToAppClose(request: BedgesAppRequest(UserID: AppModel.shared.currentUser.userdata?.id ?? "")) { (response) in
                   
                }
            }
        }        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func appUpdateAvailable() -> (Bool,String?) {
        guard let info = Bundle.main.infoDictionary,
              let identifier = info["CFBundleIdentifier"] as? String else {
            return (false,nil)
        }
        
//        let storeInfoURL: String = "http://itunes.apple.com/lookup?bundleId=\(identifier)&country=IN"
        let storeInfoURL:String = "https://itunes.apple.com/in/lookup?bundleId=\(identifier)"
        var upgradeAvailable = false
        var versionAvailable = ""
        // Get the main bundle of the app so that we can determine the app's version number
        let bundle = Bundle.main
        if let infoDictionary = bundle.infoDictionary {
            // The URL for this app on the iTunes store uses the Apple ID for the  This never changes, so it is a constant
            let urlOnAppStore = NSURL(string: storeInfoURL)
            if let dataInJSON = NSData(contentsOf: urlOnAppStore! as URL) {
                // Try to deserialize the JSON that we got
                if let dict: NSDictionary = try? JSONSerialization.jsonObject(with: dataInJSON as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject] as NSDictionary? {
                    if let results:NSArray = dict["results"] as? NSArray, results.count != 0 {
                        if let version = (results[0] as! [String:Any])["version"] as? String {
                            // Get the version number of the current version installed on device
                            if let currentVersion = infoDictionary["CFBundleShortVersionString"] as? String {
                                // Check if they are the same. If not, an upgrade is available.
                                print("\(version)")
                                if version != currentVersion {
                                    upgradeAvailable = true
                                    versionAvailable = version
                                }
                            }
                        }
                    }
                }
            }
        }
        return (upgradeAvailable,versionAvailable)
    }
    
    //MARK:- Notification
    func registerPushNotification(_ application: UIApplication)
    {
        //       Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Notification registered")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    //Get Push Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        //application.applicationIconBadgeNumber = Int((userInfo["aps"] as! [String : Any])["badge"] as! String)!
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        // handler for Push Notifications
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return true
    }
    
    func getFCMToken() -> String
    {
        return Messaging.messaging().fcmToken ?? ""
    }
    
    func scheduleLocalNotification(_ pdfName: String,_ path: URL,_ fileName: String) {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()

        // Configure Notification Content
        notificationContent.title = pdfName
        notificationContent.subtitle = "Download completed"
        notificationContent.userInfo = ["download" : "\(path)", "fileName" : fileName]
        
//        if let attachment = try? UNNotificationAttachment(identifier: "download", url: path, options: nil) {
//            notificationContent.attachments = [attachment]
//        }
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)

        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)

        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if getPushToken() == ""
        {
            setPushToken(fcmToken ?? "")
        }
    }
}


// MARK:- Push Notification
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        _ = notification.request.content.userInfo
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if UIApplication.shared.applicationState == .inactive
        {
            _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(delayForNotification(tempTimer:)), userInfo: userInfo, repeats: false)
        }
        else
        {
            notificationHandler(userInfo as! [String : Any])
        }
        
        completionHandler()
    }
    
    @objc func delayForNotification(tempTimer:Timer)
    {
        notificationHandler(tempTimer.userInfo as! [String : Any])
    }
    
    //Redirect to screen
    func notificationHandler(_ dict : [String : Any])
    {
        print(dict)
        if getLoginUserData() != nil {
            if AppModel.shared.currentUser.userdata == nil {
                return
            }
            if let payload = dict["additionalData"] {
                let payloadDict : [String : Any] = convertToDictionary(text: payload as! String) ?? [String : Any]()
                if !payloadDict.isEmpty {
                    
                    NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex":1])
                    
                    let vc = STORYBOARD.CHAT.instantiateViewController(withIdentifier: "MessageListVC") as! MessageListVC
                    vc.notificationDict = payloadDict
                    vc.isFromNotification = true
                    UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else if let downloadPath = dict["download"] {
                print(downloadPath)                
                if let fileName: String = dict["fileName"] as? String {
                    let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "PdfViewVC") as! PdfViewVC
                    vc.fileName = fileName
                    UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

extension AppDelegate {
    //MARK: - Facebook Login
    func loginWithFacebook(referralId: String, isLogin: Bool) {
        fbLoginManager.logOut()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: AppDelegate().sharedDelegate().window?.rootViewController) { (result, error) in
            if let error = error {
                return
            }
            guard let token = result?.token else {
                return
            }
            
            guard let accessToken : String = token.tokenString as? String else {
                return
            }
            
            let request : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields" : "picture.width(500).height(500), email, id, name, first_name, last_name, gender"])
            
            let connection : GraphRequestConnection = GraphRequestConnection()
            connection.add(request, completion: { (connection, result, error) in
                
                if result != nil
                {
                    let dict = result as! [String : AnyObject]
                    log.info("\(dict)")/
                    
                    guard let userId = dict["id"] as? String else { return }
                    
                    var emailId = ""
                    if let email = dict["email"]
                    {
                        emailId = email as! String
                    }
                    
                    var fname = ""
                    if let temp = dict["first_name"] as? String {
                        fname = temp
                    }
                    
                    var lname = ""
                    if let temp = dict["last_name"] as? String {
                        lname = temp
                    }
                    
                    var imgUrl = ""
                    if let picture = dict["picture"] as? [String : Any]
                    {
                        if let data = picture["data"] as? [String : Any]
                        {
                            if let url = data["url"]
                            {
                                imgUrl = url as! String
                            }
                        }
                    }
                    
                    if isLogin {
                        let request = LoginRequest(email: emailId, name: fname, IsSocialMedia: true, referralCode: referralId, id: userId, logintype: SocialType.facebook.rawValue)
                        self.LoginVM.userLogin(request: request)
                    }
                    else{
                        let request = SignupRequest(email: emailId, name: fname, IsSocialMedia: true, referralCode: referralId, id: userId, signuptype: SocialType.facebook.rawValue)
                        self.RegisterVM.userLogin(request: request)
                    }
                }
            })
            connection.start()
        }
    }
    
    
    func signUpWithGoogle(referralId: String, view: UIViewController, isLogin: Bool) {
        GIDSignIn.sharedInstance.signOut()
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: view) { user, error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                // Perform any operations on signed in user here.
                print(user?.userID ?? "")                  // For client-side use only!
                print(user?.authentication.idToken ?? "") // Safe to send to the server
                print(user?.profile?.name ?? "")
                print(user?.profile?.givenName ?? "")
                print(user?.profile?.familyName ?? "")
                print(user?.profile?.email ?? "")
                print(user?.profile?.imageURL(withDimension: 500) ?? "")

                guard let token = user?.authentication.idToken  else { return }
                guard let userId = user?.userID else { return }

                var emailId = ""
                if let email = user?.profile?.email
                {
                    emailId = email
                }
                var fname = ""
                if let temp = user?.profile?.givenName {
                    fname = temp
                }

                var lname = ""
                if let temp = user?.profile?.familyName {
                    lname = temp
                }

                var imgUrl = ""
                if let url = user?.profile?.imageURL(withDimension: 200)?.absoluteString
                {
                    imgUrl = url
                }

                if isLogin {
                    let request = LoginRequest(email: emailId, name: fname, IsSocialMedia: true, referralCode: referralId, id: userId, logintype: SocialType.google.rawValue)
                    self.LoginVM.userLogin(request: request)
                }
                else{
                    let request = SignupRequest(email: emailId, name: fname, IsSocialMedia: true, referralCode: referralId, id: userId, signuptype: SocialType.google.rawValue)
                    self.RegisterVM.userLogin(request: request)
                }
            }
        }
    }
}

extension AppDelegate: RegisterDelegate, LoginDelegate {
    func didRecieveRegisterResponse(response: LoginResponse) {
        setLoginUserData(response.data!.self)
        AppModel.shared.currentUser = response.data
        AppModel.shared.token = response.data?.accesstoken as! String
        
        setLoginTimeData(currentTime: currentTimeInMilliSeconds())
        serviceCallUpdateDeviceToken()
        
        if AppModel.shared.currentUser.userdata!.profilecomplete {
            navigateToDashBoard()
        }
        else if AppModel.shared.currentUser.userdata!.defaultLanguage == ""  {
            navigateToChangeLanguage()
        }
//        else if !AppModel.shared.currentUser.userdata!.mobilenumberverified {
//            if AppModel.shared.currentUser.userdata?.socialmedialogintype == "APPLE" {
//                navigateToProfileComplete()
//            }
//            else{
//                navigateToVerifyPhoneNumber()
//            }
//        }
        else if !AppModel.shared.currentUser.userdata!.profilecomplete {
            navigateToProfileComplete()
        }
    }
    
    func didRecieveLoginResponse(response: LoginResponse) {
        setLoginUserData(response.data!.self)
        AppModel.shared.currentUser = response.data
        AppModel.shared.token = response.data?.accesstoken as! String

        setLoginTimeData(currentTime: currentTimeInMilliSeconds())
        serviceCallUpdateDeviceToken()
        
        if AppModel.shared.currentUser.userdata!.profilecomplete {
            navigateToDashBoard()
        }
        else if AppModel.shared.currentUser.userdata!.defaultLanguage == ""  {
            navigateToChangeLanguage()
        }
//        else if !AppModel.shared.currentUser.userdata!.mobilenumberverified {
//            if AppModel.shared.currentUser.userdata?.socialmedialogintype == "APPLE" {
//                navigateToProfileComplete()
//            }
//            else{
//                navigateToVerifyPhoneNumber()
//            }
//        }
        else if !AppModel.shared.currentUser.userdata!.profilecomplete {
            navigateToProfileComplete()
        }
    }
    
    func serviceCallUpdateDeviceToken() {
        if let userData = AppModel.shared.currentUser.userdata {
            UpdateDeviceTokenVM.updateDeviceToken(request: UpdateTokenRequest(email: userData.email, divicetoken: getPushToken())) { (response) in
                print(response)
            }
        }
    }
}


//MARK:- Loader
extension AppDelegate {
    func showLoader()
    {
        removeLoader()
        DispatchQueue.main.async { [self] in
            self.window?.isUserInteractionEnabled = false
            self.activityLoader = NVActivityIndicatorView(frame: CGRect(x: ((self.window?.frame.size.width)!-50)/2, y: ((self.window?.frame.size.height)!-50)/2, width: 50, height: 50))
            self.activityLoader.type = .ballSpinFadeLoader
            self.activityLoader.color = AppColor
            self.window?.addSubview(self.activityLoader)
            self.activityLoader.startAnimating()
        }
    }
    
    func removeLoader()
    {
        DispatchQueue.main.async { [self] in
            self.window?.isUserInteractionEnabled = true
            if self.activityLoader == nil {
                return
            }
            self.activityLoader.stopAnimating()
            self.activityLoader.removeFromSuperview()
            self.activityLoader = nil
        }
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
