//
//  ProfilePageVC.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 23/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit
import Alamofire

class ProfilePageVC: UIViewController {

    var yRef: CGFloat = 15.0
    var heighPicker = TYHeightPicker()
    var WeightPicker = TYHeightPicker()
    var viewWhiteBG:UIView = UIView()
    var arrAllData:NSMutableArray = NSMutableArray()
    
    var txtNickName:UITextField = UITextField()
    var txtD1 = UITextField()
    var txtD2 = UITextField()
    var txtM1 = UITextField()
    var txtM2 = UITextField()
    var txtY1 = UITextField()
    var txtY2 = UITextField()
    var lblGender:UILabel = UILabel()
    var lblWightSize:UILabel = UILabel()
    var lblHeightSize:UILabel = UILabel()
    var txtPeriodD1 = UITextField()
    var txtPeriodD2 = UITextField()
    var txtPeriodM1 = UITextField()
    var txtPeriodM2 = UITextField()
    var txtPeriodY1 = UITextField()
    var txtPeriodY2 = UITextField()
    var lblBleedingDays:UILabel = UILabel()
    var lblLengthDays:UILabel = UILabel()
    var imgGender:UIImageView = UIImageView()
    var strHeightUnit: String = ""

    private var CreateAccountVM: CreateAccountViewModel = CreateAccountViewModel()
    private var GetListChatRoomVM: GetListChatRoomViewModel = GetListChatRoomViewModel()
    var strWeight: String = ""
    var strHeight: String = ""
    var strPeriodDate: String = ""
    var strPeriodDuration: String = ""
    var strPeriodCircle: String = ""
    var GenderString: String = ""
    var strName: String = ""

    var dateTxt: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.headerDesigning()
        self.screenDesigning()
        self.getUserInfoAPI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func headerDesigning() {
        
        let viewHeaderBG:UIView = UIView()
        viewHeaderBG.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 210)
        viewHeaderBG.backgroundColor = UIColor.init(red: 255/255.0, green: 142/255.0, blue: 140/255.0, alpha: 1)
        viewHeaderBG.clipsToBounds = true
        self.view.addSubview(viewHeaderBG)

        let imgOnboard3:UIImageView = UIImageView()
        imgOnboard3.frame = CGRect(x: screenWidth-120, y: 50, width: 100, height: 100)
        imgOnboard3.backgroundColor = UIColor.clear
        imgOnboard3.image = UIImage.init(named: "onboarding_illust-3")
        imgOnboard3.clipsToBounds = true
        self.view.addSubview(imgOnboard3)
        
        let btnBack:UIButton = UIButton()
        btnBack.frame = CGRect(x: 10, y: 40, width: 30, height: 30)
        btnBack.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack)
        
        let lblProfile:UILabel = UILabel()
        lblProfile.frame = CGRect(x: 20, y: 90, width: 120, height: 50)
        lblProfile.backgroundColor = UIColor.clear
        lblProfile.text = "Profile"
        lblProfile.textColor = UIColor.white
        lblProfile.clipsToBounds = true
        lblProfile.font = UIFont.init(name: FONT.Kurale.rawValue, size: 30)
        self.view.addSubview(lblProfile)

    }
    
    func screenDesigning() {
        
        let viewbgWhite = UIView()
        viewbgWhite.frame = CGRect(x: 0, y: 180, width: screenWidth, height:screenHeight-180)
        viewbgWhite.backgroundColor = UIColor.white
        viewbgWhite.layer.cornerRadius = 25
        viewbgWhite.clipsToBounds = true
        self.view.addSubview(viewbgWhite)

        let viewScroll:UIScrollView = UIScrollView()
        viewScroll.frame = CGRect(x: 0, y: 190, width: screenWidth, height: screenHeight-250)
        viewScroll.backgroundColor = UIColor.clear
        viewScroll.clipsToBounds = true
        self.view.addSubview(viewScroll)

        viewWhiteBG = UIView()
        viewWhiteBG.frame = CGRect(x: 0, y: 0, width: screenWidth, height:1270)
        viewWhiteBG.backgroundColor = UIColor.clear
        viewWhiteBG.layer.cornerRadius = 25
        viewWhiteBG.clipsToBounds = true
        viewScroll.addSubview(viewWhiteBG)
        
        let lblNickName:UILabel = UILabel()
        lblNickName.frame = CGRect(x: 20, y: yRef, width: 200, height: 30)
        lblNickName.backgroundColor = UIColor.clear
        lblNickName.text = "Name/Nickname"
        lblNickName.textColor = ColorHeaderText
        lblNickName.textAlignment = .left
        lblNickName.clipsToBounds = true
        lblNickName.font = UIFont.init(name: FONT.Kurale.rawValue, size: 20)
        viewWhiteBG.addSubview(lblNickName)
        
        yRef = yRef+lblNickName.frame.size.height+10
        
        txtNickName = UITextField()
        txtNickName.frame = CGRect(x: 20, y: yRef, width: 120, height: 30)
        txtNickName.backgroundColor = UIColor.clear
        txtNickName.text = ""
        txtNickName.textColor = ColorGrayText
        txtNickName.clipsToBounds = true
        txtNickName.font = UIFont.init(name: FONT.Kurale.rawValue, size: 20)
        txtNickName.isUserInteractionEnabled = false
        viewWhiteBG.addSubview(txtNickName)

        yRef = yRef+txtNickName.frame.size.height
        
        let lblLine:UILabel = UILabel()
        lblLine.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 2)
        lblLine.backgroundColor = ColorPink
        lblLine.clipsToBounds = true
        viewWhiteBG.addSubview(lblLine)

        yRef = yRef+lblLine.frame.size.height + 1
        
        let btnEditeNickName:UIButton = UIButton()
        btnEditeNickName.frame = CGRect(x: screenWidth-55, y: yRef, width: 45, height: 25)
        btnEditeNickName.backgroundColor = UIColor.clear
        btnEditeNickName.setTitle("Edit", for: .normal)
        btnEditeNickName.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        btnEditeNickName.setTitleColor(LightGrayEdit, for: .normal)
        btnEditeNickName.clipsToBounds = true
        btnEditeNickName.addTarget(self, action: #selector(self.btnNickNameClicked(_:)), for: .touchUpInside)
        viewWhiteBG.addSubview(btnEditeNickName)

        yRef = yRef+btnEditeNickName.frame.size.height + 10

        let lblDOB:UILabel = UILabel()
        lblDOB.frame = CGRect(x: 20, y: yRef, width: 120, height: 30)
        lblDOB.backgroundColor = UIColor.clear
        lblDOB.text = "Date of birth"
        lblDOB.textColor = ColorGrayText
        lblDOB.textAlignment = .left
        lblDOB.clipsToBounds = true
        lblDOB.font = UIFont.init(name: FONT.Kurale.rawValue, size: 20)
        viewWhiteBG.addSubview(lblDOB)
        
        yRef = yRef+lblDOB.frame.size.height + 10

        txtD1 = UITextField()
        txtD1.frame = CGRect(x: 20, y: yRef, width: 30, height: 30)
        txtD1.backgroundColor = UIColor.clear
        txtD1.textAlignment = .center
        txtD1.placeholder = "D"
        txtD1.layer.borderWidth = 1
        txtD1.textColor = ColorPink
        txtD1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtD1.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtD1.layer.cornerRadius = 5
        txtD1.isUserInteractionEnabled = false
        txtD1.clipsToBounds = true
        viewWhiteBG.addSubview(txtD1)

        txtD2 = UITextField()
        txtD2.frame = CGRect(x: 55, y: yRef, width: 30, height: 30)
        txtD2.backgroundColor = UIColor.clear
        txtD2.placeholder = "D"
        txtD2.textAlignment = .center
        txtD2.layer.borderWidth = 1
        txtD2.textColor = ColorPink
        txtD2.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtD2.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtD2.layer.cornerRadius = 5
        txtD2.isUserInteractionEnabled = false
        txtD2.clipsToBounds = true
        viewWhiteBG.addSubview(txtD2)

        txtM1 = UITextField()
        txtM1.frame = CGRect(x: 100, y: yRef, width: 30, height: 30)
        txtM1.backgroundColor = UIColor.clear
        txtM1.placeholder = "M"
        txtM1.textAlignment = .center
        txtM1.layer.borderWidth = 1
        txtM1.textColor = ColorPink
        txtM1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtM1.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtM1.layer.cornerRadius = 5
        txtM1.isUserInteractionEnabled = false
        txtM1.clipsToBounds = true
        viewWhiteBG.addSubview(txtM1)

        txtM2 = UITextField()
        txtM2.frame = CGRect(x: 135, y: yRef, width: 30, height: 30)
        txtM2.backgroundColor = UIColor.clear
        txtM2.layer.borderWidth = 1
        txtM2.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtM2.placeholder = "M"
        txtM2.textAlignment = .center
        txtM2.textColor = ColorPink
        txtM2.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtM2.layer.cornerRadius = 5
        txtM2.isUserInteractionEnabled = false
        txtM2.clipsToBounds = true
        viewWhiteBG.addSubview(txtM2)

        txtY1 = UITextField()
        txtY1.frame = CGRect(x: 180, y: yRef, width: 30, height: 30)
        txtY1.backgroundColor = UIColor.clear
        txtY1.placeholder = "Y"
        txtY1.textAlignment = .center
        txtY1.layer.borderWidth = 1
        txtY1.textColor = ColorPink
        txtY1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtY1.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtY1.layer.cornerRadius = 5
        txtY1.isUserInteractionEnabled = false
        txtY1.clipsToBounds = true
        viewWhiteBG.addSubview(txtY1)
        
        txtY2 = UITextField()
        txtY2.frame = CGRect(x: 215, y: yRef, width: 30, height: 30)
        txtY2.backgroundColor = UIColor.clear
        txtY2.placeholder = "Y"
        txtY2.textAlignment = .center
        txtY2.layer.borderWidth = 1
        txtY2.textColor = ColorPink
        txtY2.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtY2.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtY2.layer.cornerRadius = 5
        txtY2.isUserInteractionEnabled = false
        txtY2.clipsToBounds = true
        viewWhiteBG.addSubview(txtY2)

        let btnCalander:UIButton = UIButton()
        btnCalander.frame = CGRect(x: 260, y: yRef, width: 30, height: 30)
        btnCalander.backgroundColor = UIColor.clear
        btnCalander.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        btnCalander.setImage(UIImage.init(named: "Icon-1"), for: .normal)
        btnCalander.layer.cornerRadius = 5
        btnCalander.clipsToBounds = true
        viewWhiteBG.addSubview(btnCalander)

        let btnEditeCalender:UIButton = UIButton()
        btnEditeCalender.frame = CGRect(x: screenWidth-55, y: yRef+15, width: 45, height: 25)
        btnEditeCalender.backgroundColor = UIColor.clear
        btnEditeCalender.setTitle("Edit", for: .normal)
        btnEditeCalender.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        btnEditeCalender.setTitleColor(LightGrayEdit, for: .normal)
        btnEditeCalender.clipsToBounds = true
        btnEditeCalender.addTarget(self, action: #selector(self.btnDOBClicked(_:)), for: .touchUpInside)
        viewWhiteBG.addSubview(btnEditeCalender)

        yRef = yRef+btnCalander.frame.size.height + 15

        let lblSex:UILabel = UILabel()
        lblSex.frame = CGRect(x: 20, y: yRef, width: 120, height: 30)
        lblSex.backgroundColor = UIColor.clear
        lblSex.text = "Sex"
        lblSex.textColor = ColorGrayText
        lblSex.textAlignment = .left
        lblSex.clipsToBounds = true
        lblSex.font = UIFont.init(name: FONT.Kurale.rawValue, size: 20)
        viewWhiteBG.addSubview(lblSex)
        
        yRef = yRef+lblSex.frame.size.height + 10

        imgGender = UIImageView()
        imgGender.frame = CGRect(x: 20, y:yRef, width: 35, height: 35)
        imgGender.backgroundColor = UIColor.clear
        imgGender.image = UIImage.init(named: "FemaleIcon")
        imgGender.clipsToBounds = true
        viewWhiteBG.addSubview(imgGender)
        
        lblGender = UILabel()
        lblGender.frame = CGRect(x: 70, y: yRef, width: 120, height: 35)
        lblGender.backgroundColor = UIColor.clear
        lblGender.text = "Female"
        lblGender.textColor = ColorPink
        lblGender.textAlignment = .left
        lblGender.clipsToBounds = true
        lblGender.font = UIFont.init(name: FONT.Kurale.rawValue, size: 20)
        viewWhiteBG.addSubview(lblGender)
        
        let btnEditeGender:UIButton = UIButton()
        btnEditeGender.frame = CGRect(x: screenWidth-55, y: yRef+15, width: 45, height: 25)
        btnEditeGender.backgroundColor = UIColor.clear
        btnEditeGender.setTitle("Edit", for: .normal)
        btnEditeGender.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        btnEditeGender.setTitleColor(LightGrayEdit, for: .normal)
        btnEditeGender.clipsToBounds = true
        btnEditeGender.addTarget(self, action: #selector(self.btnGenderClicked(_:)), for: .touchUpInside)
        viewWhiteBG.addSubview(btnEditeGender)

        yRef = yRef+imgGender.frame.size.height + 25

        let lblWeight:UILabel = UILabel()
        lblWeight.frame = CGRect(x: 20, y: yRef, width: 120, height: 30)
        lblWeight.backgroundColor = UIColor.clear
        lblWeight.text = "Weight"
        lblWeight.textColor = ColorGrayText
        lblWeight.textAlignment = .left
        lblWeight.clipsToBounds = true
        lblWeight.font = UIFont.init(name: FONT.Kurale.rawValue, size: 20)
        viewWhiteBG.addSubview(lblWeight)

        yRef = yRef+imgGender.frame.size.height + 10

        lblWightSize = UILabel()
        lblWightSize.frame = CGRect(x: (screenWidth-120)/2, y: yRef, width: 120, height: 35)
        lblWightSize.backgroundColor = UIColor.clear
        lblWightSize.text = "60"
        lblWightSize.textColor = ColorPink
        lblWightSize.textAlignment = .center
        lblWightSize.clipsToBounds = true
        lblWightSize.font = UIFont.init(name: FONT.Kurale.rawValue, size: 27)
        viewWhiteBG.addSubview(lblWightSize)
        
        yRef = yRef+lblWightSize.frame.size.height + 10

        WeightPicker = TYHeightPicker()
        WeightPicker.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 130)
        WeightPicker.delegate = self
        WeightPicker.clipsToBounds = true
        WeightPicker.setDefaultHeight(77, unit: .CM)
        viewWhiteBG.addSubview(WeightPicker)

        WeightPicker.collectionView.isUserInteractionEnabled = false
        WeightPicker.cmBtn.isHidden = true
        WeightPicker.feetInchBtn.isHidden = true
        WeightPicker.indicatorView.isHidden = true
        WeightPicker.resultLabel.isHidden = true

        yRef = yRef+WeightPicker.frame.size.height + 2

        let btnWeightEdit:UIButton = UIButton()
        btnWeightEdit.frame = CGRect(x: screenWidth-55, y: yRef, width: 45, height: 25)
        btnWeightEdit.backgroundColor = UIColor.clear
        btnWeightEdit.setTitle("Edit", for: .normal)
        btnWeightEdit.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        btnWeightEdit.setTitleColor(LightGrayEdit, for: .normal)
        btnWeightEdit.clipsToBounds = true
        btnWeightEdit.addTarget(self, action: #selector(self.btnWeightClicked(_:)), for: .touchUpInside)
        viewWhiteBG.addSubview(btnWeightEdit)

        yRef = yRef+btnWeightEdit.frame.size.height + 10

        let lblHeight:UILabel = UILabel()
        lblHeight.frame = CGRect(x: 20, y: yRef, width: 120, height: 30)
        lblHeight.backgroundColor = UIColor.clear
        lblHeight.text = "Height"
        lblHeight.textColor = ColorGrayText
        lblHeight.textAlignment = .left
        lblHeight.clipsToBounds = true
        lblHeight.font = UIFont.init(name: FONT.Kurale.rawValue, size: 20)
        viewWhiteBG.addSubview(lblHeight)

        yRef = yRef+lblHeight.frame.size.height + 10

        lblHeightSize = UILabel()
        lblHeightSize.frame = CGRect(x: (screenWidth-120)/2, y: yRef, width: 120, height: 35)
        lblHeightSize.backgroundColor = UIColor.clear
        lblHeightSize.text = "5ft 5in"
        lblHeightSize.textColor = ColorPink
        lblHeightSize.textAlignment = .center
        lblHeightSize.clipsToBounds = true
        lblHeightSize.font = UIFont.init(name: FONT.Kurale.rawValue, size: 27)
        viewWhiteBG.addSubview(lblHeightSize)

        yRef = yRef+lblHeightSize.frame.size.height + 10

        heighPicker = TYHeightPicker()
        heighPicker.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 130)
        heighPicker.delegate = self
        heighPicker.clipsToBounds = true
        heighPicker.setDefaultHeight(82, unit: .Inch)
        viewWhiteBG.addSubview(heighPicker)

        heighPicker.collectionView.isUserInteractionEnabled = false
        heighPicker.cmBtn.isHidden = true
        heighPicker.feetInchBtn.isHidden = true
        heighPicker.indicatorView.isHidden = true
        heighPicker.resultLabel.isHidden = true

        yRef = yRef+heighPicker.frame.size.height + 2

        let btnHeightEdit:UIButton = UIButton()
        btnHeightEdit.frame = CGRect(x: screenWidth-55, y: yRef, width: 45, height: 25)
        btnHeightEdit.backgroundColor = UIColor.clear
        btnHeightEdit.setTitle("Edit", for: .normal)
        btnHeightEdit.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        btnHeightEdit.setTitleColor(LightGrayEdit, for: .normal)
        btnHeightEdit.clipsToBounds = true
        btnHeightEdit.addTarget(self, action: #selector(self.btnHeightClicked(_:)), for: .touchUpInside)
        viewWhiteBG.addSubview(btnHeightEdit)

        yRef = yRef+btnHeightEdit.frame.size.height + 10

        let lblLAstPreiodDate:UILabel = UILabel()
        lblLAstPreiodDate.frame = CGRect(x: 20, y: yRef, width: 200, height: 30)
        lblLAstPreiodDate.backgroundColor = UIColor.clear
        lblLAstPreiodDate.text = "Last period date"
        lblLAstPreiodDate.textColor = ColorGrayText
        lblLAstPreiodDate.textAlignment = .left
        lblLAstPreiodDate.clipsToBounds = true
        lblLAstPreiodDate.font = UIFont.init(name: FONT.Kurale.rawValue, size: 20)
        viewWhiteBG.addSubview(lblLAstPreiodDate)

        yRef = yRef+lblLAstPreiodDate.frame.size.height + 12

        txtPeriodD1 = UITextField()
        txtPeriodD1.frame = CGRect(x: 20, y: yRef, width: 30, height: 30)
        txtPeriodD1.backgroundColor = UIColor.clear
        txtPeriodD1.textAlignment = .center
        txtPeriodD1.placeholder = "D"
        txtPeriodD1.layer.borderWidth = 1
        txtPeriodD1.textColor = ColorPink
        txtPeriodD1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtPeriodD1.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtPeriodD1.layer.cornerRadius = 5
        txtPeriodD1.isUserInteractionEnabled = false
        txtPeriodD1.clipsToBounds = true
        viewWhiteBG.addSubview(txtPeriodD1)

        txtPeriodD2 = UITextField()
        txtPeriodD2.frame = CGRect(x: 55, y: yRef, width: 30, height: 30)
        txtPeriodD2.backgroundColor = UIColor.clear
        txtPeriodD2.placeholder = "D"
        txtPeriodD2.textAlignment = .center
        txtPeriodD2.layer.borderWidth = 1
        txtPeriodD2.textColor = ColorPink
        txtPeriodD2.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtPeriodD2.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtPeriodD2.layer.cornerRadius = 5
        txtPeriodD2.isUserInteractionEnabled = false
        txtPeriodD2.clipsToBounds = true
        viewWhiteBG.addSubview(txtPeriodD2)

        txtPeriodM1 = UITextField()
        txtPeriodM1.frame = CGRect(x: 100, y: yRef, width: 30, height: 30)
        txtPeriodM1.backgroundColor = UIColor.clear
        txtPeriodM1.placeholder = "M"
        txtPeriodM1.textAlignment = .center
        txtPeriodM1.layer.borderWidth = 1
        txtPeriodM1.textColor = ColorPink
        txtPeriodM1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtPeriodM1.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtPeriodM1.layer.cornerRadius = 5
        txtPeriodM1.isUserInteractionEnabled = false
        txtPeriodM1.clipsToBounds = true
        viewWhiteBG.addSubview(txtPeriodM1)

        txtPeriodM2 = UITextField()
        txtPeriodM2.frame = CGRect(x: 135, y: yRef, width: 30, height: 30)
        txtPeriodM2.backgroundColor = UIColor.clear
        txtPeriodM2.layer.borderWidth = 1
        txtPeriodM2.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtPeriodM2.placeholder = "M"
        txtPeriodM2.textAlignment = .center
        txtPeriodM2.textColor = ColorPink
        txtPeriodM2.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtPeriodM2.layer.cornerRadius = 5
        txtPeriodM2.isUserInteractionEnabled = false
        txtPeriodM2.clipsToBounds = true
        viewWhiteBG.addSubview(txtPeriodM2)

        txtPeriodY1 = UITextField()
        txtPeriodY1.frame = CGRect(x: 180, y: yRef, width: 30, height: 30)
        txtPeriodY1.backgroundColor = UIColor.clear
        txtPeriodY1.placeholder = "Y"
        txtPeriodY1.textAlignment = .center
        txtPeriodY1.layer.borderWidth = 1
        txtPeriodY1.textColor = ColorPink
        txtPeriodY1.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtPeriodY1.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtPeriodY1.layer.cornerRadius = 5
        txtPeriodY1.isUserInteractionEnabled = false
        txtPeriodY1.clipsToBounds = true
        viewWhiteBG.addSubview(txtPeriodY1)
        
        txtPeriodY2 = UITextField()
        txtPeriodY2.frame = CGRect(x: 215, y: yRef, width: 30, height: 30)
        txtPeriodY2.backgroundColor = UIColor.clear
        txtPeriodY2.placeholder = "Y"
        txtPeriodY2.textAlignment = .center
        txtPeriodY2.layer.borderWidth = 1
        txtPeriodY2.textColor = ColorPink
        txtPeriodY2.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        txtPeriodY2.font =  UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        txtPeriodY2.layer.cornerRadius = 5
        txtPeriodY2.isUserInteractionEnabled = false
        txtPeriodY2.clipsToBounds = true
        viewWhiteBG.addSubview(txtPeriodY2)

        let btnPeriodCalander:UIButton = UIButton()
        btnPeriodCalander.frame = CGRect(x: 260, y: yRef, width: 30, height: 30)
        btnPeriodCalander.backgroundColor = UIColor.clear
        btnPeriodCalander.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        btnPeriodCalander.setImage(UIImage.init(named: "Icon-1"), for: .normal)
        btnPeriodCalander.layer.cornerRadius = 5
        btnPeriodCalander.clipsToBounds = true
        viewWhiteBG.addSubview(btnPeriodCalander)

        let btnEditePeriod:UIButton = UIButton()
        btnEditePeriod.frame = CGRect(x: screenWidth-55, y: yRef+15, width: 45, height: 25)
        btnEditePeriod.backgroundColor = UIColor.clear
        btnEditePeriod.setTitle("Edit", for: .normal)
        btnEditePeriod.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        btnEditePeriod.setTitleColor(LightGrayEdit, for: .normal)
        btnEditePeriod.clipsToBounds = true
        btnEditePeriod.addTarget(self, action: #selector(self.btnLastPeriodDateClicked(_:)), for: .touchUpInside)
        viewWhiteBG.addSubview(btnEditePeriod)

        yRef = yRef+btnPeriodCalander.frame.size.height + 15
        
        let lblBleedingDuration:UILabel = UILabel()
        lblBleedingDuration.frame = CGRect(x: 20, y: yRef, width: 200, height: 30)
        lblBleedingDuration.backgroundColor = UIColor.clear
        lblBleedingDuration.text = "Bleeding duration"
        lblBleedingDuration.textColor = ColorGrayText
        lblBleedingDuration.textAlignment = .left
        lblBleedingDuration.clipsToBounds = true
        lblBleedingDuration.font = UIFont.init(name: FONT.Kurale.rawValue, size: 20)
        viewWhiteBG.addSubview(lblBleedingDuration)

        yRef = yRef+lblBleedingDuration.frame.size.height + 10

        lblBleedingDays = UILabel()
        lblBleedingDays.frame = CGRect(x: (screenWidth-120)/2, y: yRef, width: 120, height: 35)
        lblBleedingDays.backgroundColor = UIColor.clear
        lblBleedingDays.text = "4 days"
        lblBleedingDays.textColor = ColorPink
        lblBleedingDays.textAlignment = .center
        lblBleedingDays.clipsToBounds = true
        lblBleedingDays.font = UIFont.init(name: FONT.Kurale.rawValue, size: 27)
        viewWhiteBG.addSubview(lblBleedingDays)

        let btnEditeBleedingDuration:UIButton = UIButton()
        btnEditeBleedingDuration.frame = CGRect(x: screenWidth-55, y: yRef+15, width: 45, height: 25)
        btnEditeBleedingDuration.backgroundColor = UIColor.clear
        btnEditeBleedingDuration.setTitle("Edit", for: .normal)
        btnEditeBleedingDuration.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        btnEditeBleedingDuration.setTitleColor(LightGrayEdit, for: .normal)
        btnEditeBleedingDuration.clipsToBounds = true
        viewWhiteBG.addSubview(btnEditeBleedingDuration)

        yRef = yRef+lblBleedingDays.frame.size.height + 15
        
        let lblBleedingLength:UILabel = UILabel()
        lblBleedingLength.frame = CGRect(x: 20, y: yRef, width: 200, height: 30)
        lblBleedingLength.backgroundColor = UIColor.clear
        lblBleedingLength.text = "Period length"
        lblBleedingLength.textColor = ColorGrayText
        lblBleedingLength.textAlignment = .left
        lblBleedingLength.clipsToBounds = true
        lblBleedingLength.font = UIFont.init(name: FONT.Kurale.rawValue, size: 20)
        viewWhiteBG.addSubview(lblBleedingLength)

        yRef = yRef+lblBleedingLength.frame.size.height + 10

        lblLengthDays = UILabel()
        lblLengthDays.frame = CGRect(x: (screenWidth-120)/2, y: yRef, width: 120, height: 35)
        lblLengthDays.backgroundColor = UIColor.clear
        lblLengthDays.text = "28 days"
        lblLengthDays.textColor = ColorPink
        lblLengthDays.textAlignment = .center
        lblLengthDays.clipsToBounds = true
        lblLengthDays.font = UIFont.init(name: FONT.Kurale.rawValue, size: 27)
        viewWhiteBG.addSubview(lblLengthDays)

        let btnEditePeriodLenght:UIButton = UIButton()
        btnEditePeriodLenght.frame = CGRect(x: screenWidth-55, y: yRef+15, width: 45, height: 25)
        btnEditePeriodLenght.backgroundColor = UIColor.clear
        btnEditePeriodLenght.setTitle("Edit", for: .normal)
        btnEditePeriodLenght.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        btnEditePeriodLenght.setTitleColor(LightGrayEdit, for: .normal)
        btnEditePeriodLenght.clipsToBounds = true
        viewWhiteBG.addSubview(btnEditePeriodLenght)

        yRef = yRef+lblLengthDays.frame.size.height + 15

        viewScroll.contentSize = CGSize(width: screenWidth, height: yRef+10)

    }
    func setupTYHeightPicker() {
        heighPicker = TYHeightPicker()
        heighPicker.translatesAutoresizingMaskIntoConstraints = false
        heighPicker.delegate = self
        viewWhiteBG.addSubview(heighPicker)
        
        heighPicker.cmBtn.isHidden = true
        heighPicker.feetInchBtn.isHidden = true
        heighPicker.indicatorView.isHidden = true
        heighPicker.resultLabel.isHidden = true
        
        heighPicker.leftAnchor.constraint(equalTo: viewWhiteBG.leftAnchor, constant: 20).isActive = true
        heighPicker.rightAnchor.constraint(equalTo: viewWhiteBG.rightAnchor, constant: 100).isActive = true
        heighPicker.topAnchor.constraint(equalTo: viewWhiteBG.topAnchor, constant: 348).isActive = true
        heighPicker.heightAnchor.constraint(equalToConstant: 90).isActive = true
        heighPicker.clipsToBounds = true
        heighPicker.setDefaultHeight(60, unit: .CM)
        
    }

    //MARK: Action
    @objc func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnNickNameClicked(_ sender: UIButton) {
        let vc:AboutMeViewController = AboutMeViewController()
        vc.checkEdite = true
        vc.strNickName = strName
        vc.delegate = self
        vc.selectedDate = self.stringtodate(dateTxt!)
        vc.strDateOfBirth = self.dateTxt!
        self.present(vc, animated: true, completion: nil)
    }
    @objc func btnDOBClicked(_ sender: UIButton) {
        let vc:AboutMeViewController = AboutMeViewController()
        vc.checkEdite = true
        vc.strNickName = strName
        vc.delegate = self
        vc.selectedDate = self.stringtodate(dateTxt!)
        vc.strDateOfBirth = self.dateTxt!
        self.present(vc, animated: true, completion: nil)
    }
    @objc func btnGenderClicked(_ sender: UIButton) {
        let vc:GenderVC = GenderVC()
        vc.strSelectedGender = GenderString
        vc.checkEdite = true
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @objc func btnWeightClicked(_ sender: UIButton) {
        let vc:WeightVC = WeightVC()
        vc.strWeight = strWeight
        vc.checkEdite = true
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @objc func btnHeightClicked(_ sender: UIButton) {
        let vc:HeightVC = HeightVC()
        vc.checkEdite = true
        vc.strHeightUnit = strHeightUnit
        vc.strHeight = strHeight
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @objc func btnLastPeriodDateClicked(_ sender: UIButton) {
        
    }
    @objc func btnBleedingDurationClicked(_ sender: UIButton) {
        
    }
    @objc func btnPeriodLenghtClicked(_ sender: UIButton) {
        
    }

    func updateUI(){
        let objdata:GetUserInfoData = arrAllData.object(at: 0) as! GetUserInfoData
        
        txtNickName.text = String(describing: objdata.username!)
        let strDate:String = String(describing: objdata.dob!)
        txtD1.text = getRangeString(0, lenth: 1, strDate: strDate)
        txtD2.text = getRangeString(1, lenth: 1, strDate: strDate)
        txtM1.text = getRangeString(3, lenth: 1, strDate: strDate)
        txtM2.text = getRangeString(4, lenth: 1, strDate: strDate)
        txtY1.text = getRangeString(8, lenth: 1, strDate: strDate)
        txtY2.text = getRangeString(9, lenth: 1, strDate: strDate)
        let strGender: String = String(describing: objdata.gender!)
        if strGender == "FEMALE" {
            imgGender.image = UIImage.init(named: "FemaleIcon")
        }else{
            imgGender.image = UIImage.init(named: "mailIcon")
        }
        lblGender.text = String(describing: objdata.gender!)
        let wtrWight: [String : Any] = objdata.weight
        lblWightSize.text = String(describing: wtrWight["measure"]!) + String(describing: wtrWight["unit"]!)
        let measurWeight = String(describing: wtrWight["measure"]!)
        let intWeight: Int = Int(measurWeight)! + 17
        WeightPicker.setDefaultHeight(CGFloat(intWeight), unit: .CM)

        let height: [String : Any] = objdata.height
        lblHeightSize.text = String(describing: height["measure"]!) + String(describing: height["unit"]!)
        strHeightUnit = String(describing: height["unit"]!)
        let measurHeight = String(describing: wtrWight["measure"]!)
        let intHeight: Int = Int(measurHeight)! + 10
        heighPicker.setDefaultHeight(CGFloat(intHeight), unit: .Inch)

        let strLastDate:String = String(describing: objdata.lastPeriodDate!)
        txtPeriodD1.text = getRangeString(8, lenth: 1, strDate: strLastDate)
        txtPeriodD2.text = getRangeString(9, lenth: 1, strDate: strLastDate)
        txtPeriodM1.text = getRangeString(5, lenth: 1, strDate: strLastDate)
        txtPeriodM2.text = getRangeString(6, lenth: 1, strDate: strLastDate)
        txtPeriodY1.text = getRangeString(3, lenth: 1, strDate: strLastDate)
        txtPeriodY2.text = getRangeString(2, lenth: 1, strDate: strLastDate)
        lblBleedingDays.text = String(describing: objdata.avgBleedingDuration!) + " Days"
        lblLengthDays.text = String(describing: objdata.avgMenstrualCycle!) + " Days"
        
        dateTxt = String(describing: objdata.dob!)
        strName = String(describing: objdata.username!)
        
        strWeight = String(describing: wtrWight["measure"]!)
        strHeight = String(describing: height["measure"]!)
        strPeriodDate = String(describing: objdata.lastPeriodDate!)
        strPeriodDuration = String(describing: objdata.avgBleedingDuration!)
        strPeriodCircle = String(describing: objdata.avgMenstrualCycle!)
        GenderString = String(describing: objdata.gender!)

        self.dateFormate()

    }
    func getRangeString(_ location: Int, lenth: Int, strDate: String) -> String{
        let nsrange = NSRange(location: location, length: lenth)
        var strRange: String = ""
        if let range = Range(nsrange, in: strDate) {
            print(strDate[range])
            strRange = String(strDate[range])
        }
        return strRange
    }

    //MARK: Apis
    
    func getUserInfoAPI(){
        let url = URL(string: API.PERIODBASE.GetUserInfo)!
        print(url)
        showLoader()
        let param = ["userid" : AppModel.shared.currentUser.userdata!.id]
        self.getUserInfoDataAPI(url, param: param)
    }
    
    func getUserInfoDataAPI(_ url:URL, param: Parameters){
        
        AllApis.getUserInfoAPI(vc: self, url: url, parameters: param) { result, error in
            DispatchQueue.main.async {
                removeLoader()
                if error == nil{
                    if result != nil{
                        print(result!)
                        let status:String = result!["msg"] as! String
                        if status == "success"{
                            let data: [String : Any] = result!["data"] as! [String : Any]
                            let objdata: GetUserInfoData = GetUserInfoData.init(profileInfo: data)!
                            self.arrAllData.add(objdata)
                            self.updateUI()
                        }else{
                            let message:String = result!["msg"] as! String
                            displayToast(message)
                        }
                    }
                } else {
                    displayToast("Server_error")
                }
            }
        }
    }
    func dateFormate() {
    //case DATE8 = "dd/MM/yyyy"
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "dd/MM/yyyy"
        let strPeriodDate = dateFormatter1.date(from: dateTxt!)
        dateTxt = dateFormatter1.string(from: strPeriodDate!)
        print(dateTxt!)
    }
    func stringtodate(_ strDate: String) -> Date {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "dd/MM/yyyy"
        let DobdDate = dateFormatter1.date(from: strDate)!
        
        return DobdDate
    }
    func stringtodate(_ dobDate: Date) -> String {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "dd/MM/yyyy"
        let strdob = dateFormatter1.string(from: dobDate)
        
        return strdob
    }

    func apiCall(){
        
        self.view.endEditing(true)
        var request = CreateAccountRequest(username: strName, gender: GenderString, healthissue: [], dob: dateTxt, height: WeightRequest(measure: Int(strHeight)!, unit: "In"), weight: WeightRequest(measure: Int(strWeight)!, unit: "Kg"), avgBleedingDuration: strPeriodDuration, avgMenstrualCycle: strPeriodCircle, lastPeriodsDate: strPeriodDate)
        print(request)
//        request.dob = self.selectedDate != nil ? getDateStringFromDate(date: self.selectedDate, format: DATE_FORMMATE.DATE8.getValue()) : AppModel.shared.currentUser.userdata?.dob
        
        CreateAccountVM.createAccount(request: request) { (response) in
            var data1 : UserDataModel = UserDataModel()
            data1.userdata = response.data
            
            if data1.userdata != nil {
                if data1.userdata?.rewardFlag == 1 {
                    showBadgesPopup(badgeImg: "reward1", title: "Yay!\nYou just won \(data1.userdata!.CoinsEarned) coins!", bottomDesc: "Return to our app every 24 hours to keep winning", isCoin: true) {
                        
                    }
                }
            }
            
            self.CreateAccountVM.getUserDetail(request: UserDetailRequest(userid:AppModel.shared.currentUser.userdata?.id ?? "")) { (responseUserData) in
                var data : UserDataModel = UserDataModel()
                data.accesstoken = AppModel.shared.currentUser.accesstoken
                data.userdata = responseUserData.data
                setLoginUserData(data)
                AppModel.shared.currentUser = data
                AppModel.shared.token = data.accesstoken
                
                self.GetListChatRoomVM.getChatRoomList { (chatListResponse) in
                        if chatListResponse.chatRooms.count != 0 {
                            var chatDataArr: [UserChatRoomRequest] = [UserChatRoomRequest]()
                            for item in chatListResponse.chatRooms {
                                var dict: UserChatRoomRequest = UserChatRoomRequest()
                                dict.active = true
                                dict.priority = 1
                                dict.infoID = item.id
                                dict.chatRoomID = item.chatRoomID
                                dict.chatRoomName = item.name
                                dict.latSeenMessageID = 0
                                chatDataArr.append(dict)
                            }
                            
                            let requestData = UpdateUserChatRoomRequest(userID: AppModel.shared.currentUser.userdata!.id, data: chatDataArr)
                            self.GetListChatRoomVM.getUpdateUserRoom(request: requestData) { (response) in
                                //AppDelegate().sharedDelegate().navigateToDashBoard()
                            }
                        }
                    }
            }
        }
    }
}

extension ProfilePageVC: TYHeightPickerDelegate, Nickname, GenderProtocol , WeightProtocol, HeightProtocol{
        
    func gender(_ strGender: String) {
        print(strGender)
    }
    
    func strNickName(_ strNickName: String, selectDate: Date) {
        print(strNickName, selectDate)
    }
    func wieght(_ strWieght: String) {
        print(strWieght)
    }
    
    func height(_ strHeight: String, strUnit: String) {
        print(strHeight, strUnit)
    }

    func selectedHeight(height: CGFloat, unit: HeightUnit) {
        if unit == .CM {
            let _: Int = Int(height)
        }
        
        if unit == .Inch {
            _ = Int(height / 12)
            let inch = Int(height) % 12
            if inch != 0 {
            } else  {
            }
        }
    }
}
