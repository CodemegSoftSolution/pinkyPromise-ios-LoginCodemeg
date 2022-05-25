//
//  ForgotPasswordVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 30/09/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var submitBtn: Button!
    
    private var ForgotPasswordVM: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillLayoutSubviews() {
        submitBtn.borderColorTypeAdapter = 6
        submitBtn.borderWidth = 3
    }
    
    func configUI() {
        ForgotPasswordVM.delegate = self
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToSubmit(_ sender: Any) {
        self.view.endEditing(true)
        guard let email = emailTxt.text?.trimmed else { return }
           
        if email == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_email"))
        }
        else if !email.isValidEmail {
            displayToast(getTranslate("invalid_email"))
        }
        else {
            let request = ForgotPasswordRequest(email: email)
            ForgotPasswordVM.forgotPassword(request: request)
        }
    }
    
    @IBAction func clickToRestPassword(_ sender: Any) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - ResendVerificationDelegate
extension ForgotPasswordVC: ForgotPasswordDelegate {
    func didRecieveForgotPasswordResponse(response: LoginResponse) {
        displayToast(response.message)
        if let userData = response.data {
            let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
            vc.userData = userData
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
