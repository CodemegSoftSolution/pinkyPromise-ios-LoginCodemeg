//
//  ProfileVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 07/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var languagePopupBackView: UIView!
    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var hindiBtn: UIButton!
    
    @IBOutlet var hindiPopupBackView: UIView!
    
    @IBOutlet weak var policyHeaderLbl: UILabel!
    @IBOutlet var policyBackView: UIView!
    @IBOutlet weak var messageTxtView: UITextView!
    
    private var AddDefaulLanguageVM: AddDefaulLanguageViewModel = AddDefaulLanguageViewModel()    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
        dataRander()
    }
    
    func configUI() {
        registerTableViewXib()
        setupTblViewheight()
        dataRander()
        
        languagePopupBackView.isHidden = true
        hindiPopupBackView.isHidden = true
        policyBackView.isHidden = true
    }
    
    func dataRander() {
        if AppModel.shared.currentUser != nil {
            if let userData = AppModel.shared.currentUser.userdata {
                headerLbl.text = "Hi \(userData.username)"
                nameLbl.text = userData.username
                
                if userData.defaultLanguage == LANGUAGE.Hindi.rawValue {
                    englishBtn.isSelected = false
                    hindiBtn.isSelected = true
                }
                else{
                    englishBtn.isSelected = true
                    hindiBtn.isSelected = false
                }
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    
    
    //MARK : - Button Click
    @IBAction func clickToProfileInfo(_ sender: Any) {
//        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "AboutMeVC") as! AboutMeVC
//        vc.isFromProfile = true
//        self.navigationController?.pushViewController(vc, animated: true)
        let vc: ProfilePageVC = ProfilePageVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToInstagram(_ sender: Any) {
        openUrlInSafari(strUrl: "https://www.instagram.com/askpinkypromise/?hl=en")
    }
    
    @IBAction func clickToFacebook(_ sender: Any) {
        openUrlInSafari(strUrl: "https://www.facebook.com/askpinkypromise/")
    }
    
    @IBAction func clickToCancelPolicyPopup(_ sender: Any) {
        policyBackView.isHidden = true
    }
    
    @IBAction func clickToEnglishBtn(_ sender: UIButton) {
        englishBtn.isSelected = true
        hindiBtn.isSelected = false
    }
    
    @IBAction func clickToHindi(_ sender: Any) {
        englishBtn.isSelected = false
        hindiBtn.isSelected = true
    }
    
    @IBAction func clickToHideLanguagePopup(_ sender: Any) {
        languagePopupBackView.isHidden = true
    }
    
    @IBAction func clickToConfirm(_ sender: Any) {
        if let userData = AppModel.shared.currentUser.userdata {
            if englishBtn.isSelected {
                UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                Bundle.setLanguage("en")
            }
            else {
                UserDefaults.standard.set(["hi"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                Bundle.setLanguage("hi")
            }
            AddDefaulLanguageVM.addDefaultLanguage(request: AddLanguageRequest(userid: userData.id, defaultLanguage: englishBtn.isSelected ? LANGUAGE.English.rawValue : LANGUAGE.Hindi.rawValue)) { (response) in
                
                var data : UserDataModel = UserDataModel()
                data.accesstoken = AppModel.shared.currentUser.accesstoken
                data.userdata = response.data
                setLoginUserData(data)
                AppModel.shared.currentUser = data
                AppModel.shared.token = data.accesstoken
                
                AppDelegate().sharedDelegate().navigateToDashBoard()
            }
        }
    }
    
    @IBAction func clickToViewPopup(_ sender: Any) {
        hindiPopupBackView.isHidden = false
        displaySubViewtoParentView(self.view, subview: hindiPopupBackView)
    }
    
    @IBAction func clickToCancelPopup(_ sender: Any) {
        hindiPopupBackView.isHidden = true
    }
    
}


//MARK: - TableView DataSource and Delegate Methods
extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    
    func registerTableViewXib() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.ProfileTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.ProfileTVC.rawValue)
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PROFILE.list.count
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.ProfileTVC.rawValue, for: indexPath) as? ProfileTVC else { return UITableViewCell() }
        
        cell.nameLbl.text = PROFILE.list[indexPath.row]
        cell.imgView.image = UIImage.init(named: PROFILE_IMG.list[indexPath.row])
        
        return cell
    }    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //reward
            let vc = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "RewardVC") as! RewardVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {
            //refer earn
            let vc = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "ReferEarnVC") as! ReferEarnVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2 {
            languagePopupBackView.isHidden = false
            displaySubViewtoParentView(UIApplication.topViewController()?.view, subview: languagePopupBackView)
        }
        else if indexPath.row == 3 {
            policyBackView.isHidden = false
            policyHeaderLbl.text = "Terms of Service"
            messageTxtView.attributedText = termsCondition.html2AttributedString //NSAttributedString.init(string: termsCondition)
            messageTxtView.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
            displaySubViewtoParentView(UIApplication.topViewController()?.view, subview: policyBackView)
        }
        else if indexPath.row == 4 {
            policyBackView.isHidden = false
            policyHeaderLbl.text = "Privacy Polcy"
            messageTxtView.attributedText = pricacyPolisyData.html2AttributedString
            messageTxtView.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
            displaySubViewtoParentView(UIApplication.topViewController()?.view, subview: policyBackView)
        }
        else if indexPath.row == 5 {
            let vc = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "MyOrderVC") as! MyOrderVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 6 {
            //address
            let vc = STORYBOARD.SHOP.instantiateViewController(withIdentifier: "CheckOutVC") as! CheckOutVC
            vc.isFromProfile = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 7 {
            //contact us
            policyBackView.isHidden = false
            policyHeaderLbl.text = "Contact us"
            messageTxtView.attributedText = contactUsData.html2AttributedString
            messageTxtView.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
            displaySubViewtoParentView(UIApplication.topViewController()?.view, subview: policyBackView)
        }
        else {
            showAlertWithOption(getTranslate("confirmation"), message: getTranslate("sure_you_want_to_logout"), btns: [getTranslate("cancel"),getTranslate("ok")], completionConfirm: {
                AppDelegate().sharedDelegate().continueToLogout()
            }) {
                
            }
        }
    }
    
    func setupTblViewheight() {
        tblViewHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        tblViewHeightConstraint.constant = tblView.contentSize.height
    }
}
