//
//  CustomTabBarView.swift
//  Event Project
//
//  Created by Amisha on 20/07/17.
//  Copyright © 2017 AK Infotech. All rights reserved.
//

import UIKit

protocol CustomTabBarViewDelegate
{
    func tabSelectedAtIndex(index:Int)
}

class CustomTabBarView: UIView {
    
    @IBOutlet weak var tabView1: UIView!
    @IBOutlet weak var tabView2: UIView!
    @IBOutlet weak var tabView3: UIView!
    @IBOutlet weak var tabView4: UIView!
    @IBOutlet weak var tabView5: UIView!
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    
    @IBOutlet weak var chatCountBadgeBtn: Button!
    
    var delegate:CustomTabBarViewDelegate?
    
    var lastIndex : NSInteger!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize()
    {
        lastIndex = 0
    }
    
    @IBAction func tabBtnClicked(_ sender: UIButton)
    {
        let btn: UIButton = sender
//        if AppModel.shared.isGuestUser && btn.tag >= 2 {
//            AppDelegate().sharedDelegate().continueToGuestLogin()
//            return
//        }
        
        lastIndex = btn.tag - 1
        
        resetAllButton()
        selectTabButton()
    }
    
    func resetAllButton()
    {
        btn1.isSelected = false
        btn2.isSelected = false
        btn3.isSelected = false
        btn4.isSelected = false
        btn5.isSelected = false
        
        tabView1.backgroundColor = WhiteColor
        tabView2.backgroundColor = WhiteColor
        tabView3.backgroundColor = WhiteColor
        tabView4.backgroundColor = WhiteColor
        tabView5.backgroundColor = WhiteColor
        
        lbl1.textColor = UIColor.lightGray
        lbl2.textColor = UIColor.lightGray
        lbl3.textColor = UIColor.lightGray
        lbl4.textColor = UIColor.lightGray
        lbl5.textColor = UIColor.lightGray
    }
    
    func selectTabButton()
    {
        switch lastIndex {
        case 0:
            btn1.isSelected = true
            lbl1.textColor = AppColor
            break
        case 1:
            btn2.isSelected = true
            lbl2.textColor = AppColor
            break
        case 2:
            btn3.isSelected = true
            lbl3.textColor = AppColor
            break
        case 3:
            btn4.isSelected = true
            lbl4.textColor = AppColor
            break
        case 4:
            btn5.isSelected = true
            lbl5.textColor = AppColor
            break
        default:
            break
        }
        delegate?.tabSelectedAtIndex(index: lastIndex)
    }
}
