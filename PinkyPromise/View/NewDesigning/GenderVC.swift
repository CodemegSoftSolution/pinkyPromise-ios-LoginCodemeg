//
//  GenderVC.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 15/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

protocol GenderProtocol {
    func gender(_ strGender: String)
}

class GenderVC: UIViewController {

    var delegate: GenderProtocol?
    
    var checkEdite:Bool = false

    var yRef:CGFloat = 44
    var viewMale:UIView = UIView()
    var btnMale:UIButton = UIButton()
    var viewFeMale:UIView = UIView()
    var btnFeMale:UIButton = UIButton()

    var strDateOfBirth: String = ""
    var strNickName: String = ""
    var strSelectedGender: String = ""
    var selectedDate: Date!
    var viewBG: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.screenDesigning()
    }
    
    func screenDesigning() {
        
        let barprogress:UIProgressView = UIProgressView()
        barprogress.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 20)
        barprogress.tintColor = ColorPink
        barprogress.progress = 0.285
        barprogress.trackTintColor = ColorLightGray//ColorPink
        barprogress.clipsToBounds = true
        self.view.addSubview(barprogress)
        
        yRef = yRef+barprogress.frame.size.height + 15
        
        let lblSteps:UILabel = UILabel()
        lblSteps.frame = CGRect(x: 20, y: yRef, width: 200, height: 30)
        lblSteps.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
        lblSteps.textColor = PrimeryPink
        lblSteps.text = "STEP 2/7"
        self.view.addSubview(lblSteps)
        
        yRef = yRef+lblSteps.frame.size.height + 20

        let btnBack:UIButton = UIButton()
        btnBack.frame = CGRect(x: 5, y: yRef-10, width: 40, height: 40)
        btnBack.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack)
        //Tell us a bit about yourself
        
        yRef = yRef+btnBack.frame.size.height 

        let lblAboutYourSelf:UILabel = UILabel()
        lblAboutYourSelf.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 30)
        lblAboutYourSelf.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
        lblAboutYourSelf.textColor = ColorPink
        lblAboutYourSelf.text = "Which One Are You?"
        lblAboutYourSelf.font = UIFont.init(name: FONT.Kurale.rawValue, size: 28)
        lblAboutYourSelf.textAlignment = .left
        lblAboutYourSelf.clipsToBounds = true
        lblAboutYourSelf.numberOfLines = 0
        lblAboutYourSelf.lineBreakMode = .byWordWrapping
        lblAboutYourSelf.sizeToFit()
        self.view.addSubview(lblAboutYourSelf)

        yRef = yRef+lblAboutYourSelf.frame.size.height + 20
        
        let lblPrivacyContant:UILabel = UILabel()
        lblPrivacyContant.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 30)
        lblPrivacyContant.textColor = GrayColor
        lblPrivacyContant.text = "We are unable to offer options for other genders at present but are working on it!"
        lblPrivacyContant.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        lblPrivacyContant.textAlignment = .left
        lblPrivacyContant.clipsToBounds = true
        lblPrivacyContant.numberOfLines = 0
        lblPrivacyContant.lineBreakMode = .byWordWrapping
        lblPrivacyContant.sizeToFit()
        self.view.addSubview(lblPrivacyContant)

        yRef = yRef+lblPrivacyContant.frame.size.height + 50
        
        viewMale = UIView()
        viewMale.frame = CGRect(x: 20, y: yRef, width: 100, height: 130)
        viewMale.backgroundColor = UIColor.white
        viewMale.layer.cornerRadius = 15
        viewMale.clipsToBounds = true
        viewMale.layer.shadowOffset = CGSize(width: 2, height: 3)
        viewMale.layer.shadowOpacity = 0.3
        viewMale.layer.shadowRadius = 5
        viewMale.layer.shadowColor = UIColor.lightGray.cgColor
        viewMale.layer.masksToBounds = false
        self.view.addSubview(viewMale)
        
        btnMale = UIButton()
        btnMale.frame = CGRect(x: 10, y: 20, width: 45, height: 45)
        btnMale.backgroundColor = UIColor.clear
        btnMale.setImage(UIImage.init(named: "Icon"), for: .normal)
        btnMale.clipsToBounds = true
        viewMale.addSubview(btnMale)
        
        let lblMale:UILabel = UILabel()
        lblMale.frame = CGRect(x: 20, y: 80, width: 80, height: 30)
        lblMale.backgroundColor = UIColor.clear
        lblMale.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        lblMale.text = "Male"
        lblMale.textAlignment = .left
        lblMale.textColor = UIColor.black
        lblMale.clipsToBounds = true
        viewMale.addSubview(lblMale)

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleMaleTap(_:)))
        viewMale.addGestureRecognizer(tap)
        viewMale.isUserInteractionEnabled = true

        viewFeMale = UIView()
        viewFeMale.frame = CGRect(x: 150, y: yRef, width: 100, height: 130)
        viewFeMale.backgroundColor = UIColor.white
        viewFeMale.layer.cornerRadius = 15
        viewFeMale.clipsToBounds = true
        viewFeMale.layer.shadowOffset = CGSize(width: 2, height: 3)
        viewFeMale.layer.shadowOpacity = 0.3
        viewFeMale.layer.shadowRadius = 5
        viewFeMale.layer.shadowColor = UIColor.lightGray.cgColor
        viewFeMale.layer.masksToBounds = false
        self.view.addSubview(viewFeMale)
        
        btnFeMale = UIButton()
        btnFeMale.frame = CGRect(x: 10, y: 20, width: 45, height: 45)
        btnFeMale.backgroundColor = UIColor.clear
        btnFeMale.setImage(UIImage.init(named: "Iconf"), for: .normal)
        btnFeMale.clipsToBounds = true
        viewFeMale.addSubview(btnFeMale)
        
        let lblFeMale:UILabel = UILabel()
        lblFeMale.frame = CGRect(x: 20, y: 80, width: 80, height: 30)
        lblFeMale.backgroundColor = UIColor.clear
        lblFeMale.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        lblFeMale.text = "Female"
        lblFeMale.textAlignment = .left
        lblFeMale.textColor = UIColor.black
        lblFeMale.clipsToBounds = true
        viewFeMale.addSubview(lblFeMale)

        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleFemaleTap(_:)))
        viewFeMale.addGestureRecognizer(tap1)
        viewFeMale.isUserInteractionEnabled = true

        let btnConfirm:UIButton = UIButton()
        btnConfirm.frame = CGRect(x: 20, y: screenHeight-120, width: screenWidth-40, height: 40)
        btnConfirm.backgroundColor = ColorPink
        btnConfirm.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        btnConfirm.setTitleColor(UIColor.white, for: .normal)
        btnConfirm.layer.cornerRadius = 20
        btnConfirm.clipsToBounds = true
        if checkEdite == false {
            btnConfirm.setTitle("Confirm", for: .normal)
            btnConfirm.addTarget(self, action: #selector(self.btnConfirmClicked(_:)), for: .touchUpInside)
        }else {
            btnConfirm.setTitle("Save", for: .normal)
            btnConfirm.addTarget(self, action: #selector(self.btnSaveClicked(_:)), for: .touchUpInside)
        }
        self.view.addSubview(btnConfirm)
     
        if strSelectedGender == "MALE" {
            viewMale.backgroundColor = UIColor.init(red: 93/255.0, green: 216/255.0, blue: 208/255.0, alpha: 1)
            btnMale.setImage(UIImage.init(named: "mailIcon"), for: .normal)
            viewFeMale.backgroundColor = UIColor.white
            btnFeMale.setImage(UIImage.init(named: "Iconf"), for: .normal)
            strSelectedGender = "MALE"
        } else {
            viewFeMale.backgroundColor = UIColor.init(red: 236/255.0, green: 176/255.0, blue: 205/255.0, alpha: 1).withAlphaComponent(0.4)
            viewMale.backgroundColor = UIColor.white
            btnMale.setImage(UIImage.init(named: "Icon"), for: .normal)
            btnFeMale.setImage(UIImage.init(named: "FemaleIcon"), for: .normal)
            strSelectedGender = "FEMALE"
        }
    }

    //MARK: Action
    
    @objc func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btnSaveClicked(_ sender: UIButton) {
        delegate?.gender(strSelectedGender)
        self.dismiss(animated: true, completion: nil)
    }
    //mailIcon
    @objc func handleMaleTap(_ sender: UITapGestureRecognizer? = nil) {
        viewMale.backgroundColor = UIColor.init(red: 93/255.0, green: 216/255.0, blue: 208/255.0, alpha: 1)
        btnMale.setImage(UIImage.init(named: "mailIcon"), for: .normal)
        viewFeMale.backgroundColor = UIColor.white
        btnFeMale.setImage(UIImage.init(named: "Iconf"), for: .normal)

        strSelectedGender = "MALE"
        self.popUpInformation()
    }
    
    @objc func handleFemaleTap(_ sender: UITapGestureRecognizer? = nil) {
        viewFeMale.backgroundColor = UIColor.init(red: 236/255.0, green: 176/255.0, blue: 205/255.0, alpha: 1).withAlphaComponent(0.4)
        viewMale.backgroundColor = UIColor.white
        btnMale.setImage(UIImage.init(named: "Icon"), for: .normal)
        btnFeMale.setImage(UIImage.init(named: "FemaleIcon"), for: .normal)
        
        strSelectedGender = "FEMALE"
    }
    
    @objc func btnConfirmClicked(_ sender: UIButton) {
        if strSelectedGender.isEmpty == true {
            displayToast(getTranslate("select_gender"))
        }else {
            let vc: WeightVC = WeightVC()
            vc.strNickName = strNickName
            vc.strDateOfBirth = strDateOfBirth
            vc.strSelectedGender = strSelectedGender
            vc.selectedDate = selectedDate
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: PopUp Information
    func popUpInformation() {
        viewBG = UIView()
        viewBG.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        viewBG.backgroundColor = ColorPink.withAlphaComponent(0.6)
        viewBG.clipsToBounds = true
        self.view.addSubview(viewBG)
        
        let viewPopUp: UIView = UIView()
        viewPopUp.frame = CGRect(x: (screenWidth-300)/2, y: (screenHeight-320)/2, width: 300, height: 320)
        viewPopUp.backgroundColor = UIColor.white
        viewPopUp.layer.cornerRadius = 8
        viewPopUp.clipsToBounds = true
        viewBG.addSubview(viewPopUp)
        
        let btnCross: UIButton = UIButton()
        btnCross.frame = CGRect(x: viewPopUp.frame.size.width-40, y: 15, width: 25, height: 25)
        btnCross.setImage(UIImage.init(named: "Cross")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnCross.tintColor = ColorPink
        btnCross.clipsToBounds = true
        btnCross.addTarget(self, action: #selector(self.btnCrossClicked(_:)), for: .touchUpInside)
        viewPopUp.addSubview(btnCross)

        let lblHinglish:UILabel = UILabel()
        lblHinglish.frame = CGRect(x: 20, y: 40, width: viewPopUp.frame.size.width-40, height: 40)
        lblHinglish.text = getTranslate("Male anatomy")
        lblHinglish.textAlignment = .center
        lblHinglish.font = UIFont.init(name: FONT.Kurale.rawValue, size: 22.0)
        lblHinglish.textColor = ColorPink
        lblHinglish.clipsToBounds = true
        viewPopUp.addSubview(lblHinglish)

        let lblSport:UILabel = UILabel()
        lblSport.frame = CGRect(x: 30, y: (viewPopUp.frame.size.height/2)-70, width: viewPopUp.frame.size.width-40, height: 30)
        lblSport.text = getTranslate("male_anatomy_text")
        lblSport.textAlignment = .center
        lblSport.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14.0)
        lblSport.textColor = ColorGrayText
        lblSport.clipsToBounds = true
        lblSport.numberOfLines = 0
        lblSport.lineBreakMode = .byWordWrapping
        lblSport.sizeToFit()
        viewPopUp.addSubview(lblSport)

    }
    @objc func btnCrossClicked(_ sender: UIButton) {
        viewBG.removeFromSuperview()
    }

}
