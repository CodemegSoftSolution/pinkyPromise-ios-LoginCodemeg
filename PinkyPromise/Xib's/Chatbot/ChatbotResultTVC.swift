//
//  ChatbotResultTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 07/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class ChatbotResultTVC: UITableViewCell {

    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var ansLbl: UILabel!
    @IBOutlet weak var ansTxtView: UITextView!
    @IBOutlet weak var textviewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
