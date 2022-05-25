//
//  DuringOfPeriodVC.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 16/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

class DuringOfPeriodVC: UIViewController {

    var yRef:CGFloat = 44
    var lblDuration:UILabel = UILabel()
    var intDuration: Int = 5
    
    var strDateOfBirth: String = ""
    var strNickName: String = ""
    var strSelectedGender: String = ""
    var strWeight: String = ""
    var strHeight: String = ""
    var strPeriodDate: String = ""
    var strPeriodDuration: String = ""
    var selectedDate: Date!
    var strHeightUnit:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.screenDesigning()
    }
    
    func screenDesigning() {
        let barprogress:UIProgressView = UIProgressView()
        barprogress.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 20)
        barprogress.tintColor = ColorPink
        barprogress.progress = 0.85
        barprogress.trackTintColor = ColorLightGray//ColorPink
        barprogress.clipsToBounds = true
        self.view.addSubview(barprogress)
        
        yRef = yRef+barprogress.frame.size.height + 15
        
        let lblSteps:UILabel = UILabel()
        lblSteps.frame = CGRect(x: 20, y: yRef, width: 200, height: 30)
        lblSteps.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
        lblSteps.textColor = PrimeryPink
        lblSteps.text = "STEP 6/7"
        self.view.addSubview(lblSteps)
        
        yRef = yRef+lblSteps.frame.size.height + 20

        let btnBack:UIButton = UIButton()
        btnBack.frame = CGRect(x: 5, y: yRef-10, width: 40, height: 40)
        btnBack.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack)
        
        yRef = yRef+btnBack.frame.size.height

        let lblLastPeriodText:UILabel = UILabel()
        lblLastPeriodText.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 30)
        lblLastPeriodText.textColor = ColorHeaderText
        lblLastPeriodText.text = "What is the average duration of bleeding?"
        lblLastPeriodText.font = UIFont.init(name: FONT.Kurale.rawValue, size: 28)
        lblLastPeriodText.textAlignment = .left
        lblLastPeriodText.clipsToBounds = true
        lblLastPeriodText.numberOfLines = 0
        lblLastPeriodText.lineBreakMode = .byWordWrapping
        lblLastPeriodText.sizeToFit()
        self.view.addSubview(lblLastPeriodText)

        yRef = yRef+lblLastPeriodText.frame.size.height + 10
        
        let lblChooseDateText:UILabel = UILabel()
        lblChooseDateText.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 30)
        lblChooseDateText.backgroundColor = UIColor.clear
        lblChooseDateText.font = UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)
        lblChooseDateText.text = "How many days does your bleeding last when you get your periods?"
        lblChooseDateText.textAlignment = .left
        lblChooseDateText.textColor = ColorRed
        lblChooseDateText.clipsToBounds = true
        lblChooseDateText.numberOfLines = 0
        lblChooseDateText.lineBreakMode = .byWordWrapping
        lblChooseDateText.sizeToFit()
        self.view.addSubview(lblChooseDateText)

        yRef = yRef+lblChooseDateText.frame.size.height + 45

        let lblAverageDuration:UILabel = UILabel()
        lblAverageDuration.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 40)
        lblAverageDuration.backgroundColor = UIColor.clear
        lblAverageDuration.font = UIFont.init(name: FONT.Playfair.rawValue, size: 24.0)
        lblAverageDuration.text = "Average Duration"
        lblAverageDuration.textAlignment = .center
        lblAverageDuration.textColor = UIColor.black
        lblAverageDuration.clipsToBounds = true
        self.view.addSubview(lblAverageDuration)

        yRef = yRef+lblAverageDuration.frame.size.height + 15

        lblDuration = UILabel()
        lblDuration.frame = CGRect(x: (screenWidth-90)/2, y: yRef, width: 90, height: 50)
        lblDuration.backgroundColor = UIColor.clear
        lblDuration.font = UIFont.init(name: FONT.Playfair.rawValue, size: 40.0)
        lblDuration.text = String(intDuration)
        lblDuration.textAlignment = .center
        lblDuration.textColor = ColorPink
        lblDuration.clipsToBounds = true
        self.view.addSubview(lblDuration)

        let btnLeft:UIButton = UIButton()
        btnLeft.frame = CGRect(x: (screenWidth/2)-100, y: yRef+20, width: 30, height: 30)
        btnLeft.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnLeft.addTarget(self, action: #selector(self.btnLeftClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnLeft)

        let btnRight:UIButton = UIButton()
        btnRight.frame = CGRect(x: (screenWidth/2)+75, y: yRef+20, width: 30, height: 30)
        btnRight.setImage(UIImage.init(named: "ChevronRight"), for: .normal)
        btnRight.addTarget(self, action: #selector(self.btnRightClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnRight)

        yRef = yRef+lblDuration.frame.size.height + 45

        let btnConfirm:UIButton = UIButton()
        btnConfirm.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 40)
        btnConfirm.backgroundColor = ColorPink
        btnConfirm.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        btnConfirm.setTitle("Next", for: .normal)
        btnConfirm.setTitleColor(UIColor.white, for: .normal)
        btnConfirm.layer.cornerRadius = 20
        btnConfirm.clipsToBounds = true
        btnConfirm.addTarget(self, action: #selector(self.btnConfirmClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnConfirm)
        
        strPeriodDuration = String(intDuration)
     }
    //MARK: Action
    
    @objc func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btnConfirmClicked(_ sender: UIButton) {

        let vc: PeriodCycleVC = PeriodCycleVC()
        vc.nickNameTxt = strNickName
        vc.dateTxt = strDateOfBirth
        vc.selectedGender = strSelectedGender
        vc.strWeight = strWeight
        vc.strHeight = strHeight
        vc.strPeriodDate = strPeriodDate
        vc.strPeriodDuration = strPeriodDuration
        vc.selectedDate = selectedDate
        vc.strHeightUnit = strHeightUnit
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnLeftClicked(_ sender: UIButton) {
        if intDuration <= 0 {
            
        }else{
            intDuration = intDuration-1
            lblDuration.text = String(intDuration)
            strPeriodDuration = String(intDuration)
        }
    }
    @objc func btnRightClicked(_ sender: UIButton) {
        if intDuration > 14{
            
        }else {
            intDuration = intDuration+1
            lblDuration.text = String(intDuration)
            strPeriodDuration = String(intDuration)
        }
    }
    
}
