//
//  CartTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 20/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class CartTVC: UITableViewCell {

    @IBOutlet weak var productImgView: ImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
        
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    
    @IBOutlet weak var coinPlusBtn: UIButton!
    @IBOutlet weak var coinMinusBtn: UIButton!
//    @IBOutlet weak var coinCountLbl: UILabel!
    @IBOutlet weak var coinCountTxt: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
