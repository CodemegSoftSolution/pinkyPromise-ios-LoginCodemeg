//
//  ResetPasswordVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 30/09/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var tempPassword: UITextField!
    @IBOutlet weak var newPasswordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    @IBOutlet weak var submitBtn: Button!
    
    private var ResetPasswordVM: ResetPasswordViewModel = ResetPasswordViewModel()
    var userData: UserDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillLayoutSubviews() {
        submitBtn.borderColorTypeAdapter = 6
        submitBtn.borderWidth = 3
    }
    
    func configUI() {
        if userData != nil {
            emailTxt.text = userData.userdata?.email
            emailTxt.isUserInteractionEnabled = false
        }
        ResetPasswordVM.delegate = self
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickToSubmit(_ sender: Any) {
        self.view.endEditing(true)
        guard let email = emailTxt.text?.trimmed else { return }
        guard let tempPassword = tempPassword.text?.trimmed else { return }
        guard let password = newPasswordTxt.text?.trimmed else { return }
        guard let confirmPassword = confirmPasswordTxt.text?.trimmed else { return }
           
        if email == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_email"))
        }
        else if tempPassword == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_temp_password"))
        }
        else if password == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_password"))
        }
        else if confirmPassword == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_confirm_password"))
        }
        else if confirmPassword != password {
            displayToast(getTranslate("password_confirm_password"))
        }
        else {
            let request = ResetPasswordRequest(email: email, newpassword: password, oldpassword: tempPassword)
            ResetPasswordVM.changePassword(request: request)
        }
    }
}

//MARK: - ResendVerificationDelegate
extension ResetPasswordVC: ResetPasswordDelegate {
    func didRecieveResetPasswordResponse(response: LoginResponse) {
        var isRedirect = false
        for aViewController:UIViewController in self.navigationController!.viewControllers as [UIViewController] {
            if aViewController.isKind(of: LoginVC.self) {
                isRedirect = true
                _ = self.navigationController?.popToViewController(aViewController, animated: true)
                return
            }
        }
        if !isRedirect {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

