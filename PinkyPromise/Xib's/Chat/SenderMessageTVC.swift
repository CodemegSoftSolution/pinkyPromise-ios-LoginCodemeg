//
//  SenderMessageTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 15/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class SenderMessageTVC: UITableViewCell {

    @IBOutlet weak var dateBackView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var disLikeBtn: UIButton!
   
    @IBOutlet weak var replyMessageBackView: View!
    @IBOutlet weak var replyMessageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
