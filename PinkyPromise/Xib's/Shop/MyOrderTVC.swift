//
//  MyOrderTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 22/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class MyOrderTVC: UITableViewCell {

    @IBOutlet weak var orderLbl: UILabel!
    @IBOutlet weak var paymentStatusLbl: UILabel!
    
    @IBOutlet weak var firstProductBackView: View!
    @IBOutlet weak var product1ImgView: ImageView!
    @IBOutlet weak var productn1NameLbl: UILabel!
    @IBOutlet weak var product1QuantityLbl: UILabel!
    @IBOutlet weak var product1AmountLbl: UILabel!
    
    @IBOutlet weak var secondProductBackView: View!
    @IBOutlet weak var product2ImgView: ImageView!
    @IBOutlet weak var product2NameLbl: UILabel!
    @IBOutlet weak var product2QuantityLbl: UILabel!
    @IBOutlet weak var product2AmountLbl: UILabel!
    
    @IBOutlet weak var cancelBtn: Button!
    @IBOutlet weak var comfirmBtn: Button!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
