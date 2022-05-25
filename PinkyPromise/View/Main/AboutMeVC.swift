//
//  AboutMeVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 01/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class AboutMeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var nickNameLbl: UILabel!
    
    @IBOutlet weak var nickNameTxt: UITextField!
    @IBOutlet weak var dateTxt: UITextField!
    
    @IBOutlet weak var maleBackView: View!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBackView: View!
    @IBOutlet weak var femaleBtn: UIButton!
    
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var confirmBtn: Button!
    
    @IBOutlet var heightBackView: UIView!
    @IBOutlet weak var heightPickerView: UIPickerView!
    @IBOutlet weak var heightConfirmBtn: Button!
    @IBOutlet weak var inchBtn: Button!
    
    @IBOutlet var weightBackView: UIView!
    @IBOutlet weak var weightPickerView: UIPickerView!
    @IBOutlet weak var weightConfirmBtn: Button!
    @IBOutlet weak var kgBtn: Button!
    @IBOutlet weak var poundBtn: Button!
    
    @IBOutlet weak var selectHeightBackView: View!
    @IBOutlet weak var selectWeightBackView: View!
    
    @IBOutlet var reproductiveBackView: UIView!
    @IBOutlet weak var reproductiveLbl: UILabel!
    @IBOutlet var maleAnatomyBackView: UIView!
    @IBOutlet weak var maleAnatomyLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    private var CreateAccountVM: CreateAccountViewModel = CreateAccountViewModel()
    private var GetListChatRoomVM: GetListChatRoomViewModel = GetListChatRoomViewModel()
    private var selectedDate : Date!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillLayoutSubviews() {
        confirmBtn.borderColorTypeAdapter = 6
        confirmBtn.borderWidth = 2
        
        heightConfirmBtn.borderColorTypeAdapter = 6
        heightConfirmBtn.borderWidth = 2
        weightConfirmBtn.borderColorTypeAdapter = 6
        weightConfirmBtn.borderWidth = 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
        
        HeightPickerArr = Array(1...12)
        HeightInchPickerArr = Array(0...11)
        WeightPickerArr = Array(20...200)
        WeightPoundPickerArr = Array(90...400)
    }
    
    func configUI() {
        headerLbl.text = getTranslate("profile_activity_heading")
        nickNameLbl.text = getTranslate("hint_profile_name")
        reproductiveLbl.text = getTranslate("female_anatomy_text")
        maleAnatomyLbl.text = getTranslate("male_anatomy_text")
        
        heightBackView.isHidden = true
        weightBackView.isHidden = true
        
        dateTxt.delegate = self
        dateTxt.isUserInteractionEnabled = false
        
        reproductiveBackView.isHidden = true
        maleAnatomyBackView.isHidden = true
        
        maleBackView.cornerRadius = 5
        maleBackView.borderWidth  = 1
        maleBackView.borderColorTypeAdapter = 9
        
        femaleBackView.cornerRadius = 5
        femaleBackView.borderWidth  = 1
        femaleBackView.borderColorTypeAdapter = 9
        
        selectHeightBackView.cornerRadius = 5
        selectHeightBackView.borderWidth  = 1
        selectHeightBackView.borderColorTypeAdapter = 9
        
        selectWeightBackView.cornerRadius = 5
        selectWeightBackView.borderWidth  = 1
        selectWeightBackView.borderColorTypeAdapter = 9
        
        inchBtn.borderWidth  = 1
        inchBtn.borderColorTypeAdapter = 9
        
        self.heightPickerView.delegate = self
        self.heightPickerView.dataSource = self
        
        self.weightPickerView.delegate = self
        self.weightPickerView.dataSource = self
        
        heightPickerView.setValue(AppColor, forKey: "textColor")
        weightPickerView.setValue(AppColor, forKey: "textColor")
                
        heightPickerView.reloadAllComponents()
        weightPickerView.reloadAllComponents()
        
        selectedGender = "FEMALE"
        clickToGender(femaleBtn)
        backBtn.isHidden = true
        dataRender()
        clickToSelectWeightPicker(kgBtn)
    }
    
    func dataRender()  {
        if isFromProfile {
            backBtn.isHidden = false
            if AppModel.shared.currentUser != nil {
                if let userData = AppModel.shared.currentUser.userdata {
                    nickNameTxt.text = userData.username
                    
                    if let dob = getDateFromDateString(strDate : userData.dob, format : DATE_FORMMATE.DATE2.rawValue) {
                        dateTxt.text = getDateStringFromDate(date : dob, format : DATE_FORMMATE.DATE2.rawValue) //userData.dob
                    }
                    
                    let data1 = userData.dob.components(separatedBy: "/")
                    if data1.count == 3 {
                        if data1[2].count == 4 {
                            let last2Digit = userData.dob.suffix(2)
                            dateTxt.text = String(userData.dob.dropLast(4) + last2Digit)
                        }
                    }
                    else{
                        dateTxt.text = userData.dob
                    }
                    
//                    var last2Digit = userData.dob.suffix(2)
//                    dateTxt.text = String(userData.dob.dropLast(4) + last2Digit)
                    
                    if userData.gender == "MALE" {
                        clickToGender(maleBtn)
                        maleAnatomyBackView.isHidden = true
                    }
                    else if userData.gender == "FEMALE" {
                        clickToGender(femaleBtn)
                    }
                    
                    if let heightData = userData.height {
                        heightLbl.text = getHeightFromFeetAndInch(heightData.measure)
                        totalInchHeight = heightData.measure
                    }
                    
                    if let weightData = userData.weight {
                        weightLbl.text = "\(weightData.measure)" + " \(weightData.unit)"
                        totalWeight = weightData.measure
                        selectedWeightType = weightData.unit
                    }
                }
            }
        }
    }
    
    func getHeightFromFeetAndInch(_ inch: Int) -> String {
        let feet = inch / 12;
        let leftover = inch % 12;
        return ("\(feet)" + " Ft " + "\(leftover)" + " In")
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToDate(_ sender: Any) {
        self.view.endEditing(true)
        showDatePicker(title: "Select Date", selected: selectedDate, minDate: nil, maxDate: nil) { (date) in
            self.selectedDate = date
            self.dateTxt.text = getDateStringFromDate(date: date, format: DATE_FORMMATE.DATE2.getValue())
        } completionClose: {
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTxt {
            if textField.text?.count == 1 {
                textField.placeholder = "dd/MM/YY"
            }
            if (textField.text?.count == 2) || (textField.text?.count == 5) {
                if textField.text?.count == 2 {
                    if Int(textField.text!.trimmed)! > 31 {
                        displayToast("Please enter valid date")
                        return false
                    }
                }
                else if textField.text?.count == 5 {
                    let month = textField.text!.trimmed.components(separatedBy: "/")
                    if month.count == 2, Int(month[1])! > 12  {
                        displayToast("Please enter valid month")
                        return false
                    }
                }
                if !(string == "") {
                    dateTxt.text = textField.text! + "/"
                    
                }
            }
            return !(textField.text!.count > 7 && (string.count) > range.length)
        }
        else {
            return true
        }
    }
    
    @IBAction func clickToGender(_ sender: UIButton) {
        self.view.endEditing(true)
        maleBackView.backgroundColor = WhiteColor
        femaleBackView.backgroundColor = WhiteColor
        
        if sender.tag == 1 {
            maleAnatomyBackView.isHidden = false
            displaySubViewtoParentView(self.view, subview: maleAnatomyBackView)
            maleBackView.backgroundColor = LightPinkColor
            selectedGender = "MALE"
        }
        else{
            femaleBackView.backgroundColor = LightPinkColor
            selectedGender = "FEMALE"
        }
    }
    
    @IBAction func clickToHeight(_ sender: Any) {
        self.view.endEditing(true)
        heightBackView.isHidden = false
        displaySubViewtoParentView(self.view, subview: heightBackView)
        self.heightPickerView.selectRow(4, inComponent: 0, animated: false)
        self.heightPickerView.selectRow(5, inComponent: 1, animated: false)
        heightPickerView.reloadAllComponents()
    }
    
    @IBAction func clickToWeight(_ sender: Any) {
        self.view.endEditing(true)
        weightBackView.isHidden = false
        displaySubViewtoParentView(self.view, subview: weightBackView)
        if selectedWeightType == "Kg" {
            self.weightPickerView.selectRow(30, inComponent: 0, animated: false)
            weightPickerView.reloadAllComponents()
        }
        else{
            self.weightPickerView.selectRow(10, inComponent: 0, animated: false)
            weightPickerView.reloadAllComponents()
        }
//        self.weightPickerView.selectRow(30, inComponent: 0, animated: false)
//        weightPickerView.reloadAllComponents()
    }
    
    @IBAction func clickToHeightConfirm(_ sender: Any) {
        heightBackView.isHidden = true
        heightLbl.text = "\(HeightPickerArr[heightPickerView.selectedRow(inComponent: 0)]) Ft \(HeightInchPickerArr[heightPickerView.selectedRow(inComponent: 1)]) In"
        
        totalInchHeight = Int(feetToInchesInt(feet: HeightPickerArr[heightPickerView.selectedRow(inComponent: 0)], inch: HeightInchPickerArr[heightPickerView.selectedRow(inComponent: 1)]))// + HeightInchPickerArr[heightPickerView.selectedRow(inComponent: 1)]
    }
    
    func feetToInchesInt(feet:Int, inch: Int = 0) -> Double
    {
        return Double(feet*12) + Double(inch)
    }
    
    @IBAction func clickToWhatKindReproductive(_ sender: Any) {
        self.view.endEditing(true)
        reproductiveBackView.isHidden = false
        displaySubViewtoParentView(self.view, subview: reproductiveBackView)
    }
    
    @IBAction func clickToReproductiveCancel(_ sender: Any) {
        reproductiveBackView.isHidden = true
    }
    
    @IBAction func clickToMaleAnatomy(_ sender: Any) {
        maleAnatomyBackView.isHidden = true
    }
    
    @IBAction func clickToWeightConfirm(_ sender: Any) {
        weightBackView.isHidden = true
        if selectedWeightType == "Kg" {
            weightLbl.text = "\(WeightPickerArr[weightPickerView.selectedRow(inComponent: 0)]) Kg"
            totalWeight = WeightPickerArr[weightPickerView.selectedRow(inComponent: 0)]
        }
        else{
            weightLbl.text = "\(WeightPoundPickerArr[weightPickerView.selectedRow(inComponent: 0)]) Lb"
            totalWeight = WeightPoundPickerArr[weightPickerView.selectedRow(inComponent: 0)]
        }
    }
    
    @IBAction func clickToSelectWeightPicker(_ sender: UIButton) {
        kgBtn.borderWidth  = 1
        kgBtn.borderColorTypeAdapter = 9
        kgBtn.setTitleColor(AppColor, for: .normal)
        kgBtn.backgroundColor = WhiteColor
        
        poundBtn.borderWidth  = 1
        poundBtn.borderColorTypeAdapter = 9
        poundBtn.setTitleColor(AppColor, for: .normal)
        poundBtn.backgroundColor = WhiteColor
        
        if sender.tag == 1 {
            kgBtn.backgroundColor = AppColor
            kgBtn.setTitleColor(WhiteColor, for: .normal)
            selectedWeightType = "Kg"
            self.weightPickerView.selectRow(30, inComponent: 0, animated: false)
            weightPickerView.reloadAllComponents()
        }
        else{
            poundBtn.backgroundColor = AppColor
            poundBtn.setTitleColor(WhiteColor, for: .normal)
            selectedWeightType = "Lb"
            
            let weight = WeightPickerArr[weightPickerView.selectedRow(inComponent: 0)]
            var pountWeight: Int = Int(Double(weight) * 2.20)
            let index = WeightPoundPickerArr.firstIndex { (data) -> Bool in
                data == pountWeight
            }
            if index != nil {
                self.weightPickerView.selectRow(index!, inComponent: 0, animated: false)
            }
            else{
                self.weightPickerView.selectRow(10, inComponent: 0, animated: false)
            }
            weightPickerView.reloadAllComponents()
        }
//        self.weightPickerView.selectRow(0, inComponent: 0, animated: false)
//        weightPickerView.reloadAllComponents()
    }
    
    @IBAction func clickToCancelWeight(_ sender: Any) {
        weightBackView.isHidden = true
    }
    
    @IBAction func clickToCancelHeight(_ sender: Any) {
        heightBackView.isHidden = true
    }
    
    @IBAction func clickToConfirm(_ sender: Any) {
        self.view.endEditing(true)
        guard let name = nickNameTxt.text else { return }
        guard let date = dateTxt.text else { return }
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
        else if heightLbl.text?.trimmed == "Ft" {
            displayToast(getTranslate("select_height"))
        }
        else if weightLbl.text?.trimmed == "Kg" {
            displayToast(getTranslate("select_weight"))
        }
        else if selectedDate != nil && selectedDate > minDate {
            displayToast(getTranslate("must_above_18_year"))
        }
        else {
            var request = CreateAccountRequest(username: name, gender: selectedGender, healthissue: [], height: WeightRequest(measure: totalInchHeight, unit: "in"), weight: WeightRequest(measure: totalWeight, unit: selectedWeightType))
            
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

extension AboutMeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == heightPickerView {
            return 2
        }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == heightPickerView {
            if component == 0 {
                return HeightPickerArr.count
            }
            else{
                return HeightInchPickerArr.count
            }
        }
        else {
            if selectedWeightType == "Kg" {
                return WeightPickerArr.count
            }
            else{
                return WeightPoundPickerArr.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == heightPickerView {
            if component == 0 {
                return String(HeightPickerArr[row])
            }
            else{
                return String(HeightInchPickerArr[row])
            }
        }
        else {
            if selectedWeightType == "Kg" {
                return String(WeightPickerArr[row])
            }
            else{
                return String(WeightPoundPickerArr[row])
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}
