//
//  FaqListTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 20/01/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

class FaqListTVC: UITableViewCell {

    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
