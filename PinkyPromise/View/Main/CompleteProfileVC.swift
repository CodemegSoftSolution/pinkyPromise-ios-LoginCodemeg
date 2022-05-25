//
//  CompleteProfileVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 01/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class CompleteProfileVC: UIViewController {

    @IBOutlet weak var completeBtn: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillLayoutSubviews() {
        completeBtn.borderColorTypeAdapter = 6
        completeBtn.borderWidth = 3
        
        completeBtn.setTitle(getTranslate("complete_your_profile"), for: .normal)
    }
    
    func configUI() {
        
    }
    
    //MARK: - Button Click
    @IBAction func clickToCompleteProfile(_ sender: Any) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "AboutMeVC") as! AboutMeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
