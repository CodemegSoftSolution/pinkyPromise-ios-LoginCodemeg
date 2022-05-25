//
//  PeriodTrackerVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 11/04/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit
import FSCalendar

class PeriodTrackerVC: UIViewController {
    
    @IBOutlet weak var calendarBackView: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ctcleDayLbl: UILabel!
    @IBOutlet weak var periodImgView: UIImageView!
    
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var ovulationCountLbl: UILabel!
    @IBOutlet weak var periodCountLbl: UILabel!
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var lblLogPeriod: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleTap()
        configUI()
    }
    func handleTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleMaleTap(_:)))
        lblToday.addGestureRecognizer(tap)
        lblToday.isUserInteractionEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
    }
    
    func configUI() {
        //self.calendarBackView.setScope(.week, animated: true)
        calendarBackView.appearance.selectionColor = ColorPink
        calendarBackView.appearance.headerTitleColor = UIColor.black
        calendarBackView.appearance.weekdayTextColor = ColorDarkGray
        calendarBackView.appearance.titleDefaultColor = ColorGrayText
//        calendarBackView.appearance.todayColor = .red
//        calendarBackView.appearance.borderRadius = 1
//        calendarBackView.appearance.titleTodayColor = UIColor.white
        self.calendarBackView.scope = .week
    }
    
    //MARK: - Button Click
    @IBAction func clickToHeaderCalendar(_ sender: Any) {
        let vc: LogPeriodVC = LogPeriodVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToLogPeriod(_ sender: Any) {
        let vc: LogPeriodVC = LogPeriodVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToAddTrackSymtoms(_ sender: Any) {
        let vc = STORYBOARD.PERIOD_TRACKER.instantiateViewController(withIdentifier: "TrackSymtomsVC") as! TrackSymtomsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func handleMaleTap(_ sender: UITapGestureRecognizer? = nil) {
        calendarBackView.select(Date())
    }

}

extension PeriodTrackerVC: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
}
