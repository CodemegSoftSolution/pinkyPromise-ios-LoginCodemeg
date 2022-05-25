//
//  AboutMeViewController.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 13/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

protocol Nickname {
    func strNickName(_ strNickName: String, selectDate: Date)
}
class AboutMeViewController: UIViewController {
    
    var delegate: Nickname?
    
    var checkEdite:Bool = false

    var yRef:CGFloat = 44
    var viewCalander:UIButton = UIButton()
    var strChooseTime:String = ""
    var datepicker:UIDatePicker = UIDatePicker()
    var checkUpDate:Bool = false
    var txtD1:UITextField = UITextField()
    var txtD2:UITextField = UITextField()
    var txtM1:UITextField = UITextField()
    var txtM2:UITextField = UITextField()
    var txtY1:UITextField = UITextField()
    var txtY2:UITextField = UITextField()
    var strDateOfBirth: String = ""
    var strNickName: String = ""
    var txtNickName:UITextField = UITextField()
    var selectedDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.screenDesigning()
    }
    func screenDesigning(){
        
        let barprogress:UIProgressView = UIProgressView()
        barprogress.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 20)
        barprogress.tintColor = ColorPink
        barprogress.progress = 0.142
        barprogress.trackTintColor = ColorLightGray//ColorPink
        barprogress.clipsToBounds = true
        self.view.addSubview(barprogress)
        
        yRef = yRef+barprogress.frame.size.height + 15
        
        let lblSteps:UILabel = UILabel()
        lblSteps.frame = CGRect(x: 20, y: yRef, width: 200, height: 30)
        lblSteps.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
        lblSteps.textColor = PrimeryPink
        lblSteps.text = "STEP 1/7"
        self.view.addSubview(lblSteps)
        
        yRef = yRef+lblSteps.frame.size.height + 20

        let btnBack:UIButton = UIButton()
        btnBack.frame = CGRect(x: 5, y: yRef-10, width: 40, height: 40)
        btnBack.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack)
        //Tell us a bit about yourself
        
        yRef = yRef+btnBack.frame.size.height

        let attributedString = NSMutableAttributedString(string: "Tell us a bit about yourself")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        let lblAboutYourSelf:UILabel = UILabel()
        lblAboutYourSelf.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 120)
        lblAboutYourSelf.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
        lblAboutYourSelf.textColor = ColorPink
        lblAboutYourSelf.attributedText = attributedString
        lblAboutYourSelf.font = UIFont.init(name: FONT.Kurale.rawValue, size: 39.0)
        lblAboutYourSelf.textAlignment = .left
        lblAboutYourSelf.clipsToBounds = true
        lblAboutYourSelf.numberOfLines = 2
        lblAboutYourSelf.lineBreakMode = .byWordWrapping
        //lblAboutYourSelf.sizeToFit()
        self.view.addSubview(lblAboutYourSelf)

        yRef = yRef+lblAboutYourSelf.frame.size.height + 20
        
        let lblPrivacyContant:UILabel = UILabel()
        lblPrivacyContant.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 30)
        lblPrivacyContant.textColor = ColorGrayText
        lblPrivacyContant.text = "What is the name you prefer to use on our app! We protect and respect your privacy!"
        lblPrivacyContant.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        lblPrivacyContant.textAlignment = .left
        lblPrivacyContant.clipsToBounds = true
        lblPrivacyContant.numberOfLines = 0
        lblPrivacyContant.lineBreakMode = .byWordWrapping
        lblPrivacyContant.sizeToFit()
        self.view.addSubview(lblPrivacyContant)

        yRef = yRef+lblPrivacyContant.frame.size.height + 20

        txtNickName = UITextField()
        txtNickName.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 45)
        txtNickName.backgroundColor = ColorLightGray
        txtNickName.placeholder = "Nickname/Name"
        if checkEdite == true {
            txtNickName.text = strNickName
        }
        txtNickName.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtNickName.setLeftPaddingPoints(40)
        txtNickName.layer.cornerRadius = 8
        txtNickName.clipsToBounds = true
        self.view.addSubview(txtNickName)
        
        let imgLeft:UIImageView = UIImageView()
        imgLeft.frame = CGRect(x: 15, y: 12.5, width: 20, height: 20)
        imgLeft.image = UIImage.init(named: "Duotone")
        txtNickName.addSubview(imgLeft)
        
        yRef = yRef+txtNickName.frame.size.height + 30
        
        let lblDateofbirth: UILabel = UILabel()
        lblDateofbirth.frame = CGRect(x: 15, y: yRef, width: 120, height: 35)
        lblDateofbirth.backgroundColor = UIColor.clear
        lblDateofbirth.text = "Date of birth"
        lblDateofbirth.textAlignment = .left
        lblDateofbirth.font = UIFont.init(name: FONT.Kurale.rawValue, size: 18.0)
        lblDateofbirth.textColor = ColorGrayText
        self.view.addSubview(lblDateofbirth)
        
        yRef = yRef+lblDateofbirth.frame.size.height + 10

        txtD1 = UITextField()
        txtD1.frame = CGRect(x: 20, y: yRef, width: 30, height: 30)
        txtD1.backgroundColor = UIColor.clear
        txtD1.textAlignment = .center
        txtD1.placeholder = "D"
        txtD1.layer.borderWidth = 1
        txtD1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtD1.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtD1.layer.cornerRadius = 5
        txtD1.isUserInteractionEnabled = false
        txtD1.clipsToBounds = true
        self.view.addSubview(txtD1)

        txtD2 = UITextField()
        txtD2.frame = CGRect(x: 55, y: yRef, width: 30, height: 30)
        txtD2.backgroundColor = UIColor.clear
        txtD2.placeholder = "D"
        txtD2.textAlignment = .center
        txtD2.layer.borderWidth = 1
        txtD2.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtD2.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtD2.layer.cornerRadius = 5
        txtD2.isUserInteractionEnabled = false
        txtD2.clipsToBounds = true
        self.view.addSubview(txtD2)

        txtM1 = UITextField()
        txtM1.frame = CGRect(x: 100, y: yRef, width: 30, height: 30)
        txtM1.backgroundColor = UIColor.clear
        txtM1.placeholder = "M"
        txtM1.textAlignment = .center
        txtM1.layer.borderWidth = 1
        txtM1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtM1.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtM1.layer.cornerRadius = 5
        txtM1.isUserInteractionEnabled = false
        txtM1.clipsToBounds = true
        self.view.addSubview(txtM1)

        txtM2 = UITextField()
        txtM2.frame = CGRect(x: 135, y: yRef, width: 30, height: 30)
        txtM2.backgroundColor = UIColor.clear
        txtM2.layer.borderWidth = 1
        txtM2.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtM2.placeholder = "M"
        txtM2.textAlignment = .center
        txtM2.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtM2.layer.cornerRadius = 5
        txtM2.isUserInteractionEnabled = false
        txtM2.clipsToBounds = true
        self.view.addSubview(txtM2)

        txtY1 = UITextField()
        txtY1.frame = CGRect(x: 180, y: yRef, width: 30, height: 30)
        txtY1.backgroundColor = UIColor.clear
        txtY1.placeholder = "Y"
        txtY1.textAlignment = .center
        txtY1.layer.borderWidth = 1
        txtY1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtY1.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtY1.layer.cornerRadius = 5
        txtY1.isUserInteractionEnabled = false
        txtY1.clipsToBounds = true
        self.view.addSubview(txtY1)
        
        txtY2 = UITextField()
        txtY2.frame = CGRect(x: 215, y: yRef, width: 30, height: 30)
        txtY2.backgroundColor = UIColor.clear
        txtY2.placeholder = "Y"
        txtY2.textAlignment = .center
        txtY2.layer.borderWidth = 1
        txtY2.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtY2.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtY2.layer.cornerRadius = 5
        txtY2.isUserInteractionEnabled = false
        txtY2.clipsToBounds = true
        self.view.addSubview(txtY2)

        let btnCalander:UIButton = UIButton()
        btnCalander.frame = CGRect(x: 260, y: yRef, width: 30, height: 30)
        btnCalander.backgroundColor = UIColor.clear
        btnCalander.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        btnCalander.setImage(UIImage.init(named: "Icon-1"), for: .normal)
        btnCalander.layer.cornerRadius = 5
        btnCalander.clipsToBounds = true
        btnCalander.addTarget(self, action: #selector(self.btnCalenderClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnCalander)
        
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
        
        if checkEdite == true {
            self.editeCalender()
        }
    }
    func editeCalender(){
        txtD1.text = getRangeString(0, lenth: 1, strDate: strDateOfBirth)
        txtD2.text = getRangeString(1, lenth: 1, strDate: strDateOfBirth)
        txtM1.text = getRangeString(3, lenth: 1, strDate: strDateOfBirth)
        txtM2.text = getRangeString(4, lenth: 1, strDate: strDateOfBirth)
        txtY1.text = getRangeString(8, lenth: 1, strDate: strDateOfBirth)
        txtY2.text = getRangeString(9, lenth: 1, strDate: strDateOfBirth)

    }
    //MARK: Action
    @objc func btnCalenderClicked(_ sender: UIButton) {
        //self.OpenCalander()
        
        showDatePicker(title: "Select Date", selected: selectedDate, minDate: nil, maxDate: nil) { (date) in
            //self.dateTxt.text = getDateStringFromDate(date: date, format: DATE_FORMMATE.DATE2.getValue())
            let strdate = getDateStringFromDate(date: date, format: DATE_FORMMATE.DATE2.getValue())
            print(strdate)
            self.addDate(date)
        } completionClose: {
        }
    }
//    func OpenCalander(){
//
//        viewCalander = UIButton()
//        viewCalander.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
//        viewCalander.backgroundColor = ColorPink.withAlphaComponent(0.5)
//        viewCalander.addTarget(self, action: #selector(self.hidePickerClicked(_:)), for: .touchUpInside)
//        self.view.addSubview(viewCalander)
//
//        let sLayer:CAShapeLayer = CAShapeLayer()
//        let viewUpTime:UIView = UIView()
//        viewUpTime.frame = CGRect(x: 10, y: (screenHeight/2)-120, width: screenWidth-20, height: 50)
//        viewUpTime.backgroundColor = UIColor.white
//        viewUpTime.ShaplayerUp(sLayer, corner: 8)
//        viewCalander.addSubview(viewUpTime)
//
//        let btnDone:UIButton = UIButton()
//        btnDone.frame = CGRect(x: viewUpTime.frame.size.width-100, y: 0, width: 100, height: 50)
//        btnDone.setTitle("Done", for: .normal)
//        btnDone.setTitleColor(ColorPink, for: .normal)
//        btnDone.addTarget(self, action: #selector(self.btnDoneClicked(_:)), for: .touchUpInside)
//        viewUpTime.addSubview(btnDone)
//
//        let saLayer:CAShapeLayer = CAShapeLayer()
//        datepicker = UIDatePicker()
//        datepicker.frame = CGRect(x: 10, y: (screenHeight/2)-70, width: screenWidth-20, height: 180)
//        datepicker.ShaplayerDown(saLayer, corner: 8)
//        datepicker.clipsToBounds = true
//        datepicker.backgroundColor = UIColor.white
//        datepicker.datePickerMode = .date
//        datepicker.maximumDate = Date()
//        datepicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
//        viewCalander.addSubview(datepicker)
//    }
    
    @objc func hidePickerClicked(_ sender: UIButton){
        viewCalander.removeFromSuperview()
        datepicker.removeFromSuperview()
    }
    @objc func btnDoneClicked(_ sender: UIButton){
        viewCalander.removeFromSuperview()
        datepicker.removeFromSuperview()
    }
    
    func addDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd-MM-yy"
        
        let strDate:String = dateFormatter.string(from: date)
        txtD1.text = getRangeString(0, lenth: 1, strDate: strDate)
        txtD2.text = getRangeString(1, lenth: 1, strDate: strDate)
        txtM1.text = getRangeString(3, lenth: 1, strDate: strDate)
        txtM2.text = getRangeString(4, lenth: 1, strDate: strDate)
        txtY1.text = getRangeString(6, lenth: 1, strDate: strDate)
        txtY2.text = getRangeString(7, lenth: 1, strDate: strDate)
         
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        strDateOfBirth = dateFormatter1.string(from: date)
        print(strDateOfBirth)
        selectedDate = date

    }
    
//    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "dd-MM-yy"
//
//        let strDate:String = dateFormatter.string(from: sender.date)
//        txtD1.text = getRangeString(0, lenth: 1, strDate: strDate)
//        txtD2.text = getRangeString(1, lenth: 1, strDate: strDate)
//        txtM1.text = getRangeString(3, lenth: 1, strDate: strDate)
//        txtM2.text = getRangeString(4, lenth: 1, strDate: strDate)
//        txtY1.text = getRangeString(6, lenth: 1, strDate: strDate)
//        txtY2.text = getRangeString(7, lenth: 1, strDate: strDate)
//
//        let dateFormatter1 = DateFormatter()
//        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter1.dateFormat = "yyyy-MM-dd"
//        strDateOfBirth = dateFormatter1.string(from: sender.date)
//        print(strDateOfBirth)
//
//        selectedDate = sender.date
//    }
    
    func getRangeString(_ location: Int, lenth: Int, strDate: String) -> String{
        let nsrange = NSRange(location: location, length: lenth)
        var strRange: String = ""
        if let range = Range(nsrange, in: strDate) {
            print(strDate[range])
            strRange = String(strDate[range])
        }
        return strRange
    }
    //MARK: Action
    
    @objc func btnBackClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btnSaveClicked(_ sender: UIButton){
        delegate?.strNickName(txtNickName.text!, selectDate: selectedDate)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func btnConfirmClicked(_ sender: UIButton) {
        let minDate : Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!

        strNickName = txtNickName.text!
        let name = txtNickName.text!
        let date = strDateOfBirth
        if name == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_nickname"))
        }
        else if date == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("select_dob"))
        } else if selectedDate > minDate {
            displayToast(getTranslate("must_above_18_year"))
        }
        else {
            let vc:GenderVC = GenderVC()
            vc.strDateOfBirth = strDateOfBirth
            vc.strNickName = strNickName
            vc.selectedDate = selectedDate
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
