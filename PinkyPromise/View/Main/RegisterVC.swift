//
//  RegisterVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 30/09/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import AuthenticationServices

class RegisterVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var switchLanguage: UISwitch!
    @IBOutlet weak var termsBtn: UIButton!
    
    @IBOutlet weak var lblAgree: UILabel!
    @IBOutlet var termsBackView: UIView!
    @IBOutlet weak var messageTxtView: UITextView!
    @IBOutlet weak var termsView: View!
    @IBOutlet weak var referalCodeTxt: UITextField!
    
    @IBOutlet weak var lblDontSignUp: UILabel!
    @IBOutlet weak var btnCheckMark: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var imgHindiI: UIImageView!
    @IBOutlet weak var lblEnglish: UILabel!
    @IBOutlet weak var lblHindi: UILabel!
    
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnApple: Button!
    
    private var RegisterVM: RegisterViewModel = RegisterViewModel()
    private var AddDefaulLanguageVM: AddDefaulLanguageViewModel = AddDefaulLanguageViewModel()

    var viewBG: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        self.customizeUI()
    }
    func customizeUI() {
        btnApple.setTitle("", for: .normal)
        btnSignIn.setTitle("", for: .normal)
        btnPrivacyPolicy.setTitle("", for: .normal)
        btnCheckMark.setTitle("", for: .normal)
        btnCheckMark.setBackgroundImage(UIImage.init(named: "3"), for: .normal)
        
        emailTxt.setLeftPaddingPoints(40)
        emailTxt.backgroundColor = ColorLightGray
        emailTxt.layer.cornerRadius = 8
        emailTxt.clipsToBounds = true
        emailTxt.placeholder = "Email"

        passwordTxt.backgroundColor = ColorLightGray
        passwordTxt.layer.cornerRadius = 8
        passwordTxt.clipsToBounds = true
        passwordTxt.placeholder = "Password"
        
        let imgLeft:UIImageView = UIImageView()
        imgLeft.frame = CGRect(x: 15, y: 7.5, width: 20, height: 20)
        imgLeft.image = UIImage.init(named: "Duotone")
        emailTxt.addSubview(imgLeft)

        passwordTxt.setLeftPaddingPoints(40)
        passwordTxt.setRightPaddingPoints(40)
        let imgPassLeft:UIImageView = UIImageView()
        imgPassLeft.frame = CGRect(x: 15, y: 7.5, width: 20, height: 20)
        imgPassLeft.image = UIImage.init(named: "lock")
        passwordTxt.addSubview(imgPassLeft)

        let btnEye:UIButton = UIButton()
        btnEye.frame = CGRect(x: screenWidth-65, y: 7.5, width: 20, height: 20)
        btnEye.setImage(UIImage.init(named: "passwordeye"), for: .normal)
        passwordTxt.addSubview(btnEye)

        let attributedString = NSMutableAttributedString.init(string: "I agree to the Privacy Policy")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 15, length: 14));
        lblAgree.attributedText = attributedString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleHindiEyeTap(_:)))
        imgHindiI.addGestureRecognizer(tap)
        imgHindiI.isUserInteractionEnabled = true

        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handlePrivecyPolicyTap(_:)))
        lblAgree.addGestureRecognizer(tap1)
        lblAgree.isUserInteractionEnabled = true

        let attributedString1 = NSMutableAttributedString.init(string: "Already have an account SIGN IN")
        attributedString1.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
            NSRange.init(location: 24, length: 7));
        lblDontSignUp.attributedText = attributedString1
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleDontSignUpTap(_:)))
        lblDontSignUp.addGestureRecognizer(tap2)
        lblDontSignUp.isUserInteractionEnabled = true

    }
    @objc func handleDontSignUpTap(_ sender: UITapGestureRecognizer? = nil) {
//        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleHindiEyeTap(_ sender: UITapGestureRecognizer? = nil) {
        self.popUpInformation()
    }
    @objc func handlePrivecyPolicyTap(_ sender: UITapGestureRecognizer? = nil) {
//        termsBackView.isHidden = false
//        displaySubViewtoParentView(self.view, subview: termsBackView)

    }
    //MARK: Action
    
    @IBAction func btnClickPrivecyPolicyClicked(_ sender: UIButton) {
        termsBackView.isHidden = false
        displaySubViewtoParentView(self.view, subview: termsBackView)

    }
    @IBAction func btnSignInClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnRememberClicked(_ sender: UIButton) {
        if btnCheckMark.backgroundImage(for: .normal) == UIImage.init(named: "3") {
            btnCheckMark.setBackgroundImage(UIImage.init(named: "checkMark"), for: .normal)
        }else {
            btnCheckMark.setBackgroundImage(UIImage.init(named: "3"), for: .normal)
        }
    }
    
    @IBAction func swichLanguageClicked(_ sender: UISwitch) {
        if switchLanguage.isOn == true {
            lblEnglish.textColor = UIColor.init(red: 36/255.0, green: 39/255.0, blue: 43/255.0, alpha: 1)
            lblHindi.textColor = ColorPink
        }
        else {
            lblEnglish.textColor = ColorPink
            lblHindi.textColor = UIColor.init(red: 36/255.0, green: 39/255.0, blue: 43/255.0, alpha: 1)

        }
    }
    @IBAction func btnForgetPasswordClicked(_ sender: UIButton) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func configUI() {
        termsBackView.isHidden = true
        RegisterVM.delegate = self
        
        messageTxtView.attributedText = pricacyPolisyData.html2AttributedString
        messageTxtView.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
    }
    
    override func viewWillLayoutSubviews() {
        termsView.cornerRadius = 10
        termsView.borderColorTypeAdapter = 9
        termsView.borderWidth = 1
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    //MARK: PopUp Information
    func popUpInformation() {
        viewBG = UIView()
        viewBG.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        viewBG.backgroundColor = ColorPink.withAlphaComponent(0.6)
        viewBG.clipsToBounds = true
        self.view.addSubview(viewBG)
        
        let viewPopUp: UIView = UIView()
        viewPopUp.frame = CGRect(x: (screenWidth-300)/2, y: (screenHeight-250)/2, width: 300, height: 250)
        viewPopUp.backgroundColor = UIColor.white
        viewPopUp.layer.cornerRadius = 8
        viewPopUp.clipsToBounds = true
        viewBG.addSubview(viewPopUp)
        
        let btnCross: UIButton = UIButton()
        btnCross.frame = CGRect(x: viewPopUp.frame.size.width-40, y: 15, width: 25, height: 25)
        btnCross.setImage(UIImage.init(named: "Cross")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnCross.tintColor = ColorPink
        btnCross.clipsToBounds = true
        btnCross.addTarget(self, action: #selector(self.btnCrossClicked(_:)), for: .touchUpInside)
        viewPopUp.addSubview(btnCross)

        let lblHinglish:UILabel = UILabel()
        lblHinglish.frame = CGRect(x: 20, y: 40, width: viewPopUp.frame.size.width-40, height: 40)
        lblHinglish.text = "Hinglish"
        lblHinglish.textAlignment = .center
        lblHinglish.font = UIFont.init(name: FONT.Kurale.rawValue, size: 22.0)
        lblHinglish.textColor = ColorPink
        lblHinglish.clipsToBounds = true
        viewPopUp.addSubview(lblHinglish)

        let lblSport:UILabel = UILabel()
        lblSport.frame = CGRect(x: 30, y: (viewPopUp.frame.size.height/2)-10, width: viewPopUp.frame.size.width-40, height: 30)
        lblSport.text = "Hinglish is hindi but written in english script. Aap ko hinglish ke lines aise dikhenge!"
        lblSport.textAlignment = .center
        lblSport.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14.0)
        lblSport.textColor = ColorGrayText
        lblSport.clipsToBounds = true
        lblSport.numberOfLines = 0
        lblSport.lineBreakMode = .byWordWrapping
        lblSport.sizeToFit()
        viewPopUp.addSubview(lblSport)

    }
    //MARK: - Button Click
    func addLanguage(){
        if switchLanguage.isOn == false {
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            Bundle.setLanguage("en")
        }
        else {
            UserDefaults.standard.set(["hi"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            Bundle.setLanguage("hi")
        }

    }
    @objc func btnEyeClicked(_ sender: UIButton) {
        passwordTxt.isSecureTextEntry = false 
    }
    @objc func btnCrossClicked(_ sender: UIButton) {
        viewBG.removeFromSuperview()
    }
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToTermsCondition(_ sender: Any) {
        termsBackView.isHidden = false
        displaySubViewtoParentView(self.view, subview: termsBackView)
    }
        
    @IBAction func clickToSignup(_ sender: Any) {
        self.view.endEditing(true)
        guard let email = emailTxt.text else { return }
        guard let password = passwordTxt.text else { return }
        if email == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_email"))
        }
        else if !email.isValidEmail {
            displayToast(getTranslate("invalid_email"))
        }
        else if password == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_password"))
        }
        else if btnCheckMark.backgroundImage(for: .normal) == UIImage.init(named: "3") {
            displayToast(getTranslate("check_terms_condition"))
        }
        else {
            self.addLanguage()
            let request = SignupRequest(email: email, password: password, acceptterms: true, IsSocialMedia: false, referralCode: nil, signuptype: SocialType.normal.rawValue)
          RegisterVM.userLogin(request: request)
        }
    }
    
    @IBAction func clickToFacebookLogin(_ sender: Any) {
        if btnCheckMark.backgroundImage(for: .normal) == UIImage.init(named: "3") {
            displayToast(getTranslate("check_terms_condition"))
            return

        }
        AppDelegate().sharedDelegate().loginWithFacebook(referralId: referalCodeTxt.text?.trimmed ?? "", isLogin: false)
    }
    
    @IBAction func clickToGoogleLogin(_ sender: Any) {
        if btnCheckMark.backgroundImage(for: .normal) == UIImage.init(named: "3") {
            displayToast(getTranslate("check_terms_condition"))
            return

        }

        AppDelegate().sharedDelegate().signUpWithGoogle(referralId: referalCodeTxt.text?.trimmed ?? "", view: self, isLogin: false)
    }
    
    @IBAction func clickToAppleLogin(_ sender: Any) {
        if btnCheckMark.backgroundImage(for: .normal) == UIImage.init(named: "3") {
            displayToast(getTranslate("check_terms_condition"))
            return

        }
        actionHandleAppleSignin()
    }
    
    @IBAction func clickToAccept(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        //termsBtn.isSelected = sender.isSelected
        btnCheckMark.setBackgroundImage(UIImage.init(named: "checkMark"), for: .normal)
        delay(1.0) {
            if sender.isSelected {
                self.termsBackView.isHidden = true
            }
        }
    }
    
    @IBAction func clickToCancelTermsCondition(_ sender: Any) {
        termsBackView.isHidden = true
    }
    
    @objc func actionHandleAppleSignin() {
        if #available(iOS 13.0, *) {
            let authorizationAppleIDProvider = ASAuthorizationAppleIDProvider()
            let authorizationRequest = authorizationAppleIDProvider.createRequest()
            authorizationRequest.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [authorizationRequest])
            authorizationController.presentationContextProvider = self
            authorizationController.delegate = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
    }
}

extension RegisterVC: RegisterDelegate {
    func didRecieveRegisterResponse(response: LoginResponse) {
        setLoginUserData(response.data!.self)
        AppModel.shared.currentUser = response.data
        AppModel.shared.token = response.data?.accesstoken as! String
        
        setLoginTimeData(currentTime: currentTimeInMilliSeconds())
        AppDelegate().sharedDelegate().serviceCallUpdateDeviceToken()
        if let userData = AppModel.shared.currentUser.userdata {
            AddDefaulLanguageVM.addDefaultLanguage(request: AddLanguageRequest(userid: userData.id, defaultLanguage: switchLanguage.isSelected ? LANGUAGE.Hindi.rawValue : LANGUAGE.English.rawValue)) { (response) in
                
                var data : UserDataModel = UserDataModel()
                data.accesstoken = AppModel.shared.currentUser.accesstoken
                data.userdata = response.data
                setLoginUserData(data)
                AppModel.shared.currentUser = data
                AppModel.shared.token = data.accesstoken
        }
//        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SelectLanguageVC") as! SelectLanguageVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc:CompleteYorProfileVC = CompleteYorProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
}

@available(iOS 13.0, *)
extension RegisterVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    // ASAuthorizationControllerDelegate function for authorization failed
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.view.endEditing(true)
        log.error("\(Log.stats()) \(error)")/
    }
    
    // ASAuthorizationControllerDelegate function for successful authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential{
        case let credentials as ASAuthorizationAppleIDCredential:
            var appleUser = AppleUser()
            appleUser = AppleUser(credentials: credentials)
            if appleUser.email != ""{
                KeychainWrapper.standard.set(appleUser.toJSONData(), forKey: KEY_CHAIN.apple.rawValue)
            }
            else{
                if let storedAppleCred = KeychainWrapper.standard.data(forKey: KEY_CHAIN.apple.rawValue){
                    if let apple = try? JSONDecoder().decode(AppleUser.self, from: storedAppleCred){
                        appleUser = apple
                    }
                }
            }
            appleUser.id = credentials.user
            log.success("Apple User: \(appleUser)")/
            self.saveUserInKeychain(appleUser.id)
            let socialToken = String(decoding : credentials.identityToken ?? Data(), as: UTF8.self)
                        
            let request = SignupRequest(email: appleUser.email, name: appleUser.firstName, IsSocialMedia: true, referralCode: referalCodeTxt.text?.trimmed ?? "", id: appleUser.id, signuptype: SocialType.apple.rawValue)
            self.RegisterVM.userLogin(request: request)
            
            log.info("PARAMS: \(Log.stats()) \(request)")/
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            //  show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
        default:
            break
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.app.InstantFest", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}


//extension UITapGestureRecognizer {
//
//    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
//        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
//        let layoutManager = NSLayoutManager()
//        let textContainer = NSTextContainer(size: CGSize.zero)
//        let textStorage = NSTextStorage(attributedString: label.attributedText!)
//
//        // Configure layoutManager and textStorage
//        layoutManager.addTextContainer(textContainer)
//        textStorage.addLayoutManager(layoutManager)
//
//        // Configure textContainer
//        textContainer.lineFragmentPadding = 0.0
//        textContainer.lineBreakMode = label.lineBreakMode
//        textContainer.maximumNumberOfLines = label.numberOfLines
//        let labelSize = label.bounds.size
//        textContainer.size = labelSize
//
//        // Find the tapped character location and compare it to the specified range
//        let locationOfTouchInLabel = self.locationInView(label)
//        let textBoundingBox = layoutManager.usedRectForTextContainer(textContainer)
//        let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
//            (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
//        let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
//            locationOfTouchInLabel.y - textContainerOffset.y);
//        let indexOfCharacter = layoutManager.characterIndexForPoint(locationOfTouchInTextContainer, inTextContainer: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
//
//        return NSLocationInRange(indexOfCharacter, targetRange)
//    }
//
//}
