//
//  LogPeriodVC.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 16/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit
import FSCalendar
import HorizonCalendar
import CoreData

class LogPeriodVC: UIViewController {
    var yRef:CGFloat = 44
    var strKG:String = ""
    var calendar: FSCalendar!
    var selectedDay: Day?
    var sizeOfDate:CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        sizeOfDate = (screenWidth/7)-14
        
        self.screenDesigning()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        AppDelegate().sharedDelegate().hideTabBar()
    }

    func screenDesigning() {
        let btnBack:UIButton = UIButton()
        btnBack.frame = CGRect(x: 10, y: yRef-5, width: 30, height: 30)
        btnBack.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack)

        let lblTrack:UILabel = UILabel()
        lblTrack.frame = CGRect(x: 45, y: yRef, width: 80, height: 20)
        lblTrack.textColor = UIColor.black
        lblTrack.text = "Track"
        lblTrack.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        lblTrack.textAlignment = .left
        lblTrack.clipsToBounds = true
        self.view.addSubview(lblTrack)

        let btnBack2:UIButton = UIButton()
        btnBack2.frame = CGRect(x: 10, y: yRef-5, width: 120, height: 30)
        btnBack.backgroundColor = UIColor.clear
        btnBack2.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack2)

        let lblTitleMonth:UILabel = UILabel()
        lblTitleMonth.frame = CGRect(x: (screenWidth-90)/2, y: yRef, width: 90, height: 20)
        lblTitleMonth.textColor = UIColor.black
        lblTitleMonth.text = "November"
        lblTitleMonth.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        lblTitleMonth.textAlignment = .center
        lblTitleMonth.clipsToBounds = true
        self.view.addSubview(lblTitleMonth)

        let lblTitleYear:UILabel = UILabel()
        lblTitleYear.frame = CGRect(x: screenWidth-95, y: yRef, width: 80, height: 20)
        lblTitleYear.textColor = UIColor.black
        lblTitleYear.text = "2022"
        lblTitleYear.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        lblTitleYear.textAlignment = .right
        lblTitleYear.clipsToBounds = true
        self.view.addSubview(lblTitleYear)

        yRef = yRef+lblTitleYear.frame.size.height+20
        
        let lblCircleOvulation:UILabel = UILabel()
        lblCircleOvulation.frame = CGRect(x: 15, y: yRef, width: 12, height: 12)
        lblCircleOvulation.backgroundColor = ColorPink
        lblCircleOvulation.layer.cornerRadius = 6
        lblCircleOvulation.clipsToBounds = true
        self.view.addSubview(lblCircleOvulation)
        
        let lblOvulation:UILabel = UILabel()
        lblOvulation.frame = CGRect(x: 33, y: yRef-4, width: 90, height: 20)
        lblOvulation.textColor = UIColor.black
        lblOvulation.text = "Ovulation"
        lblOvulation.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14)
        lblOvulation.textAlignment = .left
        lblOvulation.clipsToBounds = true
        self.view.addSubview(lblOvulation)

        let lblCirclePeriod:UILabel = UILabel()
        lblCirclePeriod.frame = CGRect(x: 135, y: yRef, width: 12, height: 12)
        lblCirclePeriod.backgroundColor = UIColor.red
        lblCirclePeriod.layer.cornerRadius = 6
        lblCirclePeriod.clipsToBounds = true
        self.view.addSubview(lblCirclePeriod)
        
        let lblPeriod:UILabel = UILabel()
        lblPeriod.frame = CGRect(x: 153, y: yRef-4, width: 90, height: 20)
        lblPeriod.textColor = UIColor.black
        lblPeriod.text = "Period"
        lblPeriod.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14)
        lblPeriod.textAlignment = .left
        lblPeriod.clipsToBounds = true
        self.view.addSubview(lblPeriod)

        yRef = yRef+lblOvulation.frame.size.height+20

//        let calendar = FSCalendar(frame: CGRect(x: (screenWidth-320)/2, y: yRef, width: 320, height: 300))
//        calendar.dataSource = self
//        calendar.delegate = self
//        calendar.scrollDirection = .vertical
//        calendar.appearance.selectionColor = ColorPink
//        calendar.appearance.subtitleSelectionColor = UIColor.purple
//        calendar.appearance.headerTitleColor = UIColor.black
//        calendar.appearance.weekdayTextColor = ColorPink
//        calendar.allowsMultipleSelection = true
//        view.addSubview(calendar)
//        self.calendar = calendar

        let calenderV: CalendarView = CalendarView(initialContent: self.makeContent())
        calenderV.frame = CGRect(x: 20, y: 100, width: screenWidth-40, height: screenHeight-(85+yRef))
        calenderV.backgroundColor = UIColor.white
        self.view.addSubview(calenderV)
        
        calenderV.daySelectionHandler = { [weak self] day in
            guard let self = self else { return }
            self.selectedDay = day
            let newContent = self.makeContent()
            calenderV.setContent(newContent)
        }

        //self.multipleselectedDates()
        
        let viewBottom = UIView()
        viewBottom.frame = CGRect(x: -10, y: screenHeight-85, width: screenWidth+20, height: 85)
        viewBottom.backgroundColor = UIColor.white
        viewBottom.layer.cornerRadius = 25
        viewBottom.clipsToBounds = true
        viewBottom.layer.shadowOffset = CGSize(width: 2, height: 3)
        viewBottom.layer.shadowOpacity = 0.5
        viewBottom.layer.shadowRadius = 7
        viewBottom.layer.shadowColor = UIColor.lightGray.cgColor
        viewBottom.layer.masksToBounds = false
        self.view.addSubview(viewBottom)
        
        let btnCancel = UIButton()
        btnCancel.frame = CGRect(x: 15, y: 10, width: 80, height: 30)
        btnCancel.backgroundColor = UIColor.clear
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(ColorPink, for: .normal)
        btnCancel.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        viewBottom.addSubview(btnCancel)
        
        let btnSave = UIButton()
        btnSave.frame = CGRect(x: viewBottom.frame.self.width-100, y: 10, width: 80, height: 30)
        btnSave.backgroundColor = UIColor.clear
        btnSave.setTitle("Save", for: .normal)
        btnSave.setTitleColor(ColorPink, for: .normal)
        btnSave.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16)
        viewBottom.addSubview(btnSave)

    }
    //MARK: Horizontal Calender designing
    
    func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!
        
        let lowerDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 20))!
        let upperDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 26))!
        
        let lowerCircleDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 05))!
        let upperCircleDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 06))!
        
        let lowerComponant = getDateComponent(lowerCircleDate)
        let dayOfLower = lowerComponant.day
        
        let upperComponant = getDateComponent(upperCircleDate)
        let dayOfupper = upperComponant.day
        
        let dateRangeToHighlight = lowerDate...upperDate
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
        .interMonthSpacing(24)
        .verticalDayMargin(8)
        .horizontalDayMargin(8)
        
        .dayRangeItemProvider(for: [dateRangeToHighlight]) { dayRangeLayoutContext in
            
            CalendarItemModel<DayRangeIndicatorView>(invariantViewProperties: .init(), viewModel: .init(framesOfDaysToHighlight: dayRangeLayoutContext.daysAndFrames.map { $0.frame }))
        }
        .dayItemProvider { day in
            var invariantViewProperties = DayLabel.InvariantViewProperties(font: UIFont.systemFont(ofSize: 18), textColor: UIColor.black, backgroundColor: .clear, cornerRadius: 12, borderWidth: 0, borderColor: .clear, shadowColor: .clear)
            
            if day == self.selectedDay {
                invariantViewProperties.textColor = .white
                invariantViewProperties.backgroundColor = UIColor.init(red: 255/255.0, green: 142/255.0, blue: 140/255.0, alpha: 1)
                invariantViewProperties.shadowColor = UIColor.clear
            }
            if day.components.day == dayOfLower {
                invariantViewProperties.textColor = .black
                invariantViewProperties.backgroundColor = .clear
                invariantViewProperties.borderWidth = 2
                invariantViewProperties.borderColor = .black
                invariantViewProperties.cornerRadius = self.sizeOfDate/2
            }
            
            if day.components.day == dayOfupper {
                invariantViewProperties.textColor = .black
                invariantViewProperties.backgroundColor = .clear
                invariantViewProperties.borderWidth = 2
                invariantViewProperties.borderColor = .black
                invariantViewProperties.cornerRadius = self.sizeOfDate/2
            }
            
            return CalendarItemModel<DayLabel>(
                invariantViewProperties: invariantViewProperties,
                viewModel: .init(day: day))
            
        }
        
    }
    func getDateComponent(_ circledate: Date) -> DateComponents {
        let calendar2 = Calendar.current
        let components = calendar2.dateComponents([.day], from: circledate)
        return components
    }

    //MARK: Action
    
    @objc func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func multipleselectedBorderDates() {
        let todate: Date = getrangedate("05-01-2022")
        let fromdate: Date = getrangedate("05-04-2022")
        var dateRange: [Date]?
        dateRange = datesRange(from: fromdate, to: todate)
        
        for i in 0..<dateRange!.count {
            let firsdate: Date = dateRange![i]
            calendar.select(firsdate)
        }
    }

    func multipleselectedDates() {
        let fromdate: Date = getrangedate("05-10-2022")
        let todate: Date = getrangedate("05-15-2022")
        var dateRange: [Date]?
        dateRange = datesRange(from: fromdate, to: todate)
        
        for i in 0..<dateRange!.count {
            let firsdate: Date = dateRange![i]
            calendar.select(firsdate)
            //calendar.appearance.borderSelectionColor = UIColor.black
        }
    }
    func getrangedate(_ strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date: NSDate? = dateFormatter.date(from: strDate) as NSDate?
        return date! as Date
    }
    func togetrangedate(_ strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date: NSDate? = dateFormatter.date(from: strDate) as NSDate?
        return date! as Date
    }

    public func performDateSelection(_ calendar: FSCalendar) {
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
extension LogPeriodVC: FSCalendarDelegate, FSCalendarDataSource {
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

}
