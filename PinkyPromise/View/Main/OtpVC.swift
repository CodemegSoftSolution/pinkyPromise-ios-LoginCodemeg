//
//  OtpVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 01/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import OTPFieldView

class OtpVC: UIViewController {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var confirmBtn: Button!
    
    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    
    private var AddDefaulLanguageVM: AddDefaulLanguageViewModel = AddDefaulLanguageViewModel()
    var isEnterOtp: Bool = false
    var otp: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillLayoutSubviews() {
        confirmBtn.borderColorTypeAdapter = 6
        confirmBtn.borderWidth = 3
    }
    
    func configUI() {
        setupOtpView()
        
        headerLbl.text = getTranslate("enter_otp")
    }
    
    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 4
        self.otpTextFieldView.fieldBorderWidth = 2
        self.otpTextFieldView.defaultBorderColor = LightPinkColor
        self.otpTextFieldView.filledBorderColor = AppColor
        self.otpTextFieldView.cursorColor = AppColor
        self.otpTextFieldView.displayType = .roundedCorner
        self.otpTextFieldView.fieldSize = 60
        self.otpTextFieldView.separatorSpace = 8
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }
    
    //MARK: - Button Click
    @IBAction func clickToConfirm(_ sender: Any) {
        if !isEnterOtp {
            displayToast(getTranslate("enter_otp"))
        }
        else{
            if let userData = AppModel.shared.currentUser.userdata {
                let request = VerifyOtpRequest(otp: otp, userid: userData.id)
                AddDefaulLanguageVM.verifyOtp(request: request) { (response) in
                    
                    setLoginUserData(response.data!.self)
                    AppModel.shared.currentUser = response.data
                    AppModel.shared.token = response.data?.accesstoken as! String
                    
                    let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "CompleteProfileVC") as! CompleteProfileVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

extension OtpVC: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        isEnterOtp = hasEntered
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        otp = otpString
    }
}
