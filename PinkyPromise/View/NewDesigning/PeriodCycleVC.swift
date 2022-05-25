//
//  PeriodCycleVC.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 16/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

class PeriodCycleVC: UIViewController {

    var yRef:CGFloat = 44
    var lblDuration:UILabel = UILabel()
    var intDuration: Int = 28

    private var CreateAccountVM: CreateAccountViewModel = CreateAccountViewModel()
    private var GetListChatRoomVM: GetListChatRoomViewModel = GetListChatRoomViewModel()
    var selectedDate : Date!
    var HeightPickerArr : [Int] = [Int]()
    var HeightInchPickerArr : [Int] = [Int]()
    var selectedGender: String = String()
    
    var WeightPickerArr : [Int] = [Int]()
    var WeightPoundPickerArr : [Int] = [Int]()
    
    var selectedWeightType: String = ""
    var selectedHeightType: String = ""
    var totalInchHeight: Int = 0
    var totalWeight: Int = 0
    
    var isFromProfile: Bool = false
    
    var heightLbl:String = ""
    var weightLbl:String = ""
    var nickNameTxt: String?
    var dateTxt: String?
    
    var strWeight: String = ""
    var strHeight: String = ""
    var strPeriodDate: String = ""
    var strPeriodDuration: String = ""
    var strPeriodCircle: String = ""
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
        barprogress.progress = 1
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
        lblLastPeriodText.text = "What is your average menstrual cycle length?"
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
        lblChooseDateText.text = "This is the total number of days from the first day of your previous periods, to the first day of your next periods"
        lblChooseDateText.textAlignment = .left
        lblChooseDateText.textColor = ColorRed
        lblChooseDateText.clipsToBounds = true
        lblChooseDateText.numberOfLines = 0
        lblChooseDateText.lineBreakMode = .byWordWrapping
        lblChooseDateText.sizeToFit()
        self.view.addSubview(lblChooseDateText)

        yRef = yRef+lblChooseDateText.frame.size.height + 45

        let lblAverageCycle:UILabel = UILabel()
        lblAverageCycle.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 40)
        lblAverageCycle.backgroundColor = UIColor.clear
        lblAverageCycle.font = UIFont.init(name: FONT.Playfair.rawValue, size: 24.0)
        lblAverageCycle.text = "Average Menstrual Cycle?"
        lblAverageCycle.textAlignment = .center
        lblAverageCycle.textColor = UIColor.black
        lblAverageCycle.clipsToBounds = true
        self.view.addSubview(lblAverageCycle)

        yRef = yRef+lblAverageCycle.frame.size.height + 15

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
        btnConfirm.setTitle("Finish", for: .normal)
        btnConfirm.setTitleColor(UIColor.white, for: .normal)
        btnConfirm.layer.cornerRadius = 20
        btnConfirm.clipsToBounds = true
        btnConfirm.addTarget(self, action: #selector(self.btnConfirmClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnConfirm)
        
        strPeriodCircle = String(intDuration)
     }

    @objc func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btnLeftClicked(_ sender: UIButton) {
        if intDuration <= 10 {
            
        }else{
            intDuration = intDuration-1
            lblDuration.text = String(intDuration)
            strPeriodCircle = String(intDuration)
        }

    }
    @objc func btnRightClicked(_ sender: UIButton) {
        if intDuration > 59{
            
        }else {
            intDuration = intDuration+1
            lblDuration.text = String(intDuration)
            strPeriodCircle = String(intDuration)
        }
    }
    @objc func btnConfirmClicked(_ sender: UIButton) {
//        let vc: CustomTabBarController = CustomTabBarController()
//        self.navigationController?.pushViewController(vc, animated: true)
        
        self.apiCall()
    }
    
    func apiCall(){
        self.view.endEditing(true)
        guard let name = nickNameTxt else { return }
        guard let date = dateTxt else { return }
        let minDate : Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        
        if name == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_nickname"))
        }
        else if date == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("select_dob"))
        }
        else if selectedGender == "" {
            displayToast(getTranslate("select_gender"))
        }
        else if heightLbl.trimmed == "Ft" {
            displayToast(getTranslate("select_height"))
        }
        else if weightLbl.trimmed == "Kg" {
            displayToast(getTranslate("select_weight"))
        }
        else if selectedDate != nil && selectedDate > minDate {
            displayToast(getTranslate("must_above_18_year"))
        }
        else {
//            var request = CreateAccountRequest(username: name, gender: selectedGender, healthissue: [], height: WeightRequest(measure: totalInchHeight, unit: "in"), weight: WeightRequest(measure: totalWeight, unit: selectedWeightType))
            print(dateTxt!)
            var request = CreateAccountRequest(username: name, gender: selectedGender, healthissue: [], dob: dateTxt, height: WeightRequest(measure: Int(strHeight)!, unit: strHeightUnit), weight: WeightRequest(measure: Int(strWeight)!, unit: "Kg"), avgBleedingDuration: strPeriodDuration, avgMenstrualCycle: strPeriodCircle, lastPeriodsDate: strPeriodDate)
            print(request)
            request.dob = self.selectedDate != nil ? getDateStringFromDate(date: self.selectedDate, format: DATE_FORMMATE.DATE8.getValue()) : AppModel.shared.currentUser.userdata?.dob
            
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
                    
                    if self.isFromProfile {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    else{
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
                                    AppDelegate().sharedDelegate().navigateToDashBoard()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

