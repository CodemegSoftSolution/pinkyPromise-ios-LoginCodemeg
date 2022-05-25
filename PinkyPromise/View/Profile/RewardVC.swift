//
//  RewardVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 10/11/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation
import UIKit
import FirebaseRemoteConfig

var lightProgreeGray = colorFromHex(hex: "D6DDE3")
var firstColor = colorFromHex(hex: "9AC2C9")
var secondColor = colorFromHex(hex: "F58A1F")
var thirdColor = colorFromHex(hex: "FFC708")
var fourthColor = colorFromHex(hex: "FCEE3B")
var fifthColor = colorFromHex(hex: "FF8E8C")


class RewardVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var totalPointLbl: UILabel!
    @IBOutlet weak var reachingLbl: UILabel!
    
    @IBOutlet weak var bedgeCollectionView: UICollectionView!
    @IBOutlet weak var redeemCollectionView: UICollectionView!
    @IBOutlet weak var earnTblView: UITableView!
    @IBOutlet weak var earnTblViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var badgesBackView: UIView!
    @IBOutlet weak var bedgesImgView: UIImageView!
    @IBOutlet weak var bedgeTitleLbl: UILabel!
    @IBOutlet weak var bedgeTimeLbl: UILabel!
    
    @IBOutlet weak var firstPointView: View!
    @IBOutlet weak var firstProgressView: UIProgressView!
    @IBOutlet weak var secondPointView: View!
    @IBOutlet weak var secondProgressView: UIProgressView!
    @IBOutlet weak var thirdPointView: View!
    @IBOutlet weak var thirdProgressView: UIProgressView!
    @IBOutlet weak var fourthPointView: View!
    @IBOutlet weak var fourthProgressView: UIProgressView!
    @IBOutlet weak var fifthPointView: View!
    @IBOutlet weak var fifthProgressView: UIProgressView!
    @IBOutlet weak var sixthPointView: View!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var referralCodeLbl: UILabel!
    
    private var GetAllProductVM: GetAllProductViewModel = GetAllProductViewModel()
    private var BadgesVM: BadgesViewModel = BadgesViewModel()
    var badgeArr: [Badge] = [Badge]()
    var arrWelcome = [WelcomeModel]()
    
    var totalBedgeData: TotalBedgesResponse!
    let remoteConfig = RemoteConfig.remoteConfig()
    var referAmout: String = String()
    
    var shareMesssageString: String = String()
    var faqListData: [FaqListModel] = [FaqListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    func configUI() {
        registerTableViewXib()
        registerCollectionViewXib()
        self.priceLbl.text = ""
        
        GetAllProductVM.getAllProductList(request: ShopLanguageRequest(language: AppModel.shared.currentUser.userdata?.defaultLanguage ?? "en"))
        apiCalling()
        
        GetAllProductVM.productList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.redeemCollectionView.reloadData()
            }
        }
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate { changed, error in
                
                let referAmountShare = RemoteConfig.remoteConfig().configValue(forKey: "refer_amount").stringValue ?? "undefined"
                print(referAmountShare)
                self.referAmout = referAmountShare
                self.remoteConfigDataSetup(referAmountShare)
                
                self.shareMesssageString = RemoteConfig.remoteConfig().configValue(forKey: "share_message").stringValue ?? "undefined"
                print(self.shareMesssageString)
                
                let jsonString: [[String:String]] = RemoteConfig.remoteConfig().configValue(forKey: "faq_list").jsonValue as! [[String : String]]
                print(jsonString)
                self.faqListData = [FaqListModel]()
                  
                do {
                    let data = try! JSONSerialization.data(withJSONObject: jsonString)
                    let object = try JSONDecoder().decode([FaqListModel].self, from: data)
                    
                    self.faqListData = object
                    print(self.faqListData)
                    
                    DispatchQueue.main.async {
                        self.updateTblHeight()
                //        self.tblView.reloadData()
                    }
                }
                catch let err {
                    log.error("\(Log.stats())\(err)")/
                }
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
        }
    }
    
    func remoteConfigDataSetup(_ priceData: String) {
        DispatchQueue.main.async {
            self.priceLbl.text = priceData
            self.updateEarnTblHeight()
        }
        
        DispatchQueue.main.async {
            self.earnTblView.reloadData()
        }
    }
    
    func apiCalling() {
        if let userData = AppModel.shared.currentUser.userdata {
            nameLbl.text = "Hi \(userData.username)"
            
            BadgesVM.serviceCallToGetUsersTotalCoin(request: BedgesAppRequest(UserID: userData.id)) { (response) in
                self.totalBedgeData = response
                if self.totalBedgeData != nil {
                    TOTAL_COIN = self.totalBedgeData.TotalCoins!
                    
                    self.pointLbl.text = "\(self.totalBedgeData.TotalCoins!) Point"
                    self.totalPointLbl.text = "\(self.totalBedgeData.TotalCoins!)/1000"
                    
                    self.progressBarSetup()
                }
            }
            
            BadgesVM.serviceCallToGetUserBedges(request: BedgesAppRequest(UserID: userData.id)) { (response) in
                self.bedgeCollectionView.isHidden = false
                self.badgeArr = response
                self.startTimer()
                delay(0.3) {
                    self.bedgeCollectionView.isHidden = false
                    self.bedgeCollectionView.reloadData()
                }
            }
            
            self.redeemCollectionView.reloadData()
            
            BadgesVM.serviceCallToGetReferralCode(request: BedgesAppRequest(UserID: userData.id)) { (response) in
                self.referralCodeLbl.text = response.ReferalCode
            }
        }
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToCancelBedges(_ sender: Any) {
        badgesBackView.isHidden = true
    }
    
    func progressBarSetup() {
        firstPointView.backgroundColor = lightProgreeGray
        secondPointView.backgroundColor = lightProgreeGray
        thirdPointView.backgroundColor = lightProgreeGray
        fourthPointView.backgroundColor = lightProgreeGray
        fifthPointView.backgroundColor = lightProgreeGray
        sixthPointView.backgroundColor = lightProgreeGray
        
        firstProgressView.progress = 0
        secondProgressView.progress = 0
        thirdProgressView.progress = 0
        fourthProgressView.progress = 0
        fifthProgressView.progress = 0
        
        if totalBedgeData.TotalCoins! == 0 {
            
        }
        else if totalBedgeData.TotalCoins! <= 200 {
            firstPointView.backgroundColor = firstColor
            firstProgressView.progress = Float(totalBedgeData.TotalCoins!/2)/100
            
            reachingLbl.text = "Hey!! You’re \(200 - totalBedgeData.TotalCoins!) Points away from Reaching Next Level"
        }
        else if totalBedgeData.TotalCoins! <= 400 {
            firstPointView.backgroundColor = firstColor
            firstProgressView.progress = 1
            secondPointView.backgroundColor = secondColor
            secondProgressView.progress = Float((totalBedgeData.TotalCoins! - 200)/2)/100
            
            reachingLbl.text = "Hey!! You’re \(400 - totalBedgeData.TotalCoins!) Points away from Reaching Next Level"
        }
        else if totalBedgeData.TotalCoins! <= 600 {
            firstPointView.backgroundColor = firstColor
            firstProgressView.progress = 1
            secondPointView.backgroundColor = secondColor
            secondProgressView.progress = 1
            thirdPointView.backgroundColor = thirdColor
            thirdProgressView.progress = Float((totalBedgeData.TotalCoins! - 400)/2)/100
            
            reachingLbl.text = "Hey!! You’re \(600 - totalBedgeData.TotalCoins!) Points away from Reaching Next Level"
        }
        else if totalBedgeData.TotalCoins! <= 800 {
            firstPointView.backgroundColor = firstColor
            firstProgressView.progress = 1
            secondPointView.backgroundColor = secondColor
            secondProgressView.progress = 1
            thirdPointView.backgroundColor = thirdColor
            thirdProgressView.progress = 1
            fourthPointView.backgroundColor = fourthColor
            fourthProgressView.progress = Float((totalBedgeData.TotalCoins! - 600)/2)/100
        }
        else if totalBedgeData.TotalCoins! <= 1000 {
            firstPointView.backgroundColor = firstColor
            firstProgressView.progress = 1
            secondPointView.backgroundColor = secondColor
            secondProgressView.progress = 1
            thirdPointView.backgroundColor = thirdColor
            thirdProgressView.progress = 1
            fourthPointView.backgroundColor = fourthColor
            fourthProgressView.progress = 1
            fifthPointView.backgroundColor = fifthColor
            fifthProgressView.progress = Float((totalBedgeData.TotalCoins! - 800)/2)/100
            
            reachingLbl.text = "Hey!! You’re \(1000 - totalBedgeData.TotalCoins!) Points away from Reaching Next Level"
            
            if totalBedgeData.TotalCoins! == 1000 {
                sixthPointView.backgroundColor = fifthColor
                
                reachingLbl.text = ""
            }
        }
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

//MARK: - CollectionView Delegate & Datasource
extension RewardVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func registerCollectionViewXib() {
        bedgeCollectionView.register(UINib.init(nibName: COLLECTION_VIEW_CELL.MyBedgeCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.MyBedgeCVC.rawValue)
        
        redeemCollectionView.register(UINib.init(nibName: COLLECTION_VIEW_CELL.ReddemPointCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.ReddemPointCVC.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bedgeCollectionView {
            return BADGES_NAME.list.count
        }
        else {
            return GetAllProductVM.productList.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bedgeCollectionView {
            guard let cell = bedgeCollectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.MyBedgeCVC.rawValue, for: indexPath) as? MyBedgeCVC else {
                return UICollectionViewCell()
            }
            
            cell.nameLbl.text = BADGES_NAME.list[indexPath.row]
            
            let index = badgeArr.firstIndex { (data) -> Bool in
                data.badge == BADGES_NAME.list[indexPath.row]
            }
            if index != nil {
                cell.imgView.image = UIImage.init(named: getImageFromBadges(BADGES_NAME.list[indexPath.row]))
                cell.backView.backgroundColor = LightPinkColor
                cell.nameLbl.textColor = DarkTextColor
            }
            else{
                cell.imgView.image = UIImage.init(named: getGrayImageFromBadges(BADGES_NAME.list[indexPath.row]))
                cell.backView.backgroundColor = colorFromHex(hex: "#F4F4F4")
                cell.nameLbl.textColor = DarkTextColor
            }
            
            return cell
        }
        else {
            guard let cell = redeemCollectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.ReddemPointCVC.rawValue, for: indexPath) as? ReddemPointCVC else {
                return UICollectionViewCell()
            }
            
            cell.productImgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: GetAllProductVM.productList.value[indexPath.row].productImage)
            
      //      cell.nameLbl.text = GetAllProductVM.productList.value[indexPath.row].productName
            
            cell.redeemNowBtn.tag = indexPath.row
            cell.redeemNowBtn.addTarget(self, action: #selector(self.clickToRedeemNow), for: .touchUpInside)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bedgeCollectionView {
            badgesBackView.isHidden = false
            displaySubViewtoParentView(self.view, subview: badgesBackView)
            
            bedgeTitleLbl.text = BADGES_NAME.list[indexPath.row]
            
            let index = badgeArr.firstIndex { (data) -> Bool in
                data.badge == BADGES_NAME.list[indexPath.row]
            }
            if index != nil {
                bedgesImgView.image = UIImage.init(named: getImageFromBadges(BADGES_NAME.list[indexPath.row]))
                bedgeTitleLbl.textColor = DarkTextColor
                bedgeTimeLbl.text = "Achived on \(getDateStringFromDateString(strDate: badgeArr[indexPath.row].credited, formate: "d MMMM yyyy"))"
            }
            else{
                bedgesImgView.image = UIImage.init(named: getGrayImageFromBadges(BADGES_NAME.list[indexPath.row]))
                bedgeTitleLbl.textColor = colorFromHex(hex: "#7A7A7A")
                bedgeTimeLbl.text = ""
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bedgeCollectionView {
            let itemWidth = bedgeCollectionView.bounds.width/1.3
            let itemHeight = bedgeCollectionView.bounds.height
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else {
            print(SCREEN.WIDTH)
            let itemWidth = redeemCollectionView.bounds.width
            let itemHeight = redeemCollectionView.bounds.height
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    @objc func clickToRedeemNow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
        NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex": 2])
        
//        if let userData = AppModel.shared.currentUser.userdata {
//            BadgesVM.serviceCallToGetRedeemUserCoin(request: BedgesAppRequest(UserID: userData.id)) { (response) in
//                print(response)
//
//
//            }
//        }
    }
    
    func startTimer() {
        let timer =  Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }

    @objc func scrollAutomatically(_ timer1: Timer) {
        if let coll  = redeemCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < 2/*sliderArr.count*/ - 1){
                    UIView.animate(withDuration: 0.001, delay: 0, options: .curveEaseInOut) {
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                        coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                    }
                }
                else{
                    UIView.animate(withDuration: 0.001, delay: 0, options: .curveEaseInOut) {
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                        coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                    }
                }
            }
        }
    }
}

//MARK: - TableView DataSource and Delegate Methods
extension RewardVC: UITableViewDataSource, UITableViewDelegate {
    
    func registerTableViewXib() {
        earnTblView.register(UINib.init(nibName: TABLE_VIEW_CELL.EarnCoinTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.EarnCoinTVC.rawValue)
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.FaqListTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.FaqListTVC.rawValue)
        
        arrWelcome = [WelcomeModel]()
        for temp in getJsonFromFile("howitwork") {
            arrWelcome.append(WelcomeModel.init(temp))
        }
        earnTblView.reloadData()
        tblView.reloadData()
        
        updateEarnTblHeight()
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == earnTblView {
            return arrWelcome.count
        }
        else{
            return faqListData.count
        }
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == earnTblView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.EarnCoinTVC.rawValue, for: indexPath) as? EarnCoinTVC else { return UITableViewCell() }
            
            cell.titleLbl.text = arrWelcome[indexPath.row].title
            cell.descLbl.text = arrWelcome[indexPath.row].desc
            
            let charset = CharacterSet(charactersIn: "xx")
            if arrWelcome[indexPath.row].desc.rangeOfCharacter(from: charset) != nil {
                print("yes")
                if referAmout != "" {
                    let s1 = arrWelcome[indexPath.row].desc.replacingOccurrences(of: "xx", with: "\(referAmout)")
                    arrWelcome[indexPath.row].desc = s1
                    cell.descLbl.text = arrWelcome[indexPath.row].desc
                }
            }
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.FaqListTVC.rawValue, for: indexPath) as? FaqListTVC else { return UITableViewCell() }
            
            cell.questionLbl.text = "Q " + faqListData[indexPath.row].question
            cell.answerLbl.text = faqListData[indexPath.row].answer
            
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func updateEarnTblHeight() {
        earnTblViewHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        earnTblView.reloadData()
        earnTblView.layoutIfNeeded()
        earnTblViewHeightConstraint.constant = earnTblView.contentSize.height
    }
    
    func updateTblHeight() {
        tblViewHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        tblViewHeightConstraint.constant = tblView.contentSize.height
    }
}
