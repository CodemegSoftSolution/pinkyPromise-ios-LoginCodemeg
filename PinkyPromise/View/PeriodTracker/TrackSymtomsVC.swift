//
//  TrackSymtomsVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 15/04/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit
import Alamofire

class TrackSymtomsVC: UIViewController {
    
    @IBOutlet weak var flowCollectionView: UICollectionView!
    @IBOutlet weak var flowCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sexCollectionView: UICollectionView!
    @IBOutlet weak var sexCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var vaginalCollectionView: UICollectionView!
    @IBOutlet weak var vaginalCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var symptomsCollectionView: UICollectionView!
    @IBOutlet weak var symptomsCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var flowArr = ["Light", "Medium", "Heavy"]
    var sexArr = ["Protected", "Unprotected"]
    var vaginalArr = ["Clear", "White", "Yellow", "Green", "Sticky", "Clumpy", "Bloody"]
    var symptomsArr = ["Stomach Ache", "Headache", "Backache", "Mood Swings", "Tender Breasts", "Nausea"]
    var trackedSymptoms = [String]()
    var addTrackedSymptoms = [String]()
    
    var allSymptoms = ["FL_LIT", "FL_MED", "FL_HVY", "SX_PR", "SX_UNPR", "VD_CLR","VD_WHT","VD_YLW","VD_GRN","VD_STK","VD_CLM","VD_BLD","OS_SAC","OS_HAC","OS_BAC","OS_MSW","OS_TNBR","OS_NAU"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        self.getSymptomsAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    func configUI() {
        registerCollectionViewCell()
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToCancel(_ sender: Any) {
        
    }
    
    @IBAction func clickToSave(_ sender: Any) {
        self.addSysmptomsAPI()
    }
    func deleteSymptoms(_ strSymptoms: String){
        for i in 0..<trackedSymptoms.count {
            let strtrack:String = trackedSymptoms[i]
            if strtrack == strSymptoms {
                trackedSymptoms.remove(at: i)
                return
            }
        }
        print(trackedSymptoms)
    }
    func updateUI(){
        for i in 0..<trackedSymptoms.count {
            let strColor:String = trackedSymptoms[i]
            print(strColor)
            for j in 0..<allSymptoms.count {
                let symptoms: String = allSymptoms[j]
                if strColor == symptoms {
                    if j == 0 {
                        let IndexP: IndexPath = IndexPath(row: j, section: 0)
                        if let cell: TrackCVC = flowCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "light")
                            cell.imgCheckMark.isHidden = false
                        }
                        flowCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 1 {
                        let IndexP: IndexPath = IndexPath(row: j, section: 0)
                        if let cell: TrackCVC = flowCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "medium")
                            cell.imgCheckMark.isHidden = false
                        }
                        flowCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 2{
                        let IndexP: IndexPath = IndexPath(row: j, section: 0)
                        if let cell: TrackCVC = flowCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "heavy")
                            cell.imgCheckMark.isHidden = false
                        }
                        flowCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 3 {
                        let IndexP: IndexPath = IndexPath(row: 0, section: 0)
                        if let cell: TrackCVC = sexCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "protected")
                            cell.imgCheckMark.isHidden = false
                        }
                        sexCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 4 {
                        let IndexP: IndexPath = IndexPath(row: 1, section: 0)
                        if let cell: TrackCVC = sexCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "unprotected")
                            cell.imgCheckMark.isHidden = false
                        }
                        sexCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 5 {
                        let IndexP: IndexPath = IndexPath(row: 0, section: 0)
                        if let cell: TrackCVC = vaginalCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "clear")
                            cell.imgCheckMark.isHidden = false
                        }
                        vaginalCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 6 {
                        let IndexP: IndexPath = IndexPath(row: 1, section: 0)
                        if let cell: TrackCVC = vaginalCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "white")
                            cell.imgCheckMark.isHidden = false
                        }
                        vaginalCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 7 {
                        let IndexP: IndexPath = IndexPath(row: 2, section: 0)
                        if let cell: TrackCVC = vaginalCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "yellow")
                            cell.imgCheckMark.isHidden = false
                        }
                        vaginalCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                    } else if j == 8 {
                        let IndexP: IndexPath = IndexPath(row: 3, section: 0)
                        if let cell: TrackCVC = vaginalCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "green")
                            cell.imgCheckMark.isHidden = false
                        }
                        vaginalCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 9 {
                        let IndexP: IndexPath = IndexPath(row: 4, section: 0)
                        if let cell: TrackCVC = vaginalCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "sticky")
                            cell.imgCheckMark.isHidden = false
                        }
                        vaginalCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 10 {
                        let IndexP: IndexPath = IndexPath(row: 5, section: 0)
                        if let cell: TrackCVC = vaginalCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "clumpy")
                            cell.imgCheckMark.isHidden = false
                        }
                        vaginalCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 11 {
                        let IndexP: IndexPath = IndexPath(row: 6, section: 0)
                        if let cell: TrackCVC = vaginalCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "bloody")
                            cell.imgCheckMark.isHidden = false
                        }
                        vaginalCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 12 {
                        let IndexP: IndexPath = IndexPath(row: 0, section: 0)
                        if let cell: TrackCVC = symptomsCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "stomach_ache")
                            cell.imgCheckMark.isHidden = false
                        }
                        symptomsCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 13 {
                        let IndexP: IndexPath = IndexPath(row: 1, section: 0)
                        if let cell: TrackCVC = symptomsCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "headache")
                            cell.imgCheckMark.isHidden = false
                        }
                        symptomsCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 14 {
                        let IndexP: IndexPath = IndexPath(row: 2, section: 0)
                        if let cell: TrackCVC = symptomsCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "backache")
                            cell.imgCheckMark.isHidden = false
                        }
                        symptomsCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 15 {
                        let IndexP: IndexPath = IndexPath(row: 3, section: 0)
                        if let cell: TrackCVC = symptomsCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "mood_swings")
                            cell.imgCheckMark.isHidden = false
                        }
                        symptomsCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 16 {
                        let IndexP: IndexPath = IndexPath(row: 4, section: 0)
                        if let cell: TrackCVC = symptomsCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "tender_breasts")
                            cell.imgCheckMark.isHidden = false
                        }
                        symptomsCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                        
                    } else if j == 17 {
                        let IndexP: IndexPath = IndexPath(row: 5, section: 0)
                        if let cell: TrackCVC = symptomsCollectionView.cellForItem(at: IndexP) as? TrackCVC {
                            cell.imgView.image = UIImage.init(named: "nausea")
                            cell.imgCheckMark.isHidden = false
                        }
                        symptomsCollectionView.selectItem(at: IndexP, animated: false, scrollPosition: .top)
                    }else {
                    }
                }
            }
        }
    }
    
}
//MARK: - CollectionView Delegate & Datasource
extension TrackSymtomsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func registerCollectionViewCell() {
        flowCollectionView.register(UINib(nibName: COLLECTION_VIEW_CELL.TrackCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.TrackCVC.rawValue)
        
        sexCollectionView.register(UINib(nibName: COLLECTION_VIEW_CELL.TrackCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.TrackCVC.rawValue)
        
        vaginalCollectionView.register(UINib(nibName: COLLECTION_VIEW_CELL.TrackCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.TrackCVC.rawValue)
        
        symptomsCollectionView.register(UINib(nibName: COLLECTION_VIEW_CELL.TrackCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.TrackCVC.rawValue)
        
        updateFlowTblHeight()
        updateSexTblHeight()
        updateVaginalTblHeight()
        updateSymtomsTblHeight()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == flowCollectionView {
            return flowArr.count
        }
        else if collectionView == sexCollectionView {
            return sexArr.count
        }
        else if collectionView == vaginalCollectionView {
            return vaginalArr.count
        }
        else {
            return symptomsArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == flowCollectionView {
            guard let cell = flowCollectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.TrackCVC.rawValue, for: indexPath) as? TrackCVC else {
                return UICollectionViewCell()
            }
            
            cell.lbl.text = flowArr[indexPath.row]
            if indexPath.row == 0{
                cell.imgView.image = UIImage.init(named: "light1")
                cell.imgCheckMark.isHidden = true
            } else if indexPath.row == 1{
                cell.imgView.image = UIImage.init(named: "medium1")
                cell.imgCheckMark.isHidden = true
            } else {
                cell.imgView.image = UIImage.init(named: "heavy1")
                cell.imgCheckMark.isHidden = true
            }
            return cell
        }
        else if collectionView == sexCollectionView {
            guard let cell = sexCollectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.TrackCVC.rawValue, for: indexPath) as? TrackCVC else {
                return UICollectionViewCell()
            }
            
            cell.lbl.text = sexArr[indexPath.row]
            if indexPath.row == 0 {
                cell.imgView.image = UIImage.init(named: "protected1")
                cell.imgCheckMark.isHidden = true
            } else {
                cell.imgView.image = UIImage.init(named: "unprotected1")
                cell.imgCheckMark.isHidden = true
            }
            
            return cell
        }
        else if collectionView == vaginalCollectionView {
            guard let cell = vaginalCollectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.TrackCVC.rawValue, for: indexPath) as? TrackCVC else {
                return UICollectionViewCell()
            }
            
            cell.lbl.text = vaginalArr[indexPath.row]
            if indexPath.row == 0{
                cell.imgView.image = UIImage.init(named: "clear1")
                cell.imgCheckMark.isHidden = true
            } else if indexPath.row == 1{
                cell.imgView.image = UIImage.init(named: "white1")
                cell.imgCheckMark.isHidden = true
            } else if indexPath.row == 2{
                cell.imgView.image = UIImage.init(named: "yellow1")
                cell.imgCheckMark.isHidden = true
            } else if indexPath.row == 3{
                cell.imgView.image = UIImage.init(named: "green1")
                cell.imgCheckMark.isHidden = true
            } else if indexPath.row == 4{
                cell.imgView.image = UIImage.init(named: "sticky1")
                cell.imgCheckMark.isHidden = true
            } else if indexPath.row == 5{
                cell.imgView.image = UIImage.init(named: "clumpy1")
                cell.imgCheckMark.isHidden = true
            }else {
                cell.imgView.image = UIImage.init(named: "bloody1")
                cell.imgCheckMark.isHidden = true
            }
            
            return cell
        }
        else {
            guard let cell = symptomsCollectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.TrackCVC.rawValue, for: indexPath) as? TrackCVC else {
                return UICollectionViewCell()
            }
            
            cell.lbl.text = symptomsArr[indexPath.row]
            if indexPath.row == 0{
                cell.imgView.image = UIImage.init(named: "stomach_ache1")
                cell.imgCheckMark.isHidden = true
            } else if indexPath.row == 1{
                cell.imgView.image = UIImage.init(named: "headache1")
                cell.imgCheckMark.isHidden = true
            } else if indexPath.row == 2{
                cell.imgView.image = UIImage.init(named: "backache1")
                cell.imgCheckMark.isHidden = true
            } else if indexPath.row == 3{
                cell.imgView.image = UIImage.init(named: "mood_swings1")
                cell.imgCheckMark.isHidden = true
            } else if indexPath.row == 4{
                cell.imgView.image = UIImage.init(named: "tender_breasts1")
                cell.imgCheckMark.isHidden = true
            } else {
                cell.imgView.image = UIImage.init(named: "nausea1")
                cell.imgCheckMark.isHidden = true
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == flowCollectionView {
            let itemWidth = flowCollectionView.bounds.width/4
            let itemHeight = CGFloat(110)
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else if collectionView == sexCollectionView {
            let itemWidth = sexCollectionView.bounds.width/4
            let itemHeight = CGFloat(110)
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else if collectionView == vaginalCollectionView {
            let itemWidth = vaginalCollectionView.bounds.width/4
            let itemHeight = CGFloat(110)
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else {
            let itemWidth = symptomsCollectionView.bounds.width/4
            let itemHeight = CGFloat(110)
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == flowCollectionView {
            
            let IndexP: IndexPath = IndexPath(row: indexPath.row, section: 0)
            let cell: TrackCVC = collectionView.cellForItem(at: IndexP) as! TrackCVC
            
            if indexPath.row == 0{
                cell.imgView.image = UIImage.init(named: "light")
                cell.imgCheckMark.isHidden = false
                trackedSymptoms.append(CategorySymtoms.Flow.Light)
                
            } else if indexPath.row == 1{
                cell.imgView.image = UIImage.init(named: "medium")
                cell.imgCheckMark.isHidden = false
                trackedSymptoms.append(CategorySymtoms.Flow.Medium)
                
            } else {
                cell.imgView.image = UIImage.init(named: "heavy")
                cell.imgCheckMark.isHidden = false
                trackedSymptoms.append(CategorySymtoms.Flow.Heavy)
            }
        }
        else if collectionView == sexCollectionView {
            let IndexP: IndexPath = IndexPath(row: indexPath.row, section: 0)
            let cell: TrackCVC = collectionView.cellForItem(at: IndexP) as! TrackCVC
            if indexPath.row == 0 {
                cell.imgView.image = UIImage.init(named: "protected")
                cell.imgCheckMark.isHidden = false
                trackedSymptoms.append(CategorySymtoms.Sex.Protected)
            } else {
                cell.imgView.image = UIImage.init(named: "unprotected")
                cell.imgCheckMark.isHidden = false
                trackedSymptoms.append(CategorySymtoms.Sex.Unprotected)
            }
        }
        else if collectionView == vaginalCollectionView {
            let IndexP: IndexPath = IndexPath(row: indexPath.row, section: 0)
            let cell: TrackCVC = collectionView.cellForItem(at: IndexP) as! TrackCVC
            
            if indexPath.row == 0{
                if cell.imgView.image == UIImage.init(named: "clear") {
                    cell.imgView.image = UIImage.init(named: "clear1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.VaginalDischarge.Clear
                    self.deleteSymptoms(track)

                }else {
                    cell.imgView.image = UIImage.init(named: "clear")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.VaginalDischarge.Clear)
                }
            } else if indexPath.row == 1{
                if cell.imgView.image == UIImage.init(named: "white") {
                    cell.imgView.image = UIImage.init(named: "white1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.VaginalDischarge.White
                    self.deleteSymptoms(track)

                }else{
                    cell.imgView.image = UIImage.init(named: "white")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.VaginalDischarge.White)
                }
            } else if indexPath.row == 2{
                if cell.imgView.image == UIImage.init(named: "yellow") {
                    cell.imgView.image = UIImage.init(named: "yellow1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.VaginalDischarge.Yellow
                    self.deleteSymptoms(track)

                }else {
                    cell.imgView.image = UIImage.init(named: "yellow")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.VaginalDischarge.Yellow)
                }
            } else if indexPath.row == 3{
                if cell.imgView.image == UIImage.init(named: "green") {
                    cell.imgView.image = UIImage.init(named: "green1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.VaginalDischarge.Green
                    self.deleteSymptoms(track)

                }else {
                    cell.imgView.image = UIImage.init(named: "green")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.VaginalDischarge.Green)
                }
            } else if indexPath.row == 4{
                if cell.imgView.image == UIImage.init(named: "sticky") {
                    cell.imgView.image = UIImage.init(named: "sticky1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.VaginalDischarge.Sticky
                    self.deleteSymptoms(track)

                }else {
                    cell.imgView.image = UIImage.init(named: "sticky")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.VaginalDischarge.Sticky)
                }
            } else if indexPath.row == 5 {
                if cell.imgView.image == UIImage.init(named: "clumpy") {
                    cell.imgView.image = UIImage.init(named: "clumpy1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.VaginalDischarge.Clumpy
                    self.deleteSymptoms(track)

                }else{
                    cell.imgView.image = UIImage.init(named: "clumpy")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.VaginalDischarge.Clumpy)
                }
            } else {
                if cell.imgView.image == UIImage.init(named: "bloody") {
                    cell.imgView.image = UIImage.init(named: "bloody1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.VaginalDischarge.Bloody
                    self.deleteSymptoms(track)

                }else{
                    cell.imgView.image = UIImage.init(named: "bloody")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.VaginalDischarge.Bloody)
                }
            }
            
        }
        else {
            let IndexP: IndexPath = IndexPath(row: indexPath.row, section: 0)
            let cell: TrackCVC = collectionView.cellForItem(at: IndexP) as! TrackCVC
            
            if indexPath.row == 0{
                if cell.imgView.image == UIImage.init(named: "stomach_ache") {
                    cell.imgView.image = UIImage.init(named: "stomach_ache1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.OtherSymptoms.StomachAche
                    self.deleteSymptoms(track)
                }else {
                    cell.imgView.image = UIImage.init(named: "stomach_ache")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.OtherSymptoms.StomachAche)
                }
            } else if indexPath.row == 1{
                if cell.imgView.image == UIImage.init(named: "headache") {
                    cell.imgView.image = UIImage.init(named: "headache1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.OtherSymptoms.Headache
                    self.deleteSymptoms(track)

                }else  {
                    cell.imgView.image = UIImage.init(named: "headache")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.OtherSymptoms.Headache)
                }
                
            } else if indexPath.row == 2{
                if cell.imgView.image == UIImage.init(named: "backache") {
                    cell.imgView.image = UIImage.init(named: "backache1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.OtherSymptoms.Backache
                    self.deleteSymptoms(track)

                }else{
                    cell.imgView.image = UIImage.init(named: "backache")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.OtherSymptoms.Backache)
                }
            } else if indexPath.row == 3{
                if cell.imgView.image == UIImage.init(named: "mood_swings") {
                    cell.imgView.image = UIImage.init(named: "mood_swings1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.OtherSymptoms.MoodSwings
                    self.deleteSymptoms(track)

                }else{
                    cell.imgView.image = UIImage.init(named: "mood_swings")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.OtherSymptoms.MoodSwings)
                }
            } else if indexPath.row == 4{
                if cell.imgView.image == UIImage.init(named: "tender_breasts") {
                    cell.imgView.image = UIImage.init(named: "tender_breasts1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.OtherSymptoms.TenderBrests
                    self.deleteSymptoms(track)

                }else{
                    cell.imgView.image = UIImage.init(named: "tender_breasts")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.OtherSymptoms.TenderBrests)
                }
            } else {
                if cell.imgView.image == UIImage.init(named: "nausea") {
                    cell.imgView.image = UIImage.init(named: "nausea1")
                    cell.imgCheckMark.isHidden = true
                    let track: String = CategorySymtoms.OtherSymptoms.Nausea
                    self.deleteSymptoms(track)

                }else{
                    cell.imgView.image = UIImage.init(named: "nausea")
                    cell.imgCheckMark.isHidden = false
                    trackedSymptoms.append(CategorySymtoms.OtherSymptoms.Nausea)
                }
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == flowCollectionView {
            let IndexP: IndexPath = IndexPath(row: indexPath.row, section: 0)
            let cell: TrackCVC = collectionView.cellForItem(at: IndexP) as! TrackCVC
            
            if indexPath.row == 0{
                cell.imgView.image = UIImage.init(named: "light1")
                cell.imgCheckMark.isHidden = true
                let track: String = CategorySymtoms.Flow.Light
                self.deleteSymptoms(track)
                
            } else if indexPath.row == 1{
                cell.imgView.image = UIImage.init(named: "medium1")
                cell.imgCheckMark.isHidden = true
                let track: String = CategorySymtoms.Flow.Medium
                self.deleteSymptoms(track)

            } else {
                cell.imgView.image = UIImage.init(named: "heavy1")
                cell.imgCheckMark.isHidden = true
                let track: String = CategorySymtoms.Flow.Heavy
                self.deleteSymptoms(track)
            }
        } else if collectionView == sexCollectionView {
            let IndexP: IndexPath = IndexPath(row: indexPath.row, section: 0)
            let cell: TrackCVC = collectionView.cellForItem(at: IndexP) as! TrackCVC
            
            if indexPath.row == 0 {
                cell.imgView.image = UIImage.init(named: "protected1")
                cell.imgCheckMark.isHidden = true
                let track: String = CategorySymtoms.Sex.Protected
                self.deleteSymptoms(track)

            } else {
                cell.imgView.image = UIImage.init(named: "unprotected1")
                cell.imgCheckMark.isHidden = true
                let track: String = CategorySymtoms.Sex.Unprotected
                self.deleteSymptoms(track)
            }
            
        } else {
            
        }
        
    }
    func updateFlowTblHeight() {
        flowCollectionViewHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        flowCollectionView.reloadData()
        flowCollectionView.layoutIfNeeded()
        flowCollectionViewHeightConstraint.constant = flowCollectionView.contentSize.height
    }
    
    func updateSexTblHeight() {
        sexCollectionViewHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        sexCollectionView.reloadData()
        sexCollectionView.layoutIfNeeded()
        sexCollectionViewHeightConstraint.constant = sexCollectionView.contentSize.height
    }
    
    func updateVaginalTblHeight() {
        vaginalCollectionViewHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        vaginalCollectionView.reloadData()
        vaginalCollectionView.layoutIfNeeded()
        vaginalCollectionViewHeightConstraint.constant = vaginalCollectionView.contentSize.height
    }
    
    func updateSymtomsTblHeight() {
        symptomsCollectionViewHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        symptomsCollectionView.reloadData()
        symptomsCollectionView.layoutIfNeeded()
        symptomsCollectionViewHeightConstraint.constant = symptomsCollectionView.contentSize.height
    }
    func getrangedate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let currentdate: String = dateFormatter.string(from: date)
        return currentdate
    }
    
    //MARK: API
    
    func addSysmptomsAPI() {
        let currnetDate: String = self.getrangedate(Date())
        
        let url = URL(string: API.PERIODBASE.AddSysmptoms)!
        print(url)
        showLoader()
        let param = ["userid" : AppModel.shared.currentUser.userdata!.id, "trackingDate":currnetDate, "trackedSymptoms": trackedSymptoms] as [String : Any]
        print(param)//624d42aac92bd21c7d7ad8fc
        self.addSymptomsAPI(param, url: url)
        
    }
    func getSymptomsAPI(){
        let currnetDate: String = self.getrangedate(Date())
        
        let url = URL(string: API.PERIODBASE.GetSymtoms)!
        print(url)
        showLoader()
        let param = ["userid" : AppModel.shared.currentUser.userdata!.id, "date": currnetDate]
        
        print(param)//624d42aac92bd21c7d7ad8fc
        self.getSymptomsDataAPI(url, param: param)
        
    }
    
    func getSymptomsDataAPI(_ url:URL, param: Parameters){
        
        AllApis.getSymptomsAPI(vc: self, url: url, parameters: param) { result, error in
            DispatchQueue.main.async {
                removeLoader()
                if error == nil{
                    if result != nil{
                        print(result!)
                        let status:String = result!["msg"] as! String
                        if status == "success"{
                            let data: [String : Any] = result!["data"] as! [String : Any]
                            self.trackedSymptoms = data["trackedSymptoms"] as! [String]
                            self.updateUI()
                        }else{
                            let message:String = result!["msg"] as! String
                            displayToast(message)
                        }
                    }
                } else {
                    displayToast("Server_error")
                }
            }
        }
    }
    
    
    func addSymptomsAPI(_ param: Parameters, url: URL){
        
        AllApis.addSymptomsAPI(vc: self, url: url, param: param) { (result, error) in
            DispatchQueue.main.async {
                removeLoader()
                if error == nil{
                    print(result!)
                    let status:Bool = result!["success"] as! Bool
                    if status == true{
                        let message:String = result!["msg"] as! String
                        displayToast(message)
                        self.navigationController?.popViewController(animated: true)

                    }else{
                        let message:String = result!["msg"] as! String
                        displayToast(message)
                    }
                } else {
                    displayToast("Server_error")
                }
            }
        }
    }
}
