//
//  LoginVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 29/09/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginVC: UIViewController {

    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var rememberBtn: UIButton!
    @IBOutlet weak var btnStoryback: UIButton!
    @IBOutlet weak var lblDontText: UILabel!
    
    @IBOutlet weak var lblText: UILabel!
    private var LoginVM : LoginViewModel = LoginViewModel()
    private var UpdateDeviceTokenVM: UpdateDeviceTokenViewModel = UpdateDeviceTokenViewModel()
    
    var isFrom : Double = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changeUI()

        configUI()
    }
    func changeUI() {
        btnForgotPassword.setTitleColor(ColorPink, for: .normal)
        btnForgotPassword.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14.0)
        rememberBtn.setTitle("", for: .normal)
        rememberBtn.layer.borderWidth = 1
        rememberBtn.layer.borderColor = ColorPink.cgColor
        rememberBtn.layer.cornerRadius = 10
        rememberBtn.clipsToBounds = true
        lblDontText.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        
        let btnBack:UIButton = UIButton()
        btnBack.frame = CGRect(x: 5, y: 30, width: 45, height: 45)
        btnBack.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack)
        
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

    }
    func configUI() {
        LoginVM.delegate = self
    }
    
    //MARK: - Button Click
    @IBAction func clickToRemember(_ sender: UIButton) {
        rememberBtn.isSelected = !rememberBtn.isSelected
        if rememberBtn.image(for: .normal) == UIImage.init(named: "select_right")?.withRenderingMode(.alwaysTemplate) {
            rememberBtn.setImage(UIImage.init(named: ""), for: .normal)
            rememberBtn.clipsToBounds = true
        }else{
            rememberBtn.setImage(UIImage.init(named: "select_right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            rememberBtn.tintColor = ColorPink
            rememberBtn.clipsToBounds = true
        }
    }
    
    @IBAction func clickToForgotPassword(_ sender: Any) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToLogin(_ sender: Any) {
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
        else if rememberBtn.image(for: .normal) != UIImage.init(named: "select_right")?.withRenderingMode(.alwaysTemplate) {
            displayToast(getTranslate("remember_me"))
        }
        else {
            let request = LoginRequest(email: email, password: password, IsSocialMedia: false, rememberme: rememberBtn.isSelected)
            LoginVM.userLogin(request: request)
        }

    }
    @objc func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickToSignup(_ sender: Any) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToFacebookLogin(_ sender: Any) {
        AppDelegate().sharedDelegate().loginWithFacebook(referralId: "", isLogin: true)
    }
    
    @IBAction func clickToAppleLogin(_ sender: Any) {
        actionHandleAppleSignin()
    }
    
    @IBAction func clickToGoogleLogin(_ sender: Any) {
        AppDelegate().sharedDelegate().signUpWithGoogle(referralId: "", view: self, isLogin: true)
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

//MARK: - LoginDelegate
extension LoginVC: LoginDelegate {
    func didRecieveLoginResponse(response: LoginResponse) {
        self.view.endEditing(true)
        setLoginUserData(response.data!.self)
        AppModel.shared.currentUser = response.data
        AppModel.shared.token = response.data?.accesstoken as! String

        setLoginTimeData(currentTime: currentTimeInMilliSeconds())
        AppDelegate().sharedDelegate().serviceCallUpdateDeviceToken()
        
        if AppModel.shared.currentUser.userdata!.profilecomplete {
            AppDelegate().sharedDelegate().navigateToDashBoard()
        }
        else if AppModel.shared.currentUser.userdata!.defaultLanguage == ""  {
            let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SelectLanguageVC") as! SelectLanguageVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        else if !AppModel.shared.currentUser.userdata!.mobilenumberverified {
//            let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "PhoneNumberVC") as! PhoneNumberVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        else if !AppModel.shared.currentUser.userdata!.profilecomplete {
            let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "CompleteProfileVC") as! CompleteProfileVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


@available(iOS 13.0, *)
extension LoginVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
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
            
            let request = LoginRequest(email: appleUser.email, name: appleUser.firstName, IsSocialMedia: true, referralCode: "", id: appleUser.id, logintype: SocialType.apple.rawValue)
            self.LoginVM.userLogin(request: request)
            
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


