//
//  HowItsWorkTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 20/01/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

class HowItsWorkTVC: UITableViewCell {

    @IBOutlet weak var backView: View!
    @IBOutlet weak var numberBtn: Button!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var bottomBackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configUI() {
        backView.setCornerRadiusWithShadow(applyShadow: true)
    }
    
}
