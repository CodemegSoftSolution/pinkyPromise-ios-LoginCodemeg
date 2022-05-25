//
//  ChatTopicVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 10/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class ChatTopicVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bannerAdsView: UIView!
    @IBOutlet weak var bannerBackView: View!
    
    @IBOutlet weak var potliBtn: UIButton!
    
    private var refreshControl : UIRefreshControl = UIRefreshControl.init()
    private var GetMyChatRoomVM: GetMyChatRoomViewModel = GetMyChatRoomViewModel()
    private var GetChatUnReadCountVM: GetChatUnReadCountViewModel = GetChatUnReadCountViewModel()
//    var chatRoomArr: [ChatMyRoomsInfoModel] = [ChatMyRoomsInfoModel]()
//    var topicArr : [ChatRoomModel] = [ChatRoomModel]()
    var googleBannerAds = GoogleBannerAds()
    let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
        
        if AppModel.shared.currentUser != nil {
            GetMyChatRoomVM.getMyChatRoomList(request: MyChatRoomRequest(userID: AppModel.shared.currentUser.userdata!.id))
            GetChatUnReadCountVM.getChatCount(request: MyChatRoomRequest(userID: AppModel.shared.currentUser.userdata?.id ?? ""))
        }
        
        potliBtn.setTitle(setCoin(), for: .normal)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate { changed, error in
                    googleBannerShow = RemoteConfig.remoteConfig().configValue(forKey: "google_banner").boolValue ?? false
                    print(googleBannerShow)
                
                    DispatchQueue.main.async {
                        self.googleBannerAds.loadAds(view: self.bannerAdsView, backView: self.bannerBackView)
                    }
                
                    googleIntertitialShow = RemoteConfig.remoteConfig().configValue(forKey: "google_interstitial").boolValue ?? false
                    print(googleIntertitialShow)
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }

    func configUI() {
        registerTableViewXib()
        refreshControllSetup()
 //       refreshDataSetUp()
        
        bannerAdsView.isHidden = true
        bannerBackView.isHidden = true
        
        GetMyChatRoomVM.chatRoomList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.tblView.reloadData()
                self.updateTblHeight()
            }
        }
        
        GetChatUnReadCountVM.success.bind { [weak self](_) in
            guard let `self` = self else { return }
            if self.GetChatUnReadCountVM.success.value {
                UserDefaults.standard.set(self.GetChatUnReadCountVM.getChatCountInfo.value, forKey: USER_DEFAULT_KEYS.chatCount.rawValue)
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFERESH_MESSAGE_COUNT), object: ["count": self.GetChatUnReadCountVM.getChatCountInfo.value])
            }
        }
        
        GoogleInterstitialAds.shared.initAds()
    }
    
    //MARK: - Refresh controll setup
    func refreshControllSetup() {
        refreshControl.tintColor = AppColor
        refreshControl.addTarget(self, action: #selector(refreshDataSetUp) , for: .valueChanged)
        tblView.refreshControl = refreshControl
    }
    
    //MARK: - Refresh data
    @objc func refreshDataSetUp() {
        refreshControl.endRefreshing()
        if AppModel.shared.currentUser != nil {
            GetMyChatRoomVM.getMyChatRoomList(request: MyChatRoomRequest(userID: AppModel.shared.currentUser.userdata!.id))
        }
    }
    
    @IBAction func clickToNavigateToBedges(_ sender: Any) {
        let vc = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "RewardVC") as! RewardVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//extension ChatTopicVC : GetMyChatRoomDelegate {
//    func didRecieveGetListChatRoomResponse(response: ChatMyRoomResponse) {
//        if response.chatRoomsInfo.count != 0 {
//            chatRoomArr = response.chatRoomsInfo
//            tblView.reloadData()
//        }
//    }
//
//    func didRecieveGetListChatRoomResponse(response: ChatRoomResponse) {
//        topicArr = response.chatRooms
//        tblView.reloadData()
//    }
//}


//MARK: - TableView DataSource and Delegate Methods
extension ChatTopicVC: UITableViewDataSource, UITableViewDelegate {
    
    func registerTableViewXib() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.ChatGroupTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.ChatGroupTVC.rawValue)
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GetMyChatRoomVM.chatRoomList.value.count
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.ChatGroupTVC.rawValue, for: indexPath) as? ChatGroupTVC else { return UITableViewCell() }
        
        cell.topicNameLbl.text = GetMyChatRoomVM.chatRoomList.value[indexPath.row].chatRoomName
        cell.messageLbl.text = GetMyChatRoomVM.chatRoomList.value[indexPath.row].latestMessage
        cell.timeLbl.text = getDateStringFromDateString(strDate: GetMyChatRoomVM.chatRoomList.value[indexPath.row].latestMsgTimestamp, formate: DATE_FORMMATE.DATE3.rawValue) // getDateStringFromDate(date: getDateFromDateString(strDate: chatRoomArr[indexPath.row].latestMsgTimestamp), format: DATE_FORMMATE.DATE3.getValue())
        
        cell.imgBtn.setImage(UIImage.init(named: CHAT_IMG.list[indexPath.row]), for: .normal)
        
        if GetMyChatRoomVM.chatRoomList.value[indexPath.row].unreadCount == 0 {
            cell.unReadCountBtn.isHidden = true
        }
        else{
            cell.unReadCountBtn.isHidden = false
            cell.unReadCountBtn.setTitle("\(GetMyChatRoomVM.chatRoomList.value[indexPath.row].unreadCount)", for: .normal)
        }
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = STORYBOARD.CHAT.instantiateViewController(withIdentifier: "MessageListVC") as! MessageListVC
        vc.GetMyChatRoomVM = GetMyChatRoomVM
        vc.selectedIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateTblHeight() {
        tblViewHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        tblViewHeightConstraint.constant = tblView.contentSize.height
    }

}
