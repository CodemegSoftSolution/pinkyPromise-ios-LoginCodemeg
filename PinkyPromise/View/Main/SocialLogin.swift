//
//  SocialLogin.swift
//  E-Auction
//
//  Created by iMac on 01/07/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import AuthenticationServices

//Gmail account & Firebase:    pw:
//Facebook account:   pw: 


class SocialLogin: UIViewController {
    
    let fbLoginManager = LoginManager()
    private var RegisterVM: RegisterViewModel = RegisterViewModel()
    var isFromLogin : Bool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RegisterVM.delegate = self
    }
    
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
                    
                    let request = SignupRequest(email: emailId, name: fname, IsSocialMedia: true, referralCode: referralId, id: userId, signuptype: SocialType.facebook.rawValue)
                    self.RegisterVM.userLogin(request: request)
                }
            })
            connection.start()
        }
    }
    
    
    func signUpWithGoogle(referralId: String, isLogin: Bool) {
        GIDSignIn.sharedInstance.signOut()
        GIDSignIn.sharedInstance.signIn(with: AppDelegate().sharedDelegate().signInConfig, presenting: self) { user, error in
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

                let request = SignupRequest(email: emailId, name: fname, IsSocialMedia: true, referralCode: referralId, id: userId, signuptype: SocialType.facebook.rawValue)
                self.RegisterVM.userLogin(request: request)
            }
        }
    }
}


extension SocialLogin: RegisterDelegate {
    func didRecieveRegisterResponse(response: LoginResponse) {
        setLoginUserData(response.data!.self)
        AppModel.shared.currentUser = response.data
        AppModel.shared.token = response.data?.accesstoken as! String
        
        if AppModel.shared.currentUser.userdata!.profilecomplete {
            AppDelegate().sharedDelegate().navigateToDashBoard()
            displayToast("Login successfully")
        }
        else if AppModel.shared.currentUser.userdata!.defaultLanguage == ""  {
            let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SelectLanguageVC") as! SelectLanguageVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if !AppModel.shared.currentUser.userdata!.mobilenumberverified {
            let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "PhoneNumberVC") as! PhoneNumberVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if !AppModel.shared.currentUser.userdata!.profilecomplete {
            let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "CompleteProfileVC") as! CompleteProfileVC
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
}
