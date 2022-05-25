//
//  DetailResultVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 07/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import Alamofire

//extension DetailResultVC: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return false
//    }
//}

class DetailResultVC: UIViewController {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var moreBtn: Button!
    @IBOutlet weak var resultBtn: Button!
    
    var finalResultData : [FinalDiagnosticModel] = [FinalDiagnosticModel]()
    var DiagnosticResulDownloadVM: DiagnosticResulDownloadViewModel = DiagnosticResulDownloadViewModel()
    
    private var GetDiagnosticResultVM: GetDiagnosticResultViewModel = GetDiagnosticResultViewModel()
    var selectedTid : Int = Int()
    var selectedMsgId : String = String()
    var selectedRefType : String = String()
    var selectedAnswerOption: [SelectedOption] = [SelectedOption]()
    
    var selectedIndex = 0
    var isTypeDiagnoses: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewWillLayoutSubviews() {
        tblView.reloadData()
    }
    
    func configUI() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.ChatbotResultTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.ChatbotResultTVC.rawValue)

        tblView.reloadData()
        serviceCallToGetFinalResult()
        DiagnosticResulDownloadVM.delegate = self
    }
    
    func serviceCallToGetFinalResult()  {
        if self.selectedTid == 1 || self.selectedTid == 2 || self.selectedTid == 4 {
            let request = GetDiagnosticRequest(lng: AppModel.shared.currentUser.userdata?.defaultLanguage, RefType: selectedRefType, MsgId: "\(self.selectedMsgId)", TID: self.selectedTid, SelectedOptions: self.selectedAnswerOption, user: AppModel.shared.currentUser.userdata?.id)
            
            self.GetDiagnosticResultVM.getDiagnosticResultForFinalResult(request: request) { (response) in
                print(response)
                if response.data.count != 0 {
                    self.finalResultData = response.data
                    self.dataRender()
                }
            }
        }
        else {
            if isTypeDiagnoses {
                let request = GetDiagnosticRequest(lng: AppModel.shared.currentUser.userdata?.defaultLanguage, RefType: selectedRefType, MsgId: "\(self.selectedMsgId)", TID: self.selectedTid, SelectedOptions: [], user: AppModel.shared.currentUser.userdata?.id)
                                    
                self.GetDiagnosticResultVM.getDiagnosticFinalDiagnosis2CharBot1(request: request) { (response) in
                    print(response)
                    if response.data.count != 0 {
                        self.finalResultData = response.data
                        self.dataRender()
                    }
                }
            }
            else{
                let request = GetDiagnosticRequest(lng: AppModel.shared.currentUser.userdata?.defaultLanguage, RefType: selectedRefType, MsgId: "\(self.selectedMsgId)", TID: self.selectedTid, SelectedOptions: self.selectedAnswerOption, user: AppModel.shared.currentUser.userdata?.id)
                
                self.GetDiagnosticResultVM.getDiagnosticResultForFinalCharBot1(request: request) { (response) in
                    print(response)
                    if response.data.count != 0 {
                        self.finalResultData = response.data
                        self.dataRender()
                    }
                }
            }
        }
    }
    
    func dataRender() {
        headerLbl.text = ""
        if finalResultData.count != 0 {
            if finalResultData[selectedIndex].name != "" {
                headerLbl.text = finalResultData[selectedIndex].name
            }
            
            if selectedIndex + 1 == finalResultData.count {
                moreBtn.isHidden = true
            }
            
            tblView.reloadData()
            
            delay(0.2) {
                self.tblView.reloadData()
            }
            
            delay(0.1) {
                self.tblView.reloadData()
            }
        }
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func clickToDownloadResult(_ sender: Any) {
        if finalResultData.count != 0 {
            var param: [String: Any] = [String: Any]()
            param["Flag"] = 1
            param["MsgId"] = finalResultData[selectedIndex].id
            param["TID"] = finalResultData[selectedIndex].tid
            DiagnosticResulDownloadVM.getDiagnosticResult(request: GetDiagnosticPdf(Flag: 1, MsgId: finalResultData[selectedIndex].id, lng: AppModel.shared.currentUser.userdata?.defaultLanguage ?? "en", TID: finalResultData[selectedIndex].tid))
        }
    }
    
    @IBAction func clickToKnowMore(_ sender: Any) {
        selectedIndex = selectedIndex + 1
        dataRender()
    }
    
}

extension DetailResultVC: DiagnosticResulDownloadDelegate {
    func didRecieveDiagnosticResulDownloadResponse(response: DiagnosisFinalPdfResponse) {
        if response.fileURL != "" {
            savePdf(urlString: response.fileURL, fileName: getCurrentTimeStampValue(), tid: finalResultData[selectedIndex].tid)
        }
    }
}

//MARK: - TableView DataSource and Delegate Methods
extension DetailResultVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalResultData.count != 0 ? finalResultData[selectedIndex].resultData.count : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.ChatbotResultTVC.rawValue, for: indexPath) as? ChatbotResultTVC else { return UITableViewCell() }
        
        cell.questionLbl.attributedText = finalResultData[selectedIndex].resultData[indexPath.row].header.html2AttributedString
        cell.questionLbl.font = UIFont.init(name: FONT.Kurale.rawValue, size: 18.0)
        cell.questionLbl.textColor = AppColor
  //      cell.ansLbl.text = finalResultData[selectedIndex].resultData[indexPath.row].info
        
        let textview = UITextView()
        textview.font = UIFont.init(name: FONT.Playfair.rawValue, size: 15.0)
        textview.attributedText = finalResultData[selectedIndex].resultData[indexPath.row].info.html2AttributedString
        textview.sizeToFit()
//        let actualsize = textview.sizeThatFits(CGSize(width: SCREEN.WIDTH - 30, height: CGFloat.greatestFiniteMagnitude))
        
        let attributedStringToMeasure = NSAttributedString(string: textview.text, attributes: [
                                                            NSAttributedString.Key.font: UIFont.init(name: FONT.Playfair.rawValue, size: 15.0)])
        let placeholderTextView = UITextView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH - 30, height: 10))
        placeholderTextView.attributedText = attributedStringToMeasure
        let size: CGSize = placeholderTextView.sizeThatFits(CGSize(width: SCREEN.WIDTH - 30, height: CGFloat.greatestFiniteMagnitude))

        print(size.height)
        
        
        let text = finalResultData[selectedIndex].resultData[indexPath.row].info.trimmed
        cell.ansTxtView.attributedText = text.html2AttributedString
        cell.ansTxtView.font = UIFont.init(name: FONT.Playfair.rawValue, size: 15.0)
        cell.textviewHeightConstraint.constant = size.height + 15
        
        return cell
    }
    
    @objc @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
       
    }
    
}
