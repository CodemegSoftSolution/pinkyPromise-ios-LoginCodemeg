//
//  ChatbotQuestionVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 06/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import SmoothPicker
import SwiftyGif


var totalQuestion = 0

extension ChatbotQuestionVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print("back")
        return true
    }
}

class ChatbotQuestionVC: UIViewController {
    
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectMoreOptionBackView: UIView!
    
    @IBOutlet weak var pickerDisplayView: View!
    @IBOutlet weak var pickerBackView: UIView!
    @IBOutlet weak var pickerView: SmoothPickerView!
    
    @IBOutlet weak var multipleSelectionNextBtn: Button!
    
    @IBOutlet var tutorialBackView: UIView!
    @IBOutlet weak var gifImgVIew: UIImageView!
    @IBOutlet weak var bottomAdsView: UIView!
    
    var i = 0
    var views = [UIView]()
    
    private var GetDiagnosticResultVM: GetDiagnosticResultViewModel = GetDiagnosticResultViewModel()
    var GetQuestionVM: GetQuestionViewModel = GetQuestionViewModel()
    
    var selectedTid : Int = Int()
    var selectedQid : Int = Int()
    var selectedAnswerOption: [SelectedOption] = [SelectedOption]()
    var currentSelectedOption: SelectedOption = SelectedOption()
    
    var selectedIndex: Int = -1
    var qestionData: QuestionModel = QuestionModel()
    
    var selectedMultipleAnswerOption: [IdRequest] = [IdRequest]() //[SelectedOption] = [SelectedOption]()
    
    var isFromIntroResultForRemoveViewController: Bool = false
    var isQidIsNextRef: Bool = false
    var googleBannerAds = GoogleBannerAds()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configUI() {
        registerTableViewXib()
        getQuestionDataServiceCall()
//        setupQuestion()
        multipleSelectionNextBtn.isHidden = true
        selectMoreOptionBackView.isHidden = true
        pickerBackView.isHidden = true
        tblView.isHidden = true
        
        questionLbl.text = ""
        
        pickerDisplayView.cornerRadius = 5
        pickerDisplayView.borderWidth = 1
        pickerDisplayView.borderColorTypeAdapter = 9
        
        pickerView.reloadData()
    }
    
    func setupScreenUI(_ backView: UIView) {
        backView.addBorderColorWithCornerRadius(borderColor: AppColor.cgColor, borderWidth: 1, cornerRadius: 8)
    }
    
    func getQuestionDataServiceCall() {
        totalQuestion = totalQuestion + 1
        
        if !isShowTutorial() && totalQuestion == 2 {
            setIsShowTutorial(isUserLogin: true)
            tutorialBackView.isHidden = false
            displaySubViewtoParentView(self.view, subview: tutorialBackView)
            do {
                let gif = try UIImage(gifName: "left_right.gif")
                self.gifImgVIew.setGifImage(gif, loopCount: -1)
            } catch {
                print(error)
            }
        }
        
        if currentSelectedOption.QID != 0 && currentSelectedOption.QID != nil {
            selectedAnswerOption.append(currentSelectedOption)
        }
        
        if selectedTid == 1 || selectedTid == 2 || selectedTid == 4 {
            GetQuestionVM.getQuestionList(basicQuestion: true, request: GetQuestionRequest(user: AppModel.shared.currentUser.userdata?.id, lng: AppModel.shared.currentUser.userdata?.defaultLanguage, QID: selectedQid, TID: selectedTid, SelectedOptions: selectedAnswerOption)) { (response) in
                print(response)
                self.qestionData = response.data ?? QuestionModel()
                self.setupQuestion()
                
                if response.AddsFlag == 0 {
                    self.bottomAdsView.isHidden = true
                }
                else{
                    self.bottomAdsView.isHidden = false
                    self.googleBannerAds.loadAdsWithShortHeight(view: self.bottomAdsView)
                }
            }
        }
        else if selectedTid == 7 {
            if isFromIntroResultForRemoveViewController {
                guard let navigationController = self.navigationController else { return }
                var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
                navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
                self.navigationController?.viewControllers = navigationArray
            }
            
            GetQuestionVM.getQuestionList(basicQuestion: false, request: GetQuestionRequest(user: AppModel.shared.currentUser.userdata?.id, lng: AppModel.shared.currentUser.userdata?.defaultLanguage, QID: selectedQid, TID: selectedTid, SelectedOptions: selectedAnswerOption)) { (response) in
                
                print(response)
                self.qestionData = response.data ?? QuestionModel()
                
                let index = QID_FOR_PERIOD_PROBLEM.firstIndex { (qidData) -> Bool in
                    qidData == self.qestionData.qid
                }
                if index != nil {
                    if self.currentSelectedOption.QID == 172 && self.qestionData.qid == 75 {
                        print("testing")
                    }
                    else {
                        self.selectedAnswerOption = []
                    }
                }
                
                if response.AddsFlag == 0 {
                    self.bottomAdsView.isHidden = true
                }
                else{
                    self.bottomAdsView.isHidden = false
                    self.googleBannerAds.loadAdsWithShortHeight(view: self.bottomAdsView)
                }
                
                self.setupQuestion()
            }
        }
        else{
            GetQuestionVM.getQuestionList(basicQuestion: false, request: GetQuestionRequest(user: AppModel.shared.currentUser.userdata?.id, lng: AppModel.shared.currentUser.userdata?.defaultLanguage, QID: selectedQid, TID: selectedTid, SelectedOptions: selectedAnswerOption)) { (response) in
                print(response)
                self.qestionData = response.data ?? QuestionModel()
                self.setupQuestion()
                
                if response.AddsFlag == 0 {
                    self.bottomAdsView.isHidden = true
                }
                else{
                    self.bottomAdsView.isHidden = false
                    self.googleBannerAds.loadAdsWithShortHeight(view: self.bottomAdsView)
                }
            }
        }
    }
    
    func setupQuestion() {
        multipleSelectionNextBtn.isHidden = true
        selectMoreOptionBackView.isHidden = true
        pickerBackView.isHidden = true
        tblView.isHidden = false
        
        questionLbl.text = ""
        
        if qestionData.question != "" {
            if qestionData.optionType == "option" {
                tblView.isHidden = false
                questionLbl.text = qestionData.question
                
                selectedIndex = -1
                setupTblViewheight()
            }
            else if qestionData.optionType == "Intro" {
                let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "MessageIntroVC") as! MessageIntroVC
                vc.qestionData = qestionData
                vc.isFromIntro = true
                vc.selectedAnswerOption = self.selectedAnswerOption
                self.navigationController?.pushViewController(vc, animated: false)
                
                selectedIndex = -1
                setupTblViewheight()
            }
            else if qestionData.optionType == "multi select" {
                tblView.isHidden = false
                questionLbl.text = qestionData.question
                
                selectedMultipleAnswerOption = [IdRequest]()
                multipleSelectionNextBtn.isHidden = true
                selectMoreOptionBackView.isHidden = false
                setupTblViewheight()
            }
            else{
                pickerBackView.isHidden = false
                tblView.isHidden = true
                
                questionLbl.text = qestionData.question
                selectedIndex = -1
                setupPickerView()
                delay(0.5) {
                    self.setupPickerView()
                }
            }
        }
    }
    
    func setupPickerView() {
        SmoothPickerConfiguration.setSelectionStyle(selectionStyle: .scale)
        for _ in 0..<qestionData.options.count - 1 {
            i += 5
            let view = viewss(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
            views.append(view)
        }
        //pickerView.firstselectedItem  = 4
        pickerView.reloadData()
    }
    
    //MARK: - Button Click
    @IBAction func clickToCancel(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func clickToNext(_ sender: Any) {
        selectedIndex = pickerView.currentSelectedIndex //indexPath.row
        tblView.reloadData()
        
        delay(0.2) {
            if self.qestionData.options[self.selectedIndex].dest {
                print("******** destinartion *********")
                //dest code
                
                var dict: SelectedOption = SelectedOption()
                dict.ID = self.qestionData.options[self.selectedIndex].id
                dict.QID = self.qestionData.qid
                
                if self.qestionData.options[self.selectedIndex].refType == "" {
                    let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "IntroResultVC") as! IntroResultVC
                    vc.selectedTid = self.qestionData.tid
                    vc.selectedMsgId = self.qestionData.options[self.selectedIndex].nextRef
                    vc.selectedRefType = self.qestionData.options[self.selectedIndex].refType
                    vc.selectedAnswerOption = self.selectedAnswerOption
                    vc.currentSelectedOption = dict
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if self.qestionData.options[self.selectedIndex].refType == "Diagnostic Result"{
                    let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "DetailResultVC") as! DetailResultVC
                    vc.selectedTid = self.qestionData.tid
                    vc.selectedMsgId = "\(self.qestionData.options[self.selectedIndex].nextRef)"
                    vc.selectedRefType = self.qestionData.options[self.selectedIndex].refType
                    self.selectedAnswerOption.append(dict)
                    vc.selectedAnswerOption = self.selectedAnswerOption
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                var dict: SelectedOption = SelectedOption()
                dict.ID = self.qestionData.options[self.selectedIndex].id
                dict.QID = self.qestionData.qid
                
                let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "ChatbotQuestionVC") as! ChatbotQuestionVC
                vc.selectedTid = self.qestionData.tid
                vc.selectedQid = self.qestionData.options[self.selectedIndex].nextRef
                vc.selectedAnswerOption = self.selectedAnswerOption
                vc.currentSelectedOption = dict
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func clickToSelectAllOption(_ sender: Any) {
        if qestionData.question != "" {
            if qestionData.optionType == "multi select" {
                selectedMultipleAnswerOption = [IdRequest]()
                for item in self.qestionData.options {
                    if item.option != "None of the above" {
                        var dict: IdRequest = IdRequest()
                        dict.id = item.id
                        self.selectedMultipleAnswerOption.append(dict)
                    }
                }
                
                if selectedMultipleAnswerOption.count == 0 {
                    multipleSelectionNextBtn.isHidden = true
                }
                else{
                    multipleSelectionNextBtn.isHidden = false
                }
                
                tblView.reloadData()
            }
        }
    }
    
    @IBAction func clickToMultipleSelectAnswer(_ sender: Any) {
        if selectedMultipleAnswerOption.count != 0 {
            var dict : SelectedOption = SelectedOption()
            dict.QID = self.qestionData.qid
            dict.data = selectedMultipleAnswerOption
            
            if self.qestionData.options[0].dest {
                print("******** destinartion *********")
                let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "IntroResultVC") as! IntroResultVC
                vc.selectedTid = self.qestionData.tid
                vc.selectedMsgId = self.qestionData.options[0].nextRef
                vc.selectedRefType = self.qestionData.options[0].refType
                vc.selectedAnswerOption = self.selectedAnswerOption
                vc.currentSelectedOption = dict
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "ChatbotQuestionVC") as! ChatbotQuestionVC
                vc.selectedTid = self.qestionData.tid
                vc.selectedQid = self.qestionData.options[0].nextRef
                vc.selectedAnswerOption = self.selectedAnswerOption
                vc.currentSelectedOption = dict
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func clickToTouchGifView(_ sender: Any) {
        tutorialBackView.isHidden = true
    }
    
}

//MARK: - TableView DataSource and Delegate Methods
extension ChatbotQuestionVC: UITableViewDataSource, UITableViewDelegate {
    
    func registerTableViewXib() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.AnswerTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.AnswerTVC.rawValue)
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qestionData.optionType != "Intro" ? qestionData.options.count : 0
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.AnswerTVC.rawValue, for: indexPath) as? AnswerTVC else { return UITableViewCell() }
        
        cell.answerLbl.text = qestionData.options[indexPath.row].option
        
        if qestionData.optionType == "multi select" {
            let index = selectedMultipleAnswerOption.firstIndex { (data) -> Bool in
                data.id == qestionData.options[indexPath.row].id
            }
            if index != nil {
                cell.backView.backgroundColor = AppColor
                cell.answerLbl.textColor = WhiteColor
            }
            else{
                cell.backView.backgroundColor = WhiteColor
                cell.answerLbl.textColor = DarkTextColor
            }
        }
        else{
            if selectedIndex == indexPath.row {
                cell.backView.backgroundColor = AppColor
                cell.answerLbl.textColor = WhiteColor
            }
            else{
                cell.backView.backgroundColor = WhiteColor
                cell.answerLbl.textColor = DarkTextColor
            }
        }
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tblView.reloadData()
        
        if qestionData.optionType == "multi select" {
            if qestionData.options[indexPath.row].option == "None of the above" {
                selectedMultipleAnswerOption = [IdRequest]()
                
                var dict: IdRequest = IdRequest()
                dict.id = self.qestionData.options[indexPath.row].id
                self.selectedMultipleAnswerOption.append(dict)
                
                if selectedMultipleAnswerOption.count == 0 {
                    multipleSelectionNextBtn.isHidden = true
                }
                else{
                    multipleSelectionNextBtn.isHidden = false
                }
                
                tblView.reloadData()
            }
            else {
                if selectedMultipleAnswerOption.count == 1 {
                    if qestionData.options.last!.option == "None of the above" {
                        if selectedMultipleAnswerOption.first?.id == qestionData.options.last!.id {
                            selectedMultipleAnswerOption = [IdRequest]()
                        }
                    }
                }
                
                let index1 = selectedMultipleAnswerOption.firstIndex { (data) -> Bool in
                    data.id == qestionData.options[indexPath.row].id
                }
                if index1 != nil {
                    self.selectedMultipleAnswerOption.remove(at: index1!)
                }
                else{
                    var dict: IdRequest = IdRequest()
                    dict.id = self.qestionData.options[indexPath.row].id
                    self.selectedMultipleAnswerOption.append(dict)
                }
                
                if selectedMultipleAnswerOption.count == 0 {
                    multipleSelectionNextBtn.isHidden = true
                }
                else{
                    multipleSelectionNextBtn.isHidden = false
                }
                
                tblView.reloadData()
            }
        }
        else {
            delay(0.2) {
                if self.qestionData.options[indexPath.row].dest {
                    print("******************* destination ********************")
                    
                    var dict: SelectedOption = SelectedOption()
                    dict.ID = self.qestionData.options[indexPath.row].id
                    dict.QID = self.qestionData.qid
                    
                    if self.qestionData.options[indexPath.row].refType == "" {
                        let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "IntroResultVC") as! IntroResultVC
                        vc.selectedTid = self.qestionData.tid
                        vc.selectedMsgId = self.qestionData.options[indexPath.row].nextRef
                        vc.selectedRefType = self.qestionData.options[indexPath.row].refType
                        vc.selectedAnswerOption = self.selectedAnswerOption
                        vc.currentSelectedOption = dict
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else if self.qestionData.options[indexPath.row].refType == "Diagnostic Result"{
                        let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "DetailResultVC") as! DetailResultVC
                        vc.selectedTid = self.qestionData.tid
                        vc.selectedMsgId = "\(self.qestionData.options[indexPath.row].nextRef)"
                        vc.selectedRefType = self.qestionData.options[indexPath.row].refType
                        self.selectedAnswerOption.append(dict)
                        vc.selectedAnswerOption = self.selectedAnswerOption
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                else{
                    var dict: SelectedOption = SelectedOption()
                    dict.ID = self.qestionData.options[indexPath.row].id
                    dict.QID = self.qestionData.qid
                    
                    let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "ChatbotQuestionVC") as! ChatbotQuestionVC
                    vc.selectedTid = self.qestionData.tid
                    vc.selectedQid = self.qestionData.options[indexPath.row].nextRef
                    vc.selectedAnswerOption = self.selectedAnswerOption
                    vc.currentSelectedOption = dict
                    self.navigationController?.pushViewController(vc, animated: true)
                }
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


extension ChatbotQuestionVC: SmoothPickerViewDelegate, SmoothPickerViewDataSource {
    func numberOfItems(pickerView: SmoothPickerView) -> Int {
        return qestionData.options.count
    }

    func itemForIndex(index: Int, pickerView: SmoothPickerView) -> UIView {
        if qestionData.options.count != 0 {
            let itemView = CustomizeYourGiftSliderItemView(frame: CGRect(x: 0, y: 0, width: 60, height: 10))
            itemView.setData(value:"\(qestionData.options[index].option)")
            return itemView
        }
        return UIView()
    }

    func didSelectItem(index: Int, view: UIView, pickerView: SmoothPickerView) {
        print("SelectedIndex \(index)")
    }    
}
