//
//  PeriodsVC.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 16/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit
import FSCalendar

protocol PeriodProtocol {
    func period(_ periodDate: Date)
}

class PeriodsVC: UIViewController {

    var yRef:CGFloat = 44
    var strKG:String = ""
    var calendar: FSCalendar!
    
    var strDateOfBirth: String = ""
    var strNickName: String = ""
    var strSelectedGender: String = ""
    var strWeight: String = ""
    var strHeight: String = ""
    var strPeriodDate: String = ""
    var selectedDate: Date!
    var strHeightUnit:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.screenDesigning()

    }
    
    func screenDesigning() {
        
        let barprogress:UIProgressView = UIProgressView()
        barprogress.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 20)
        barprogress.tintColor = ColorPink
        barprogress.progress = 0.71
        barprogress.trackTintColor = ColorLightGray//ColorPink
        barprogress.clipsToBounds = true
        self.view.addSubview(barprogress)
        
        yRef = yRef+barprogress.frame.size.height + 15
        
        let lblSteps:UILabel = UILabel()
        lblSteps.frame = CGRect(x: 20, y: yRef, width: 200, height: 30)
        lblSteps.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
        lblSteps.textColor = PrimeryPink
        lblSteps.text = "STEP 5/7"
        self.view.addSubview(lblSteps)
        
        yRef = yRef+lblSteps.frame.size.height + 10

        let btnBack:UIButton = UIButton()
        btnBack.frame = CGRect(x: 5, y: yRef-10, width: 40, height: 40)
        btnBack.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack)
        
        yRef = yRef+btnBack.frame.size.height-5

        let lblLastPeriodText:UILabel = UILabel()
        lblLastPeriodText.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 30)
        lblLastPeriodText.textColor = UIColor.init(red: 87/255.0, green: 89/255.0, blue: 92/255.0, alpha: 1)
        lblLastPeriodText.text = "When did you last get your periods?"
        lblLastPeriodText.font = UIFont.init(name: FONT.Kurale.rawValue, size: 28)
        lblLastPeriodText.textAlignment = .left
        lblLastPeriodText.clipsToBounds = true
        lblLastPeriodText.numberOfLines = 0
        lblLastPeriodText.lineBreakMode = .byWordWrapping
        lblLastPeriodText.sizeToFit()
        self.view.addSubview(lblLastPeriodText)

        yRef = yRef+lblLastPeriodText.frame.size.height + 10
        
        let lblChooseDateText:UILabel = UILabel()
        lblChooseDateText.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 30)
        lblChooseDateText.backgroundColor = UIColor.clear
        lblChooseDateText.font = UIFont.init(name: FONT.Playfair.rawValue, size: 16.0)
        lblChooseDateText.text = "Please choose the first day of your bleeding!"
        lblChooseDateText.textAlignment = .left
        lblChooseDateText.textColor = ColorPink
        lblChooseDateText.clipsToBounds = true
        self.view.addSubview(lblChooseDateText)

        yRef = yRef+lblChooseDateText.frame.size.height + 20

        let calendar = FSCalendar(frame: CGRect(x: (screenWidth-320)/2, y: yRef, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.selectionColor = ColorPink
        calendar.appearance.todaySelectionColor = ColorPink
        //calendar.appearance.borderSelectionColor = UIColor.black
        calendar.appearance.headerTitleColor = UIColor.black
        calendar.appearance.titleDefaultColor = ColorGrayText
        calendar.appearance.weekdayTextColor = ColorPink
        calendar.scrollDirection = .vertical
        calendar.allowsSelection = true
        view.addSubview(calendar)
        self.calendar = calendar
        
        let btnConfirm:UIButton = UIButton()
        btnConfirm.frame = CGRect(x: 20, y: screenHeight-90, width: screenWidth-40, height: 40)
        btnConfirm.backgroundColor = ColorPink
        btnConfirm.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        btnConfirm.setTitle("Next", for: .normal)
        btnConfirm.setTitleColor(UIColor.white, for: .normal)
        btnConfirm.layer.cornerRadius = 20
        btnConfirm.clipsToBounds = true
        btnConfirm.addTarget(self, action: #selector(self.btnConfirmClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnConfirm)
        
        self.dateString(DateToday: Date())
     }
    
    func dateString(DateToday: Date) {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        strPeriodDate = dateFormatter1.string(from: DateToday)
        print(strPeriodDate)

    }
    func stringToDate(_ strDate: String) -> Date {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter1.date(from: strDate)!
        return selectedDate
    }

    //MARK: Action
    func multipleselectedDates() {
        let fromdate: Date = getrangedate("2022-05-10 12:24:26")
        let todate: Date = getrangedate("2022-05-15 12:24:26")
        var dateRange: [Date]?
        dateRange = datesRange(from: fromdate, to: todate)
        
        for i in 0..<dateRange!.count {
            let firsdate: Date = dateRange![i]
            calendar.select(firsdate)
        }
    }
    func getrangedate(_ strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        let date: Date? = dateFormatter.date(from: strDate) as Date?
        return date!
    }
    @objc func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btnConfirmClicked(_ sender: UIButton) {
        if strPeriodDate.isEmpty == true {
            displayToast(getTranslate("period_date"))
        } else {
            let vc: DuringOfPeriodVC = DuringOfPeriodVC()
            vc.strNickName = strNickName
            vc.strDateOfBirth = strDateOfBirth
            vc.strSelectedGender = strSelectedGender
            vc.strWeight = strWeight
            vc.strHeight = strHeight
            vc.strPeriodDate = strPeriodDate
            vc.selectedDate = selectedDate
            vc.strHeightUnit = strHeightUnit
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    private func performDateSelection(_ calendar: FSCalendar) {
        let sorted = calendar.selectedDates.sorted { $0 < $1 }
        if let firstDate = sorted.first, let lastDate = sorted.last {
            let ranges = datesRange(from: firstDate, to: lastDate)
            calendar.select(ranges)
        }
    }

    func datesRange(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }
        var tempDate = from
        var array = [tempDate]
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
}
extension PeriodsVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
            // Do other updates
        }
        self.view.layoutIfNeeded()
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if date .compare(Date()) == .orderedAscending {
            return true
        }
        else {
            return false
        }
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.dateString(DateToday: date)
    }
}
