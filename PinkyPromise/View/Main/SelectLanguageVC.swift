//
//  SelectLanguageVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 01/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class SelectLanguageVC: UIViewController {

    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var hindiBtn: UIButton!
    @IBOutlet weak var confirmBtn: Button!
    
    @IBOutlet var hindiBackView: UIView!
    
    private var AddDefaulLanguageVM: AddDefaulLanguageViewModel = AddDefaulLanguageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillLayoutSubviews() {
        confirmBtn.borderColorTypeAdapter = 6
        confirmBtn.borderWidth = 3
    }
    
    func configUI() {
        englishBtn.isSelected = true
        hindiBackView.isHidden = true
    }
    
    //MARK: - Button Click
    @IBAction func clickToEnglishBtn(_ sender: UIButton) {
        englishBtn.isSelected = true
        hindiBtn.isSelected = false
    }
    
    @IBAction func clickToHindi(_ sender: Any) {
        englishBtn.isSelected = false
        hindiBtn.isSelected = true
    }
    
    @IBAction func clickToConfirm(_ sender: Any) {
        if let userData = AppModel.shared.currentUser.userdata {
            if englishBtn.isSelected {
                UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                Bundle.setLanguage("en")
            }
            else {
                UserDefaults.standard.set(["hi"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                Bundle.setLanguage("hi")
            }
            AddDefaulLanguageVM.addDefaultLanguage(request: AddLanguageRequest(userid: userData.id, defaultLanguage: englishBtn.isSelected ? LANGUAGE.English.rawValue : LANGUAGE.Hindi.rawValue)) { (response) in
                
                var data : UserDataModel = UserDataModel()
                data.accesstoken = AppModel.shared.currentUser.accesstoken
                data.userdata = response.data
                setLoginUserData(data)
                AppModel.shared.currentUser = data
                AppModel.shared.token = data.accesstoken
                
//                if AppModel.shared.currentUser.userdata?.socialmedialogintype == "APPLE" {
                let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "RefferalEnterVC") as! RefferalEnterVC
                self.navigationController?.pushViewController(vc, animated: true)
                
//                let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "CompleteProfileVC") as! CompleteProfileVC
//                self.navigationController?.pushViewController(vc, animated: true)
                
//                }
//                else{
//                    let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "PhoneNumberVC") as! PhoneNumberVC
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
            }
        }
    }
    
    @IBAction func clickToViewPopup(_ sender: Any) {
        hindiBackView.isHidden = false
        displaySubViewtoParentView(self.view, subview: hindiBackView)
    }
    
    @IBAction func clickToCancelPopup(_ sender: Any) {
        hindiBackView.isHidden = true
    }
}
