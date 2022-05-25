//
//  MessageIntroVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 06/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

extension MessageIntroVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

class MessageIntroVC: UIViewController {

    @IBOutlet weak var introMessageLbl: UILabel!
    @IBOutlet weak var okayBtn: Button!
    
    var GetQuestionVM: GetQuestionViewModel = GetQuestionViewModel()
    var GetDiagnosticResultVM: GetDiagnosticResultViewModel = GetDiagnosticResultViewModel()
    var selectedIndex: Int = 0
    var topicDetail: TopicModel!
    var qestionData: QuestionModel = QuestionModel()
    var isFromIntro: Bool = false
    var selectedAnswerOption: [SelectedOption] = [SelectedOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }

    func configUI() {
        introMessageLbl.text = ""
        setUpIntroData()
    }
    
    func setUpIntroData() {
        if isFromIntro {
            introMessageLbl.attributedText = qestionData.question.html2AttributedString
            introMessageLbl.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
            introMessageLbl.textAlignment = .center
            introMessageLbl.textColor = DarkTextColor
            
            okayBtn.setTitle(qestionData.options.first?.option, for: .normal)
            
            guard let navigationController = self.navigationController else { return }
            var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
            navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
            self.navigationController?.viewControllers = navigationArray
        }
        else{
            introMessageLbl.attributedText = topicDetail.introMessages[selectedIndex].message.html2AttributedString
            introMessageLbl.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
            introMessageLbl.textAlignment = .center
            introMessageLbl.textColor = DarkTextColor
            
            okayBtn.setTitle(topicDetail.introMessages[selectedIndex].response, for: .normal)
        }
    }
    
    //MARK: - Button Click
    @IBAction func clickToCancel(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func clickToOkay(_ sender: Any) {
        if isFromIntro {
            if qestionData.options.count == 0 {
                return
            }
            if self.qestionData.options.first!.dest {
                print("******************* destination ********************")
                
                let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "IntroResultVC") as! IntroResultVC
                vc.selectedTid = self.qestionData.tid
                vc.selectedMsgId = self.qestionData.options.first!.nextRef
                vc.selectedRefType = self.qestionData.options.first!.refType
                vc.selectedAnswerOption = self.selectedAnswerOption
                
                if self.qestionData.tid == 3 {
                    var dict: SelectedOption = SelectedOption()
                    dict.ID = self.qestionData.options.first?.id
                    dict.QID = self.qestionData.qid
                    vc.currentSelectedOption = dict
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "ChatbotQuestionVC") as! ChatbotQuestionVC
                vc.selectedTid = self.qestionData.tid
                vc.selectedQid = self.qestionData.options.first!.nextRef
                vc.isQidIsNextRef = true   // this is only for tid : 7
                vc.selectedAnswerOption = self.selectedAnswerOption
                
                if self.qestionData.tid == 3 {
                    var dict: SelectedOption = SelectedOption()
                    dict.ID = self.qestionData.options.first?.id
                    dict.QID = self.qestionData.qid
                    vc.currentSelectedOption = dict
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else{
            if topicDetail.introMessages.count == selectedIndex {
                return
            }
            selectedIndex = selectedIndex + 1
            if topicDetail.introMessages.count == selectedIndex {
                print("Done")
                
                let vc = STORYBOARD.CHATBOT.instantiateViewController(withIdentifier: "ChatbotQuestionVC") as! ChatbotQuestionVC
                vc.selectedTid = topicDetail.tid
                vc.selectedQid = topicDetail.refID
                vc.selectedAnswerOption = []
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                setUpIntroData()
            }
        }
    }
}
