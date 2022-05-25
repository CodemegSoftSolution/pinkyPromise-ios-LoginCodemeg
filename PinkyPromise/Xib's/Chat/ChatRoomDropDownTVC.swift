//
//  ChatRoomDropDownTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 17/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class ChatRoomDropDownTVC: UITableViewCell {

    @IBOutlet weak var backView: View!
    @IBOutlet weak var imgBtn: UIButton!
    @IBOutlet weak var topicNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
