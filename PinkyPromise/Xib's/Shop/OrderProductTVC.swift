//
//  OrderProductTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 23/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class OrderProductTVC: UITableViewCell {

    @IBOutlet weak var firstProductBackView: View!
    @IBOutlet weak var productImgView: ImageView!
    @IBOutlet weak var productnNameLbl: UILabel!
    @IBOutlet weak var productQuantityLbl: UILabel!
    @IBOutlet weak var productAmountLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
