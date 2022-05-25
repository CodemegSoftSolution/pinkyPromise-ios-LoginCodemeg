//
//  WeightVC.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 15/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

protocol WeightProtocol {
    func wieght(_ strWieght: String)
}

class WeightVC: UIViewController {

    var delegate: WeightProtocol?
    
    var checkEdite: Bool = false
    
    var yRef:CGFloat = 44
    var strKG:String = ""
    var heighPicker: TYHeightPicker!
    var lblActualWeight:UILabel = UILabel()

    var strDateOfBirth: String = ""
    var strNickName: String = ""
    var strSelectedGender: String = ""
    var strWeight: String = ""
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
        barprogress.progress = 0.42
        barprogress.trackTintColor = ColorLightGray//ColorPink
        barprogress.clipsToBounds = true
        self.view.addSubview(barprogress)
        
        yRef = yRef+barprogress.frame.size.height + 15
        
        let lblSteps:UILabel = UILabel()
        lblSteps.frame = CGRect(x: 20, y: yRef, width: 200, height: 30)
        lblSteps.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
        lblSteps.textColor = PrimeryPink
        lblSteps.text = "STEP 3/7"
        self.view.addSubview(lblSteps)
        
        yRef = yRef+lblSteps.frame.size.height + 20

        let btnBack:UIButton = UIButton()
        btnBack.frame = CGRect(x: 5, y: yRef-10, width: 40, height: 40)
        btnBack.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack)
        
        yRef = yRef+btnBack.frame.size.height 

        let lblWeight:UILabel = UILabel()
        lblWeight.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 30)
        lblWeight.textColor = ColorPink
        lblWeight.text = "What is your weight?"
        lblWeight.font = UIFont.init(name: FONT.Kurale.rawValue, size: 28)
        lblWeight.textAlignment = .left
        lblWeight.clipsToBounds = true
        lblWeight.numberOfLines = 0
        lblWeight.lineBreakMode = .byWordWrapping
        lblWeight.sizeToFit()
        self.view.addSubview(lblWeight)

        yRef = yRef+lblWeight.frame.size.height + 20
        
        let lblKG:UILabel = UILabel()
        lblKG.frame = CGRect(x: (screenWidth-70)/2, y: (screenHeight/2)-90, width: 70, height: 35)
        lblKG.backgroundColor = ColorLightGray
        lblKG.font = UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)
        lblKG.text = "KG"
        lblKG.textAlignment = .center
        lblKG.textColor = ColorPink
        lblKG.layer.cornerRadius = 4
        lblKG.clipsToBounds = true
        self.view.addSubview(lblKG)
        
        lblActualWeight = UILabel()
        lblActualWeight.frame = CGRect(x: (screenWidth-120)/2, y: (screenHeight/2), width: 120, height: 50)
        lblActualWeight.textColor = UIColor.black
        if checkEdite == false {
            lblActualWeight.text = "80"
        }else {
            lblActualWeight.text = strWeight
        }
        lblActualWeight.font = UIFont.init(name: FONT.Kurale.rawValue, size: 48)
        lblActualWeight.textAlignment = .center
        lblActualWeight.clipsToBounds = true
        self.view.addSubview(lblActualWeight)
                
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
        if checkEdite == false {
            heighPicker.setDefaultHeight(60, unit: .CM)
        }else {
            let intWeight:Int = Int(strWeight)!
            heighPicker.setDefaultHeight(CGFloat(intWeight), unit: .CM)
        }
        
    }

    //MARK: Action
    
    @objc func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btnSaveClicked(_ sender: UIButton) {
        delegate?.wieght(strWeight)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func btnConfirmClicked(_ sender: UIButton) {
        if strWeight.isEmpty == true {
            displayToast(getTranslate("select_weight"))
        } else {
            let vc:HeightVC = HeightVC()
            vc.strNickName = strNickName
            vc.strDateOfBirth = strDateOfBirth
            vc.strSelectedGender = strSelectedGender
            vc.strWeight = strWeight
            vc.selectedDate = selectedDate
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func multipleSize(_ strText: String) {
        let attrs1 = [NSAttributedString.Key.font : UIFont.init(name: FONT.Kurale.rawValue, size: 48), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attrs2 = [NSAttributedString.Key.font : UIFont.init(name: FONT.Kurale.rawValue, size: 16), NSAttributedString.Key.foregroundColor : UIColor.black]

        let attributedString1 = NSMutableAttributedString(string:strText, attributes:attrs1 as [NSAttributedString.Key : Any])
        let attributedString2 = NSMutableAttributedString(string:"kg", attributes:attrs2 as [NSAttributedString.Key : Any])
        attributedString1.append(attributedString2)
        lblActualWeight.attributedText = attributedString1
    }
}
extension WeightVC: TYHeightPickerDelegate {
    
    func selectedHeight(height: CGFloat, unit: HeightUnit) {
        if unit == .CM {
            let intHeight: Int = Int(height)
            let strHeight:String = String(intHeight)
            self.multipleSize(strHeight)
            strWeight = strHeight
            print(strWeight)
        }
        
        if unit == .Inch {
            let feet = Int(height / 12)
            let inch = Int(height) % 12
                    
            if inch != 0 {
                lblActualWeight.text = "\(feet) feet \(inch) inch"
                
            } else  {
                lblActualWeight.text = "\(feet) KG"
                strWeight = String(feet)
                print(strWeight)
            }
        }
    }
}
