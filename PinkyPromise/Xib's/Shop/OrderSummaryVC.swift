//
//  OrderSummaryVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 29/01/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

class OrderSummaryVC: UITableViewCell {

    @IBOutlet weak var productImgView: ImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productQuantityLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
