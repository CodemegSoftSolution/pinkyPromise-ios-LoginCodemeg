//
//  CompleteYorProfileVC.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 16/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

class CompleteYorProfileVC: UIViewController {

    var yRef:CGFloat = screenWidth

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.screenDesigning()
    }
    
    func screenDesigning() {
        let imgGirl: UIImageView = UIImageView()
        imgGirl.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
        imgGirl.image = UIImage.init(named: "completeProfileimage")
        self.view.addSubview(imgGirl)
        
        let btnBack:UIButton = UIButton()
        btnBack.frame = CGRect(x: 5, y: 30, width: 40, height: 40)
        btnBack.setImage(UIImage.init(named: "back_grey"), for: .normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnBack)

        yRef = yRef + 30
        
        let lblAlmostthere: UILabel = UILabel()
        lblAlmostthere.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 35)
        lblAlmostthere.text = "Almost there!"
        lblAlmostthere.textColor = ColorPink
        lblAlmostthere.textAlignment = .center
        lblAlmostthere.font = UIFont.init(name: FONT.Playfair.rawValue, size: 24.0)
        self.view.addSubview(lblAlmostthere)
        
        yRef = yRef+lblAlmostthere.frame.size.height + 20
        
        let lblNeedContant:UILabel = UILabel()
        lblNeedContant.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 30)
        lblNeedContant.textColor = GrayColor
        lblNeedContant.text = "Need To Ask Few Questions Before Setting Up Your Profile "
        lblNeedContant.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        lblNeedContant.textAlignment = .center
        lblNeedContant.clipsToBounds = true
        lblNeedContant.numberOfLines = 0
        lblNeedContant.lineBreakMode = .byWordWrapping
        lblNeedContant.sizeToFit()
        self.view.addSubview(lblNeedContant)

        yRef = yRef+lblNeedContant.frame.size.height + 40

        let btnComopleteProfile:UIButton = UIButton()
        btnComopleteProfile.frame = CGRect(x: 20, y: yRef, width: screenWidth-40, height: 40)
        btnComopleteProfile.backgroundColor = ColorPink
        btnComopleteProfile.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        btnComopleteProfile.setTitle("COMPLETE YOUR PROFILE", for: .normal)
        btnComopleteProfile.setTitleColor(UIColor.white, for: .normal)
        btnComopleteProfile.layer.cornerRadius = 20
        btnComopleteProfile.clipsToBounds = true
        btnComopleteProfile.addTarget(self, action: #selector(self.btnComopleteProfileClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnComopleteProfile)
        
    }
    
    //MARK: Action
    @objc func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btnComopleteProfileClicked(_ sender: UIButton) {
        let vc: AboutMeViewController = AboutMeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
