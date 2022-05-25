//
//  RefferalEnterVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 05/02/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

class RefferalEnterVC: UIViewController {

    @IBOutlet weak var reffralTxt: UITextField!
    
    private var AddDefaulLanguageVM: AddDefaulLanguageViewModel = AddDefaulLanguageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        
    }
    
    //MARK: - Button Click
    @IBAction func clickToSkip(_ sender: Any) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "CompleteProfileVC") as! CompleteProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToConfirm(_ sender: Any) {
        if reffralTxt.text?.trimmed == "" {
            displayToast(getTranslate("enter_refferal"))
        }
        else{
            if let userData = AppModel.shared.currentUser.userdata {
                AddDefaulLanguageVM.verifyRefferalCode(request: VerifyRequest(userId: userData.id, referralCode: reffralTxt.text!.trimmed)) { (response) in
                    
                    let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "CompleteProfileVC") as! CompleteProfileVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
