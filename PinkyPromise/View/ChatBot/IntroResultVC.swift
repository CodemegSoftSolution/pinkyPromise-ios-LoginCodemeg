//
//  IntroResultVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 07/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class IntroResultVC: UIViewController, UITextViewDelegate {

//    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var answerTxtView: UITextView!
    @IBOutlet weak var answerTxtViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var moreBtn: Button!
    
    private var GetDiagnosticResultVM: GetDiagnosticResultViewModel = GetDiagnosticResultViewModel()
    var GetQuestionVM: GetQuestionViewModel = GetQuestionViewModel()
    var resultData: DiagnosticResultModel!
    var resultData1: DiagnosticChatRoom1ResultModel!
    
    var selectedTid : Int = Int()
    var selectedMsgId : Int = Int()
    var selectedRefType : String = String()
    var selectedAnswerOption: [SelectedOption] = [SelectedOption]()
    
    var currentSelectedOption: SelectedOption = SelectedOption()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }

    func configUI() {        
        setviceCallToGetIntroData()
    }
    
    func setviceCallToGetIntroData() {
        if currentSelectedOption.ID != 0 && currentSelectedOption.ID != nil {
            selectedAnswerOption.append(currentSelectedOption)
        }
        
        let request = GetDiagnosticRequest(lng: AppModel.shared.currentUser.userdata?.defaultLanguage, RefType: self.selectedRefType, MsgId: "\(selectedMsgId)", TID: self.selectedTid, SelectedOptions: self.selectedAnswerOption, user: AppModel.shared.currentUser.userdata?.id)
        
        if self.selectedTid == 1 || self.selectedTid == 2 || self.selectedTid == 4 {
            self.GetDiagnosticResultVM.getDiagnosticResult(request: request) { (response) in
                print(response)
                if response.data != nil {
                    self.resultData = response.data
                    self.setUpIntroData()
                }
            }
        }
        else {
            var request1 = GetDiagnosticRequest(lng: AppModel.shared.currentUser.userdata?.defaultLanguage, RefType: self.selectedRefType, MsgId: "\(selectedMsgId)", TID: self.selectedTid, SelectedOptions: self.selectedAnswerOption , user: AppModel.shared.currentUser.userdata?.id)
            
            if self.selectedMsgId == 39 {
                request1.SelectedOptions = []
            }
            
            self.GetDiagnosticResultVM.getDiagnosticResultForCharBot1(request: request1) { (response) in
                print(response)
                if response.data != nil {
                    self.resultData1 = response.data
                    
                    if self.selectedTid != 3 && self.selectedTid != 7  {
                        self.selectedAnswerOption = []
                    }
                    
                    if !(response.data?.DiagnosisResponse ?? true) {
                        let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "ChatbotQuestionVC") as! ChatbotQuestionVC
                        vc.selectedTid = self.selectedTid
                        vc.selectedQid = response.data!.qid
                        vc.selectedAnswerOption = self.selectedAnswerOption
                        vc.isFromIntroResultForRemoveViewController = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else{
                        self.setUpIntroData()
                    }
                }
            }
        }
    }
    
    func setUpIntroData() {
        if resultData != nil {
            
            let textview = UITextView()
            textview.font = UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)
            textview.attributedText = resultData?.message.html2AttributedString
            textview.sizeToFit()
//            let actualsize = textview.sizeThatFits(CGSize(width: SCREEN.WIDTH - 40, height: CGFloat.greatestFiniteMagnitude))
            
            answerTxtView.attributedText = resultData?.message.html2AttributedString
            answerTxtView.font = UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)
               
            let attributedStringToMeasure = NSAttributedString(string: textview.text, attributes: [
                                                                NSAttributedString.Key.font: UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)])
            let placeholderTextView = UITextView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH - 30, height: 10))
            placeholderTextView.attributedText = attributedStringToMeasure
            let size: CGSize = placeholderTextView.sizeThatFits(CGSize(width: SCREEN.WIDTH - 30, height: CGFloat.greatestFiniteMagnitude))

            print(size.height)
            
            var totalHeight = Int()
            if resultData?.nextRef == "-1" {
                moreBtn.isHidden = true
                totalHeight = 270
            }
            else{
                moreBtn.isHidden = false
                totalHeight = 330
            }
            
            if SCREEN.HEIGHT - CGFloat(totalHeight) > self.answerTxtView.contentSize.height {
                answerTxtViewHeightConstraint.constant = /*self.answerTxtView.contentSize.height*/size.height + 15
            }
            else{
                answerTxtViewHeightConstraint.constant = SCREEN.HEIGHT - CGFloat(totalHeight)
            }            
        }
        else if resultData1 != nil {
            let textview = UITextView()
            textview.font = UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)
            textview.attributedText = resultData1?.message.html2AttributedString
            textview.sizeToFit()
            let actualsize = textview.sizeThatFits(CGSize(width: SCREEN.WIDTH - 40, height: CGFloat.greatestFiniteMagnitude))
            
            let attributedStringToMeasure = NSAttributedString(string: textview.text, attributes: [
                                                                NSAttributedString.Key.font: UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)])
            let placeholderTextView = UITextView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH - 30, height: 10))
            placeholderTextView.attributedText = attributedStringToMeasure
            let size: CGSize = placeholderTextView.sizeThatFits(CGSize(width: SCREEN.WIDTH - 30, height: CGFloat.greatestFiniteMagnitude))
            
            answerTxtView.attributedText = resultData1?.message.html2AttributedString
            answerTxtView.font = UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)
            
            var totalHeight = Int()
            if resultData1?.nextRef == -1 {
                moreBtn.isHidden = true
                totalHeight = 270
            }
            else{
                moreBtn.isHidden = false
                totalHeight = 330
            }
            
            if SCREEN.HEIGHT - CGFloat(totalHeight) > self.answerTxtView.contentSize.height {
                answerTxtViewHeightConstraint.constant = /*self.answerTxtView.contentSize.height*/ size.height + 15
            }
            else{
                answerTxtViewHeightConstraint.constant = SCREEN.HEIGHT - CGFloat(totalHeight)
            }
            
        }
    }
    
    private func heightForString(_ str : NSAttributedString, width : CGFloat) -> CGFloat {
        let ts = NSTextStorage(attributedString: str)

        let size = CGSize(width:width, height:CGFloat.greatestFiniteMagnitude)

        let tc = NSTextContainer(size: size)
        tc.lineFragmentPadding = 0.0

        let lm = NSLayoutManager()
        lm.addTextContainer(tc)

        ts.addLayoutManager(lm)
        lm.glyphRange(forBoundingRect: CGRect(origin: .zero, size: size), in: tc)

        let rect = lm.usedRect(for: tc)

        return rect.integral.size.height
    }
    
    //MARK: - Button Click
    @IBAction func clickToCancel(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func clickToTellMeMore(_ sender: Any) {
        if resultData != nil {
            if resultData.nextRef != "-1" {
                if resultData.refType == "" {
                    let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "ChatbotQuestionVC") as! ChatbotQuestionVC
                    vc.selectedTid = resultData.tid
                    vc.selectedQid = Int(resultData.nextRef)!
                    vc.selectedAnswerOption = selectedAnswerOption
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "DetailResultVC") as! DetailResultVC
                    vc.selectedTid = self.resultData.tid
                    vc.selectedMsgId = "\(self.resultData.nextRef)"
                    vc.selectedRefType = resultData.refType
                    vc.selectedAnswerOption = self.selectedAnswerOption
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        else if resultData1 != nil {
            if resultData1.nextRef != -1 {
                if resultData1.refType == "" {
                    let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "ChatbotQuestionVC") as! ChatbotQuestionVC
                    vc.selectedTid = resultData1.tid
                    vc.selectedQid = resultData1.nextRef
                    vc.selectedAnswerOption = selectedAnswerOption
                    vc.isQidIsNextRef = true // this is only for tid : 7
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if resultData1.refType == "diagnosis" {
                    let request = GetDiagnosticRequest(lng: AppModel.shared.currentUser.userdata?.defaultLanguage, RefType: resultData1.refType, MsgId: "\(self.resultData1.nextRef)", TID: self.resultData1.tid, SelectedOptions: []/*self.selectedAnswerOption*/, user: AppModel.shared.currentUser.userdata?.id)
                    
                    self.GetDiagnosticResultVM.getDiagnosticResultForCharBot1(request: request) { (response) in
                        print(response)
                        if response.data != nil {
                            self.resultData1 = response.data
                            self.setUpIntroData()
                        }
                    }
                }
                else if resultData1.diagnosis2 {
                    let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "DetailResultVC") as! DetailResultVC
                    vc.selectedTid = self.resultData1.tid
                    vc.selectedMsgId = "\(self.resultData1.nextRef)"
                    vc.selectedRefType = resultData1.refType
                    vc.selectedAnswerOption = []
                    vc.isTypeDiagnoses = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "DetailResultVC") as! DetailResultVC
                    vc.selectedTid = self.resultData1.tid
                    vc.selectedMsgId = "\(self.resultData1.nextRef)"
                    vc.selectedRefType = resultData1.refType
                    vc.selectedAnswerOption = self.selectedAnswerOption
                    vc.isTypeDiagnoses = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
