//
//  ChatGroupTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 09/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class ChatGroupTVC: UITableViewCell {

    @IBOutlet weak var imgaView: ImageView!
    @IBOutlet weak var imgBtn: UIButton!
    @IBOutlet weak var topicNameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var unReadCountBtn: Button!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
