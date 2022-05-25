//
//  MessageListVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 16/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class MessageListVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var imgBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    
    @IBOutlet weak var DropdownBackView: UIView!
    @IBOutlet weak var dropDownTblView: UITableView!
    
    @IBOutlet weak var replyBottomBackView: View!
    @IBOutlet weak var replyMessageLbl: UILabel!
    
    @IBOutlet weak var constraintBottomMsgTextField: NSLayoutConstraint!
    @IBOutlet weak var potliBtn: UIButton!
    @IBOutlet weak var downBtn: Button!
    
    private var ChatMessageVM: ChatMessageViewModel = ChatMessageViewModel()
//    var chatRoomArr: [ChatMyRoomsInfoModel] = [ChatMyRoomsInfoModel]()
    var GetMyChatRoomVM: GetMyChatRoomViewModel = GetMyChatRoomViewModel()
    var messageListArr: [MessageListModel] = [MessageListModel]()
    private var BadgesVM: BadgesViewModel = BadgesViewModel()
    private var currentPage : Int = VALUE.ONE.getValue()
    private var isHasMore : Bool = false
    var selectedIndex: Int = 0
    var isScroll: Bool = false
    var isFromNotification : Bool = false
    var notificationDict : [String: Any] = [String: Any]()
    
    var replyMessgeData: MessageListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
        SocketIOManager.sharedInstance.establishConnection()
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        potliBtn.setTitle(setCoin(), for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enable = true
        DispatchQueue.main.async {
            removeLoader()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        SocketIOManager.sharedInstance.closeConnection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.enable = false
        SocketIOManager.sharedInstance.getChatMessage { (tempMessage) in
            print(tempMessage)
            self.addMessage(tempMessage)
        }
        
        SocketIOManager.sharedInstance.getLikeUnLikeEventMessage { (tempResponse) in
            print(tempResponse)
            if tempResponse.id != 0 {
                let index = self.messageListArr.firstIndex { (data) -> Bool in
                    data.id == tempResponse.id
                }
                if index != nil {
                    self.messageListArr[index!].like = tempResponse.like
                    self.messageListArr[index!].unlike = tempResponse.unlike
                    self.messageListArr[index!].userFlag = tempResponse.userFlag
                    
                    self.tblView.reloadRows(at: [IndexPath.init(row: index!, section: 0)], with: .none)
                    
                    if tempResponse.rewardFlag != 0 && AppModel.shared.currentUser.userdata?.id == tempResponse.AuthorID {
                        TOTAL_COIN = TOTAL_COIN + tempResponse.CoinsEarned
                        self.potliBtn.setTitle("\(TOTAL_COIN)", for: .normal)
                    }
                }
            }
        }
    }
    
    func configUI() {
        registerTableViewXib()
        ChatMessageVM.delegate = self
        DropdownBackView.isHidden = true
        replyBottomBackView.isHidden = true
        
        messageTxt.delegate = self
        downBtn.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.joinSocketChannel), name: NSNotification.Name(rawValue: NOTIFICATION.SUBSCRIBE_CHANNEL), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if isFromNotification {
            renderUserFromNotification()
        }
        else{
            renderRoomData()
            serviceCallToGetMessageList()
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func renderUserFromNotification() {
        guard let roomId = notificationDict["room_id"] else { return }
        guard let messageId = notificationDict["message_id"] else { return }
        
        GetMyChatRoomVM.getMyChatRoomList(request: MyChatRoomRequest(userID: AppModel.shared.currentUser.userdata!.id))
        
        GetMyChatRoomVM.chatRoomList.bind { [weak self](_) in
            guard let `self` = self else { return }
            if self.GetMyChatRoomVM.success.value {
                if self.GetMyChatRoomVM.chatRoomList.value.count != 0 {
                    let index = self.GetMyChatRoomVM.chatRoomList.value.firstIndex { (data) -> Bool in
                        data.chatRoomID == roomId as! String
                    }
                    if index != nil {
                        self.selectedIndex = index!
                        self.renderRoomData()
                        self.serviceCallToGetMessageList()
                    }
                }
            }
        }
    }
    
    @objc func joinSocketChannel()  {
        if GetMyChatRoomVM.chatRoomList.value.count != 0 {
            SocketIOManager.sharedInstance.joinChannel(JoinChatRoomRequest(ChatRoom: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, userId: AppModel.shared.currentUser.userdata!.id))
        }
    }
    
    func renderRoomData() {
        headerLbl.text = GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomName
        imgBtn.setImage(UIImage.init(named: CHAT_IMG.list[selectedIndex]), for: .normal)
    }
    
    //MARK: - renderGroupInfo
    func serviceCallToGetMessageList() {
        if AppModel.shared.currentUser != nil {
            messageListArr = [MessageListModel]()
            isScroll = false
            ChatMessageVM.getMessageList(request: MyChatMessageRequest(UserID: AppModel.shared.currentUser.userdata!.id, ChatRoomId: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, LastMsgId: GetMyChatRoomVM.chatRoomList.value[selectedIndex].latestMessageID))
        }
    }
    
    func serviceCallToGetUserCoins() {
        BadgesVM.serviceCallToGetUsersTotalCoin(request: BedgesAppRequest(UserID: AppModel.shared.currentUser.userdata?.id ?? "", appState: "start")) { (response) in
            TOTAL_COIN = response.TotalCoins!
            
            self.potliBtn.setTitle("\(TOTAL_COIN)", for: .normal)
        }
    }
    
    //MARK: - addMessage
    func addMessage(_ msg : MessageListModel) {
       // messageListArr.append(setMessageData(msg))
        messageListArr.append(msg)
        GetMyChatRoomVM.addLastMessage(channelRef: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, messageData: msg)
        
        tblView.beginUpdates()
        tblView.insertRows(at: [IndexPath(row: messageListArr.count-1, section: 0)], with: .fade)
        tblView.endUpdates()
        if messageListArr.count > 1 {
            DispatchQueue.main.async {
                self.tblView.scrollToRow(at: IndexPath.init(row: self.messageListArr.count-1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }
        
//        if msg.rewardFlag != 0 && AppModel.shared.currentUser.userdata?.userid == msg.userID {
//            showBadgesPopup(badgeImg: "reward1", title: "Yay! \nYou just won \(msg.CoinsEarned) coins!", bottomDesc: "Keep talking on our chatrooms to win more", isCoin: true) {
//                self.serviceCallToGetUserCoins()
//            }
//        }
    }
    
//    func serviceCallToGetUserCoins() {
//        BadgesVM.serviceCallToGetUsersTotalCoin(request: BedgesAppRequest(UserID: AppModel.shared.currentUser.userdata?.id ?? "")) { (response) in
//            TOTAL_COIN = response.TotalCoins!
//
//            self.potliBtn.setTitle("\(TOTAL_COIN)", for: .normal)
//        }
//    }
    
    //MARK: - setMessageData
//    func setMessageData(_ dict: [String: Any]) -> MessageListModel {
//        var messageDict: MessageListModel = MessageListModel()
//        print(dict)
//        messageDict.id = dict["ID"] as! Int
//        messageDict.timeStamp = dict["TimeStamp"] as! String
//        messageDict.unlike = dict["Unlike"] as! Int
//        messageDict.like = dict["Like"] as! Int
//        messageDict.userID = dict["UserID"] as! String
//        messageDict.type = dict["Type"] as! String
//        messageDict.text = dict["Text"] as! String
//        messageDict.datumID = dict["_id"] as! String
//        messageDict.avatar = dict["Avatar"] as! String
//        messageDict.colorCode = dict["ColorCode"] as? String
//        messageDict.likeUsers = dict["LikeUsers"] as! [String]
//        messageDict.unlikeUsers = dict["UnlikeUsers"] as! [String]
//
//        if let replyInfo: [[String: Any]] = dict["ReplyMsgInfo"] as? [[String: Any]] {
//            if replyInfo.count != 0 {
//                print(replyInfo)
//            }
//        }
//
//        GetMyChatRoomVM.addLastMessage(channelRef: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, messageData: messageDict)
//        return messageDict
//    }

    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        if googleIntertitialShow {
            GoogleInterstitialAds.shared.loadAds {
                if self.GetMyChatRoomVM.chatRoomList.value.count != 0 {
                    self.ChatMessageVM.updateChatRoomActivity(request: UpdateChatRoomRequest(userID: AppModel.shared.currentUser.userdata!.id, ChatRoomID: self.GetMyChatRoomVM.chatRoomList.value[self.selectedIndex].chatRoomID, LastSeenMessageID: self.messageListArr.last!.id))
                }
                delay(0.3) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clickToSelectRoom(_ sender: Any) {
        DropdownBackView.isHidden = false
        dropDownTblView.reloadData()
    }
    
    @IBAction func clickToHideDropDownPopup(_ sender: Any) {
        DropdownBackView.isHidden = true
    }
    
    @IBAction func clickToCancelReplyMessage(_ sender: Any) {
        replyMessgeData = nil
        replyBottomBackView.isHidden = true
        replyMessageLbl.text = ""
    }
    
    @IBAction func clickToNavigateToBedges(_ sender: Any) {
        let vc = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "RewardVC") as! RewardVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToDownArrow(_ sender: Any) {
        self.tblView.scrollToRow(at: IndexPath.init(row: self.messageListArr.count-1, section: 0), at: .bottom, animated: true)
        downBtn.isHidden = true
    }
    
    @IBAction func clickToSend(_ sender: Any) {
        guard let message = messageTxt.text else { return }
        
        if message == DocumentDefaultValues.Empty.string {
            displayToast("Kindly enter your message")
        } else {
            
            var userData = SendMessageData(id: AppModel.shared.currentUser.userdata?.id ?? "", userName: AppModel.shared.currentUser.userdata?.username ?? "", text: message)
            if replyMessgeData != nil {
                userData.replyID = replyMessgeData.id
            }
            
            let request = SendMessageRequest(chatRoomID: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, data: userData)
            
            SocketIOManager.sharedInstance.sendMessage(request: request)
            
            messageTxt.text = ""
            replyMessgeData = nil
            self.replyBottomBackView.isHidden = true
            replyMessageLbl.text = ""
        }
    }
    
    //MARK: NotificationCenter handlers
    @objc func showKeyboard(notification: Notification) {
        if let frame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height

            DispatchQueue.main.async {
                self.constraintBottomMsgTextField.constant = height
                delay(0.01, closure: {
                    if self.tblView != nil &&  self.messageListArr.count > 0
                    {
                        self.tblView.scrollToRow(at: IndexPath.init(row: self.messageListArr.count - 1, section: 0), at: .bottom, animated: false)
                    }
                })
            }
        }
    }

    @objc func hideKeyboard(notification: Notification) {
        self.constraintBottomMsgTextField.constant = DEVICE.IS_IPHONE_X ? 34 : 0
        if messageListArr.count > 1 {
            tblView.scrollToRow(at: IndexPath.init(row: messageListArr.count-1, section: 0), at: UITableView.ScrollPosition.bottom, animated: false)
        }
    }

}

extension MessageListVC: MessageListDelegate {
    func didRecieveUpdateChatRoomResponse(response: SuccessModel) {
        
    }
    
    func didRecieveMessageListResponse(response: MessageListResponse) {
        if response.data.count != 0 {
            
            for item in response.data {
                messageListArr.append(item)
            }
            
            if self.messageListArr.count > 1 {
                self.messageListArr.sort {
                    let elapsed0 = $0.id //getTimestampFromDate(date: getDateFromDateString(strDate: $0.timeStamp)) //$0.updatedOn
                    let elapsed1 = $1.id //getTimestampFromDate(date: getDateFromDateString(strDate: $1.timeStamp)) //$1.updatedOn
                    return elapsed0 < elapsed1
                }
            }
            
//       DispatchQueue.main.async { [weak self] in
//          guard let `self` = self else { return }
            self.tblView.reloadData()
            if self.messageListArr.count > 1 && !self.isScroll {
                if GetMyChatRoomVM.chatRoomList.value[selectedIndex].lastSeenMessageID != GetMyChatRoomVM.chatRoomList.value[selectedIndex].latestMessageID {
                    let index = messageListArr.firstIndex { (data) -> Bool in
                        data.id == GetMyChatRoomVM.chatRoomList.value[selectedIndex].lastSeenMessageID
                    }
                    if index != nil {
                        self.tblView.scrollToRow(at: IndexPath.init(row: index!, section: 0), at: .top, animated: false)
                        downBtn.isHidden = false
                    }
                    else {
                        self.tblView.scrollToRow(at: IndexPath.init(item: 0, section: 0), at: .top, animated: true)
                        downBtn.isHidden = false
                    }
                }
                else{
                    self.tblView.scrollToRow(at: IndexPath.init(row: self.messageListArr.count-1, section: 0), at: UITableView.ScrollPosition.bottom, animated: false)
                }
                
                self.isScroll = true
            }
            else if self.messageListArr.count > 25 {
                self.tblView.scrollToRow(at: IndexPath.init(row: response.data.count, section: 0), at: .middle, animated: false)
            }
//      }
        }
    }
    
//    func didRecieveChatLIkeUnlikeResponse(response: MessageLikeResponse) {
//        if response.data != nil {
//            let index = messageListArr.firstIndex { (data) -> Bool in
//                data.id == response.data?.id
//            }
//            if index != nil {
//                messageListArr[index!].like = response.data?.like ?? 0
//                messageListArr[index!].unlike = response.data?.unlike ?? 0
//                messageListArr[index!].userFlag = response.data?.userFlag ?? 0
//
//                tblView.reloadRows(at: [IndexPath.init(row: index!, section: 0)], with: .none)
//            }
//        }
//    }
}

//MARK: - TableView DataSource and Delegate Methods
extension MessageListVC: UITableViewDataSource, UITableViewDelegate {
    
    func registerTableViewXib() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.SenderMessageTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.SenderMessageTVC.rawValue)
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.ReceiverMessageTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.ReceiverMessageTVC.rawValue)
        
        dropDownTblView.register(UINib.init(nibName: TABLE_VIEW_CELL.ChatRoomDropDownTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.ChatRoomDropDownTVC.rawValue)
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblView {
            return messageListArr.count
        }
        else{
            return GetMyChatRoomVM.chatRoomList.value.count
        }
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblView {
            if messageListArr[indexPath.row].userID == AppModel.shared.currentUser.userdata?.id {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.SenderMessageTVC.rawValue, for: indexPath) as? SenderMessageTVC else { return UITableViewCell() }
                
                cell.messageLbl.text = messageListArr[indexPath.row].text
                cell.timeLbl.text = getDateStringFromDateString(strDate: messageListArr[indexPath.row].timeStamp, formate: DATE_FORMMATE.DATE3.rawValue)
                
                cell.imgBtn.setTitle(messageListArr[indexPath.row].avatar, for: .normal)
                cell.imgBtn.backgroundColor = colorFromHex(hex: messageListArr[indexPath.row].colorCode?.capitalized ?? "")
                
                cell.likeBtn.setTitle("\(messageListArr[indexPath.row].like != 0 ? "\(messageListArr[indexPath.row].like)" : "")", for: .normal)
                cell.disLikeBtn.setTitle("\(messageListArr[indexPath.row].unlike != 0 ? "\(messageListArr[indexPath.row].unlike)" : "")", for: .normal)
                
                if messageListArr[indexPath.row].userFlag == 1 {
                    cell.likeBtn.isSelected = true
                }
                else{
                    cell.likeBtn.isSelected = false
                }
                if messageListArr[indexPath.row].userFlag == 2 {
                    cell.disLikeBtn.isSelected = true
                }
                else{
                    cell.disLikeBtn.isSelected = false
                }
                
                if indexPath.row == 0 {
                    cell.dateLbl.text = getDateStringFromDateString(strDate: messageListArr[indexPath.row].timeStamp, formate: DATE_FORMMATE.DATE4.rawValue)
                }
                else {
                    if getDateStringFromDateString(strDate: messageListArr[indexPath.row].timeStamp, formate: DATE_FORMMATE.DATE4.rawValue) == getDateStringFromDateString(strDate: messageListArr[indexPath.row - 1].timeStamp, formate: DATE_FORMMATE.DATE4.rawValue) {
                        cell.dateBackView.isHidden = true
                    }
                    else{
                        cell.dateBackView.isHidden = false
                        cell.dateLbl.text = getDateStringFromDateString(strDate: messageListArr[indexPath.row].timeStamp, formate: DATE_FORMMATE.DATE4.rawValue)
                    }
                }
                
                cell.likeBtn.tag = indexPath.row
                cell.likeBtn.addTarget(self, action: #selector(self.clickToLikeMessage), for: .touchUpInside)
                
                cell.disLikeBtn.tag = indexPath.row
                cell.disLikeBtn.addTarget(self, action: #selector(self.clickToUnLikeMessage), for: .touchUpInside)
                
                if messageListArr[indexPath.row].replyMsgInfo.count != 0 {
                    cell.replyMessageBackView.isHidden = false
                    cell.replyMessageLbl.text = messageListArr[indexPath.row].replyMsgInfo.first?.text
                }
                else{
                    cell.replyMessageBackView.isHidden = true
                }
                
                return cell
            }
            else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.ReceiverMessageTVC.rawValue, for: indexPath) as? ReceiverMessageTVC else { return UITableViewCell() }
                
                cell.messageLbl.text = messageListArr[indexPath.row].text
                cell.timeLbl.text = getDateStringFromDateString(strDate: messageListArr[indexPath.row].timeStamp, formate: DATE_FORMMATE.DATE3.rawValue)
                
                cell.imgBtn.setTitle(messageListArr[indexPath.row].avatar, for: .normal)
                cell.imgBtn.backgroundColor = colorFromHex(hex: messageListArr[indexPath.row].colorCode?.capitalized ?? "")
                
                cell.likeBtn.setTitle("\(messageListArr[indexPath.row].like != 0 ? "\(messageListArr[indexPath.row].like)" : "")", for: .normal)
                cell.disLikeBtn.setTitle("\(messageListArr[indexPath.row].unlike != 0 ? "\(messageListArr[indexPath.row].unlike)" : "")", for: .normal)
                
                if messageListArr[indexPath.row].userFlag == 1 {
                    cell.likeBtn.isSelected = true
                }
                else{
                    cell.likeBtn.isSelected = false
                }
                if messageListArr[indexPath.row].userFlag == 2 {
                    cell.disLikeBtn.isSelected = true
                }
                else{
                    cell.disLikeBtn.isSelected = false
                }
                
                if indexPath.row == 0 {
                    cell.dateLbl.text = getDateStringFromDateString(strDate: messageListArr[indexPath.row].timeStamp, formate: DATE_FORMMATE.DATE4.rawValue)
                }
                else {
                    if getDateStringFromDateString(strDate: messageListArr[indexPath.row].timeStamp, formate: DATE_FORMMATE.DATE4.rawValue) == getDateStringFromDateString(strDate: messageListArr[indexPath.row - 1].timeStamp, formate: DATE_FORMMATE.DATE4.rawValue) {
                        cell.dateBackView.isHidden = true
                    }
                    else{
                        cell.dateBackView.isHidden = false
                        cell.dateLbl.text = getDateStringFromDateString(strDate: messageListArr[indexPath.row].timeStamp, formate: DATE_FORMMATE.DATE4.rawValue)
                    }
                }
                
                cell.likeBtn.tag = indexPath.row
                cell.likeBtn.addTarget(self, action: #selector(self.clickToLikeMessage), for: .touchUpInside)
                
                cell.disLikeBtn.tag = indexPath.row
                cell.disLikeBtn.addTarget(self, action: #selector(self.clickToUnLikeMessage), for: .touchUpInside)
                
                if messageListArr[indexPath.row].replyMsgInfo.count != 0 {
                    cell.replyMessageBackView.isHidden = false
                    cell.replyMessageLbl.text = messageListArr[indexPath.row].replyMsgInfo.first?.text
                }
                else{
                    cell.replyMessageBackView.isHidden = true
                }
                
                return cell
            }
        }
        else{
            guard let cell = dropDownTblView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.ChatRoomDropDownTVC.rawValue, for: indexPath) as? ChatRoomDropDownTVC else { return UITableViewCell() }
            
            cell.topicNameLbl.text = GetMyChatRoomVM.chatRoomList.value[indexPath.row].chatRoomName
            cell.imgBtn.setImage(UIImage.init(named: CHAT_IMG.list[indexPath.row]), for: .normal)
            
            if selectedIndex == indexPath.row {
                cell.backView.backgroundColor = LightPinkColor
                cell.topicNameLbl.textColor = AppColor
            }
            else{
                if #available(iOS 13.0, *) {
                    cell.backView.backgroundColor = UIColor.systemGray6
                } else {
                    cell.backView.backgroundColor = ExtraLightGrayColor
                }
                cell.topicNameLbl.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == dropDownTblView {
            self.view.endEditing(true)
            ChatMessageVM.updateChatRoomActivity(request: UpdateChatRoomRequest(userID: AppModel.shared.currentUser.userdata!.id, ChatRoomID: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, LastSeenMessageID: messageListArr.last!.id))
            messageListArr = [MessageListModel]()
            tblView.reloadData()
            
            selectedIndex = indexPath.row
            renderRoomData()
            serviceCallToGetMessageList()
            joinSocketChannel()
            DropdownBackView.isHidden = true
        }
        else if tableView == tblView {
            if messageListArr[indexPath.row].replyMsgInfo.count != 0 {
                let index = messageListArr.firstIndex { (data) -> Bool in
                    data.id == messageListArr[indexPath.row].replyMsgInfo.first?.id
                }
                if index != nil {
                    self.tblView.scrollToRow(at: IndexPath.init(row: index!, section: 0), at: .top, animated: false)
                }
                else {
                    self.tblView.scrollToRow(at: IndexPath.init(item: 0, section: 0), at: .top, animated: true)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == tblView {
            print(indexPath.row)
            if indexPath.row == 0 && (messageListArr[indexPath.row].id - 1) != 0 {
                self.view.endEditing(true)
                ChatMessageVM.getMessageList(request: MyChatMessageRequest(UserID: AppModel.shared.currentUser.userdata!.id, ChatRoomId: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, LastMsgId: messageListArr[indexPath.row].id - 1))
            }
        }
    }
        
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.replyMessgeData = self.messageListArr[indexPath.row]
            if self.replyMessgeData != nil {
                self.replyBottomBackView.isHidden = false
                self.replyMessageLbl.text = self.replyMessgeData.text
            }
            success(true)
        })
        closeAction.image = UIImage(named: "message_back")
        closeAction.backgroundColor = .white
     
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    
    @objc func clickToLikeMessage(_ sender: UIButton) {
//        ChatMessageVM.chatRoomLikeUnlike(request: ChatLikeUnlikeRequest(UserID: AppModel.shared.currentUser.userdata!.id, ChatRoomId: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, MsgId: messageListArr[sender.tag].id, Flag: "LIKE"))
        
        SocketIOManager.sharedInstance.addLikeUnLikeMessage(request: ChatLikeUnlikeRequest(UserID: AppModel.shared.currentUser.userdata!.id, ChatRoomId: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, MsgId: messageListArr[sender.tag].id, Flag: "LIKE"))
    }
    
    @objc func clickToUnLikeMessage(_ sender: UIButton) {
//        ChatMessageVM.chatRoomLikeUnlike(request: ChatLikeUnlikeRequest(UserID: AppModel.shared.currentUser.userdata!.id, ChatRoomId: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, MsgId: messageListArr[sender.tag].id, Flag: "UNLIKE"))
        
        SocketIOManager.sharedInstance.addLikeUnLikeMessage(request: ChatLikeUnlikeRequest(UserID: AppModel.shared.currentUser.userdata!.id, ChatRoomId: GetMyChatRoomVM.chatRoomList.value[selectedIndex].chatRoomID, MsgId: messageListArr[sender.tag].id, Flag: "UNLIKE"))
    }
    
}
