//
//  ChatBotVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 06/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

var TOTAL_COIN: Int = 0
var googleBannerShow: Bool = false
var googleIntertitialShow: Bool = false

func setCoin() -> String {
    if TOTAL_COIN >= 1000 {
        let coin1 = Int(TOTAL_COIN/1000)
        return "\(coin1)K+"
    }
    else{
        return "\(TOTAL_COIN)"
    }
}

class ChatBotVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var gynecologistLbl: UILabel!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var getStartedBtn: Button!
    
    @IBOutlet weak var helloPinkyLbl: UILabel!
    @IBOutlet weak var myExpertLbl: UILabel!
    @IBOutlet var getStartedBackView: UIView!
    
    @IBOutlet weak var potliBtn: UIButton!
    @IBOutlet weak var potli1Btn: UIButton!
    
    
    var GetQuestionVM: GetQuestionViewModel = GetQuestionViewModel()
    private var GetChatUnReadCountVM: GetChatUnReadCountViewModel = GetChatUnReadCountViewModel()
    private var GetListTopicVM: GetListTopicViewModel = GetListTopicViewModel()
    var topicArr: [TopicModel] = [TopicModel]()
    private var BadgesVM: BadgesViewModel = BadgesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
        
        self.navigationController?.view.backgroundColor = .white
        
        let count = UserDefaults.standard.integer(forKey: USER_DEFAULT_KEYS.chatCount.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFERESH_MESSAGE_COUNT), object: ["count": count])
        
        if AppModel.shared.currentUser != nil {
            helloPinkyLbl.text = "Hello \(AppModel.shared.currentUser.userdata!.username), \(getTranslate("i_am_pinky"))"
        }
        
        potliBtn.setTitle(setCoin(), for: .normal)
        potli1Btn.setTitle(setCoin(), for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func configUI() {
        homeCollectionView.register(UINib(nibName: COLLECTION_VIEW_CELL.HomeCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.HomeCVC.rawValue)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.serviceCallToGetUserCoins), name: NSNotification.Name(rawValue: NOTIFICATION.REFERESH_COIN_COUNT), object: nil)
        
        getStartedBackView.isHidden = false
        displaySubViewtoParentView(self.view, subview: getStartedBackView)
        
        GetListTopicVM.delegate = self
        
        if AppModel.shared.currentUser != nil {
            
//            let timeDifference = currentTimeInMilliSeconds() - getLoginTimeData()
//            if !isShareApp() && timeDifference < (7 * 24 * 3600 * 1000) {    // Dialog shouldn't be shown after a week
//                showHelpUsPopup()
//            }
            
            GetListTopicVM.getTopicList(request: LanguageRequest(lng: AppModel.shared.currentUser.userdata?.defaultLanguage ?? "en"))
            
            helloPinkyLbl.text = "Hello \(AppModel.shared.currentUser.userdata!.username), \(getTranslate("i_am_pinky"))"
            myExpertLbl.text = getTranslate("my_expert_services")
            getStartedBtn.setTitle(getTranslate("let_get_started"), for: .normal)
            
            titleLbl.text = getTranslate("let_begin_What_are_you_here")
            gynecologistLbl.text = getTranslate("gynaecologist_verified_chatbot")
            
            serviceCallToGetUserCoins()
            
            GetChatUnReadCountVM.getChatCount(request: MyChatRoomRequest(userID: AppModel.shared.currentUser.userdata?.id ?? ""))
            
            BadgesVM.serviceCallToAppOpen(request: BedgesAppRequest(UserID: AppModel.shared.currentUser.userdata?.id ?? "")) { (response) in
                print(response)
                
                if response.rewardFlag == 1 {
                    showBadgesPopup(badgeImg: "reward1", title: "Yay!\nYou just won \(response.CoinsEarned!) coins!", bottomDesc: "Return to our app every 24 hours to keep winning", isCoin: true) {
                        self.serviceCallToGetUserCoins()
                    }
                }
                
                if response.ReferrerRewardFlag == 1 {
                    if response.ReferrerRewardData.count != 0 {
                        let totalFlag = response.ReferrerRewardData.map( {$0.coins} ).reduce(0, {$0 + $1})
                        showBadgesPopup(badgeImg: "reward1", title: "Yay!\nYou just won \(totalFlag) coins!", bottomDesc: "Return to our app every 24 hours to keep winning", isCoin: true) {
                            self.serviceCallToGetUserCoins()
                            self.BadgesVM.serviceCallToGetUpdateUserCoins(request: BedgesAppRequest(UserID: AppModel.shared.currentUser.userdata?.id ?? "")) { (response) in
                                self.serviceCallToGetUserCoins()
                            }
                        }
                    }
                }
            }
            
            BadgesVM.serviceCallToGetUserNewBedges(request: BedgesAppRequest(UserID: AppModel.shared.currentUser.userdata?.id ?? "")) { (response) in
                print(response)
                
                var newBadge : [Badge] = [Badge]()
                newBadge = response
                
                if newBadge.count != 0 {
                    for i in 0...newBadge.count - 1 {
                        showBadgesPopup(badgeImg: getImageFromBadges(newBadge[i].badge), title: newBadge[i].badge, bottomDesc: "You are such a promoter of Pinky Promise! Thank you!", isCoin: false) {
                            
                            let updateRequest = BedgesUpdateRequest(UserID: AppModel.shared.currentUser.userdata?.id ?? "", Data: [BedgesUpdateListRequest(id: newBadge[i].id, badge: newBadge[i].badge, read: true)])
                            
                            self.serviceCallToGetUserCoins()
                            
                            self.BadgesVM.serviceCallToGetUpdateUserNewBedges(request: updateRequest) { (response) in
                                print(response)
                            }
                        }
                    }
                }
            }
        }
        
        GetChatUnReadCountVM.success.bind { [weak self](_) in
            guard let `self` = self else { return }
            if self.GetChatUnReadCountVM.success.value {
                UserDefaults.standard.set(self.GetChatUnReadCountVM.getChatCountInfo.value, forKey: USER_DEFAULT_KEYS.chatCount.rawValue)
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFERESH_MESSAGE_COUNT), object: ["count": self.GetChatUnReadCountVM.getChatCountInfo.value])
            }
        }
    }
    
    @objc func serviceCallToGetUserCoins() {
        BadgesVM.serviceCallToGetUsersTotalCoin(request: BedgesAppRequest(UserID: AppModel.shared.currentUser.userdata?.id ?? "", appState: "start")) { (response) in
            TOTAL_COIN = response.TotalCoins!
            
            self.potliBtn.setTitle(setCoin(), for: .normal)
            self.potli1Btn.setTitle(setCoin(), for: .normal)
        }
    }
    
    //MARK: - Button Click
    @IBAction func clickToStarted(_ sender: Any) {
        getStartedBackView.isHidden = true
//        AppDelegate().sharedDelegate().scheduleLocalNotification()
    }
    
    @IBAction func clickToNavigateToBedges(_ sender: Any) {
        let vc = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "RewardVC") as! RewardVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChatBotVC : GetListTopicDelegate {
    func didRecieveGetListTopicResponse(response: GetListTopicResponse) {
        topicArr = response.data
        if topicArr.count != 0 {
            setTopicDataArrayData(topicArr)
        }
        homeCollectionView.reloadData()
    }
}

//MARK: - CollectionView Delegate & Datasource
extension ChatBotVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.HomeCVC.rawValue, for: indexPath) as? HomeCVC else {
            return UICollectionViewCell()
        }
        cell.imgView.image = UIImage.init(named: HOME_IMG.list[indexPath.row])
        cell.lbl.text = topicArr[indexPath.row].topicHeader
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = homeCollectionView.bounds.width/2
        let itemHeight = itemWidth + 60
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if topicArr[indexPath.row].introMessages.count == 0 {
            
            let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "ChatbotQuestionVC") as! ChatbotQuestionVC
            vc.selectedTid = topicArr[indexPath.row].tid
            vc.selectedQid = topicArr[indexPath.row].refID
            vc.selectedAnswerOption = []
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "MessageIntroVC") as! MessageIntroVC
            vc.topicDetail = topicArr[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
