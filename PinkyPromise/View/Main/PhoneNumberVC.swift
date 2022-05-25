//
//  PhoneNumberVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 01/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class PhoneNumberVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var flagImgView: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var phoneTxt: UITextField!
    
    @IBOutlet weak var confirmBtn: Button!
    
    @IBOutlet var countryCodeBackView: UIView!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var tblView: UITableView!
    
    private var AddDefaulLanguageVM: AddDefaulLanguageViewModel = AddDefaulLanguageViewModel()
    var isSearch: Bool = false
    var searchCountryCodes: [CountryCodeModel] = [CountryCodeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillLayoutSubviews() {
        confirmBtn.borderColorTypeAdapter = 6
        confirmBtn.borderWidth = 3
    }
    
    func configUI() {
        tableViewRegister()
        headerLbl.text = getTranslate("enter_contact")
    }
    
    //MARK: - Button Click
    @IBAction func clickToConfirm(_ sender: Any) {
        self.view.endEditing(true)
        guard let phoneCode = countryLbl.text?.trimmed else { return }
        guard let phone = phoneTxt.text?.trimmed else { return }
           
        if phoneCode == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_contact_code"))
        }
        if phone == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_contact"))
        }
        else {
            if let userData = AppModel.shared.currentUser.userdata {
                let request = VerifyPhoneNumberRequest(mobilenumber: phone, userid: userData.id)
                AddDefaulLanguageVM.verifyPhoneNumber(request: request) { (response) in
                    
//                    var data : UserDataModel = UserDataModel()
//                    data.accesstoken = AppModel.shared.currentUser.accesstoken
//                    data.userdata = response.data
//                    setLoginUserData(data)
//                    AppModel.shared.currentUser = data
//                    AppModel.shared.token = data.accesstoken
                    
                    let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @IBAction func clickToSelectPhoneCode(_ sender: Any) {
//        self.view.endEditing(true)
//        if AppModel.shared.countryCodes.count == 0 {
//            AppDelegate().sharedDelegate().loadCountryCodes()
//        }
//
//        countryCodeBackView.isHidden = false
//        tblView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
//        searchTxt.text = ""
//        isSearch = false
//        tblView.reloadData()
//        displaySubViewtoParentView(self.view, subview: countryCodeBackView)
    }
  
    @IBAction func clickToHideCountryCode(_ sender: Any) {
        countryCodeBackView.isHidden = true
    }
    
}

//MARK: - TableView DataSource and Delegate Methods
extension PhoneNumberVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableViewRegister() {
        tblView.register(UINib.init(nibName: "CountryCodeTVC", bundle: nil), forCellReuseIdentifier: "CountryCodeTVC")
        
        searchTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.trimmed != "" {
            searchCountryCodes = AppModel.shared.countryCodes.filter({ $0.name.localizedCaseInsensitiveContains(textField.text!.trimmed) })
            isSearch = true
            tblView.reloadData()
        }
        else{
            isSearch = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return searchCountryCodes.count
        }
        else{
            return AppModel.shared.countryCodes.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearch {
            let cell = tblView.dequeueReusableCell(withIdentifier: "CountryCodeTVC", for: indexPath) as! CountryCodeTVC
            
            cell.nameLbl.text = searchCountryCodes[indexPath.row].name
            cell.codeLbl.text = searchCountryCodes[indexPath.row].dialCode
            cell.imgLbl.text = searchCountryCodes[indexPath.row].flag
            
            return cell
        }
        else{
            let cell = tblView.dequeueReusableCell(withIdentifier: "CountryCodeTVC", for: indexPath) as! CountryCodeTVC
            
            cell.nameLbl.text = AppModel.shared.countryCodes[indexPath.row].name
            cell.codeLbl.text = AppModel.shared.countryCodes[indexPath.row].dialCode
            cell.imgLbl.text = AppModel.shared.countryCodes[indexPath.row].flag
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if isSearch {
            countryCodeLbl.text = searchCountryCodes[indexPath.row].dialCode
            countryLbl.text = searchCountryCodes[indexPath.row].code
        }
        else{
            countryCodeLbl.text = AppModel.shared.countryCodes[indexPath.row].dialCode
            countryLbl.text = AppModel.shared.countryCodes[indexPath.row].code
        }
        countryCodeBackView.isHidden = true
    }
}

