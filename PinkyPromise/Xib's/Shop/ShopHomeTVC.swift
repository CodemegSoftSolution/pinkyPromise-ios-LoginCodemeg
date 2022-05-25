//
//  ShopHomeTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 18/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class ShopHomeTVC: UITableViewCell {

    @IBOutlet weak var productImgView: ImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var addCartBackView: View!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    @IBOutlet weak var produictAddBackView: View!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
