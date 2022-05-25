//
//  ReferEarnVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 20/01/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig
import Foundation

class ReferEarnVC: UIViewController {

    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var referralCodeLbl: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
    
    private var BadgesVM: BadgesViewModel = BadgesViewModel()
    let remoteConfig = RemoteConfig.remoteConfig()
    var shareMesssageString: String = String()
    
    var titleArr = ["Press “Share”", "Friend enters code", "Profile created, and you win!"]
    var howWorkArr = ["Share this code with a friend, using the “Share” button above", "Your friend downloads the app and enters your code", "Your friend creates their profile on Pinky Promise and voila, you both get 50 coins worth INR 50"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    func configUI() {
        registerTableViewXib()
        apiCalling()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate { changed, error in
                
                let referAmountShare = RemoteConfig.remoteConfig().configValue(forKey: "refer_amount").stringValue ?? "undefined"
                print(referAmountShare)
                self.remoteConfigDataSetup(referAmountShare)
                
                self.shareMesssageString = RemoteConfig.remoteConfig().configValue(forKey: "share_message").stringValue ?? "undefined"
                print(self.shareMesssageString)
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
   //       self.displayWelcome()
        }
    }
    
    func apiCalling() {
        if let userData = AppModel.shared.currentUser.userdata {
            BadgesVM.serviceCallToGetReferralCode(request: BedgesAppRequest(UserID: userData.id)) { (response) in
                self.referralCodeLbl.text = response.ReferalCode
            }
        }
    }
    
    func remoteConfigDataSetup(_ priceData: String) {
        DispatchQueue.main.async {
            self.priceLbl.text = priceData
        }
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToCopyCode(_ sender: Any) {
        if referralCodeLbl.text != "" {
            UIPasteboard.general.string = referralCodeLbl.text?.trimmed
            displayToast("Copy")
        }
    }
    
    @IBAction func clickToShare(_ sender: Any) {
        if shareMesssageString != "" {
            let s1 = shareMesssageString.replacingOccurrences(of: "xxxxxx", with: "\(referralCodeLbl.text ?? "")")
            shareMesssageString = s1
            shareText(self, shareMesssageString)
        }
        else{
            shareText(self, shareAppMessage)
        }
    }
}

//MARK: - TableView DataSource and Delegate Methods
extension ReferEarnVC: UITableViewDataSource, UITableViewDelegate {
    func registerTableViewXib() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.HowItsWorkTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.HowItsWorkTVC.rawValue)
        tblView.reloadData()
        
        updateTblHeight()
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return howWorkArr.count
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.HowItsWorkTVC.rawValue, for: indexPath) as? HowItsWorkTVC else { return UITableViewCell() }
           
        cell.titleLbl.text = titleArr[indexPath.row]
        cell.numberBtn.isUserInteractionEnabled = false
        cell.numberBtn.setTitle("\(indexPath.row + 1)", for: .normal)
        
        cell.descLbl.text = howWorkArr[indexPath.row]
        
        if indexPath.row == 3 - 1 {
            cell.bottomBackView.isHidden = true
        }
        else{
            cell.bottomBackView.isHidden = false
        }
            
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateTblHeight() {
        tblViewHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        tblViewHeightConstraint.constant = tblView.contentSize.height
    }
}
