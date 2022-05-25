//
//  LastCompleteProfileVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 01/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class LastCompleteProfileVC: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var confirmBtn: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillLayoutSubviews() {
        confirmBtn.borderColorTypeAdapter = 6
        confirmBtn.borderWidth = 2
    }
    
    func configUI() {
        
    }

    
}
