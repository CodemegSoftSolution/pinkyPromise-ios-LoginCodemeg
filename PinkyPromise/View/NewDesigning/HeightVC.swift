//
//  HeightVC.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 16/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

protocol HeightProtocol {
    func height(_ strHeight: String, strUnit: String)
}

class HeightVC: UIViewController {

    var delegate: HeightProtocol?
    
    var checkEdite: Bool = false
    var strHeightUnit:String = ""
    
    var yRef:CGFloat = 44
    var heighPicker: TYHeightPicker!
    var lblActualFit:UILabel = UILabel()
    var lblActualInch:UILabel = UILabel()
    var btnFitInch:UIButton = UIButton()
    var btnCM:UIButton = UIButton()
    var lblActualCM:UILabel = UILabel()
    
    var strDateOfBirth: String = ""
    var strNickName: String = ""
    var strSelectedGender: String = ""
    var strWeight: String = ""
    var strHeight: String = ""
    var selectedDate: Date!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.screenDesigning()
    }
    
    func screenDesigning() {
        let barprogress:UIProgressView = UIProgressView()
        barprogress.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 20)
        barprogress.tintColor = ColorPink
        barprogress.progress = 0.57
        barprogress.trackTintColor = ColorLightGray//ColorPink
        barprogress.clipsToBounds = true
        self.view.addSubview(barprogress)
        
        yRef = yRef+barprogress.frame.size.height + 15
        
        let lblSteps:UILabel = UILabel()
        lblSteps.frame = CGRect(x: 20, y: yRef, width: 200, height: 30)
        lblSteps.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
        lblSteps.textColor = PrimeryPink
        lblSteps.text = "STEP 4/7"
        self.view.addSubview(lblSteps)
        
        yRef = yRef+lblSteps.frame.size.height

        let btnBack:UIButton = UIButton()
        btnBack.frame = CGRect(x: 5, y: yRef-10, width: 40, height: 40)
        btnBack.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack)
        
        yRef = yRef+btnBack.frame.size.height + 20

        let lblWeight:UILabel = UILabel()
        lblWeight.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 30)
        lblWeight.textColor = ColorPink
        lblWeight.text = "How tall are you?"
        lblWeight.font = UIFont.init(name: FONT.Kurale.rawValue, size: 28)
        lblWeight.textAlignment = .left
        lblWeight.clipsToBounds = true
        lblWeight.numberOfLines = 0
        lblWeight.lineBreakMode = .byWordWrapping
        lblWeight.sizeToFit()
        self.view.addSubview(lblWeight)

        yRef = yRef+lblWeight.frame.size.height + 20
        
        btnFitInch = UIButton()
        btnFitInch.frame = CGRect(x: (screenWidth/2)-85, y: (screenHeight/2)-90, width: 70, height: 35)
        btnFitInch.backgroundColor = ColorPink
        btnFitInch.titleLabel?.font = UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)
        btnFitInch.setTitle("Ft & In", for: .normal)
        btnFitInch.setTitleColor(UIColor.white, for: .normal)
        btnFitInch.layer.cornerRadius = 4
        btnFitInch.clipsToBounds = true
        btnFitInch.addTarget(self, action: #selector(self.btnFtInClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnFitInch)

        btnCM = UIButton()
        btnCM.frame = CGRect(x: (screenWidth/2)+15, y: (screenHeight/2)-90, width: 70, height: 35)
        btnCM.backgroundColor = ColorLightGray
        btnCM.titleLabel?.font = UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)
        btnCM.setTitle("Cm", for: .normal)
        btnCM.setTitleColor(ColorPink, for: .normal)
        btnCM.layer.cornerRadius = 4
        btnCM.clipsToBounds = true
        btnCM.addTarget(self, action: #selector(self.btnCMClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnCM)
        
        lblActualFit = UILabel()
        lblActualFit.frame = CGRect(x: (screenWidth/2)-102, y: (screenHeight/2), width: 100, height: 50)
        lblActualFit.textColor = UIColor.black
        lblActualFit.text = "80"
        lblActualFit.font = UIFont.init(name: FONT.Kurale.rawValue, size: 48)
        lblActualFit.textAlignment = .right
        lblActualFit.clipsToBounds = true
        self.view.addSubview(lblActualFit)
                
        lblActualInch = UILabel()
        lblActualInch.frame = CGRect(x: (screenWidth/2)+2, y: (screenHeight/2), width: 100, height: 50)
        lblActualInch.textColor = UIColor.black
        lblActualInch.text = "80"
        lblActualInch.font = UIFont.init(name: FONT.Kurale.rawValue, size: 48)
        lblActualInch.textAlignment = .left
        lblActualInch.clipsToBounds = true
        self.view.addSubview(lblActualInch)

        lblActualCM = UILabel()
        lblActualCM.frame = CGRect(x: (screenWidth-100)/2, y: (screenHeight/2), width: 100, height: 50)
        lblActualCM.textColor = UIColor.black
        lblActualCM.text = ""
        lblActualCM.font = UIFont.init(name: FONT.Kurale.rawValue, size: 48)
        lblActualCM.textAlignment = .left
        lblActualCM.clipsToBounds = true
        self.view.addSubview(lblActualCM)

        lblActualCM.isHidden = true
        
        self.setupTYHeightPicker()

        let btnConfirm:UIButton = UIButton()
        btnConfirm.frame = CGRect(x: 20, y: screenHeight-100, width: screenWidth-40, height: 40)
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
        
     }
    //MARK: Action
    
    @objc func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btnSaveClicked(_ sender: UIButton) {
        delegate?.height(strHeight, strUnit: strHeightUnit)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func btnConfirmClicked(_ sender: UIButton) {
        if strHeight.isEmpty == true {
            displayToast(getTranslate("select_height"))
        } else {
            let vc:PeriodsVC = PeriodsVC()
            vc.strNickName = strNickName
            vc.strDateOfBirth = strDateOfBirth
            vc.strSelectedGender = strSelectedGender
            vc.strWeight = strWeight
            vc.strHeight = strHeight
            vc.selectedDate = selectedDate
            vc.strHeightUnit = strHeightUnit
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func btnCMClicked(_ sender: UIButton) {
        btnCM.backgroundColor = ColorPink//ColorLightGray
        btnCM.setTitleColor(UIColor.white, for: .normal)
        btnFitInch.backgroundColor = ColorLightGray//ColorPink
        btnFitInch.setTitleColor(ColorPink, for: .normal)
        heighPicker.setDefaultHeight(56, unit: .CM)
    }
    
    @objc func btnFtInClicked(_ sender: UIButton) {
        btnCM.backgroundColor = ColorLightGray
        btnCM.setTitleColor(ColorPink, for: .normal)
        btnFitInch.backgroundColor = ColorPink
        btnFitInch.setTitleColor(UIColor.white, for: .normal)
        heighPicker.setDefaultHeight(56, unit: .Inch)
    }
    
   func setupTYHeightPicker() {
       
       heighPicker = TYHeightPicker()
       heighPicker.translatesAutoresizingMaskIntoConstraints = false
       heighPicker.delegate = self
       self.view.addSubview(heighPicker)
       
       heighPicker.cmBtn.isHidden = true
       heighPicker.feetInchBtn.isHidden = true
       heighPicker.indicatorView.isHidden = true
       heighPicker.resultLabel.isHidden = true
       
       heighPicker.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
       heighPicker.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
       heighPicker.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (screenHeight/2)+60).isActive = true
       heighPicker.heightAnchor.constraint(equalToConstant: 145).isActive = true
       heighPicker.clipsToBounds = true
       if checkEdite == true {
           let intHeigh:Int = Int(strHeight)!
           if strHeightUnit == "In" {
               heighPicker.setDefaultHeight(CGFloat(intHeigh), unit: .Inch)
           }else {
               heighPicker.setDefaultHeight(CGFloat(intHeigh), unit: .CM)
           }
       }else {
           heighPicker.setDefaultHeight(56, unit: .Inch)
       }
       
   }
    func multipleSize(_ strText: String, strHight: String, lable: UILabel) {
        let attrs1 = [NSAttributedString.Key.font : UIFont.init(name: FONT.Kurale.rawValue, size: 48), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attrs2 = [NSAttributedString.Key.font : UIFont.init(name: FONT.Kurale.rawValue, size: 16), NSAttributedString.Key.foregroundColor : UIColor.black]

        let attributedString1 = NSMutableAttributedString(string:strText, attributes:attrs1 as [NSAttributedString.Key : Any])
        let attributedString2 = NSMutableAttributedString(string:strHight, attributes:attrs2 as [NSAttributedString.Key : Any])
        attributedString1.append(attributedString2)
        lable.attributedText = attributedString1
    }

}

extension HeightVC: TYHeightPickerDelegate {
    
    func selectedHeight(height: CGFloat, unit: HeightUnit) {
        if unit == .CM {
            let intHeight: Int = Int(height)
            let strheight:String = String(intHeight)
            self.lblActualFit.isHidden = true
            self.lblActualInch.isHidden = true
            self.lblActualCM.isHidden = false
            
            strHeight = strheight
            strHeightUnit = "CM"
            
            self.multipleSize(strheight, strHight: "CM", lable: lblActualCM)
        }
        
        if unit == .Inch {
            var feet = Int(height / 12)
            let inch = Int(height) % 12
            
            self.lblActualCM.isHidden = true
            self.lblActualFit.isHidden = false
            self.lblActualInch.isHidden = false

            strHeightUnit = "In"
            
            if inch != 0 {
                //lblActualFit.text = "\(feet) feet \(inch) inch"
                let strfeet: String = String(feet)
                let strInch: String = String(inch)
                
                self.multipleSize(strfeet, strHight: "Ft", lable: lblActualFit)
                self.multipleSize(strInch, strHight: "In", lable: lblActualInch)
                feet = (feet*12)+inch
                strHeight = String(feet)
                
            } else  {
                //lblActualFit.text = "\(feet) feet \(inch) inch"
            }
        }
    }
}
