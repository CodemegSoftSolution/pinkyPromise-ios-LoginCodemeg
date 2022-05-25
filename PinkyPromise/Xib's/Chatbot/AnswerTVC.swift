//
//  AnswerTVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 09/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class AnswerTVC: UITableViewCell {

    @IBOutlet weak var backView: View!
    @IBOutlet weak var answerLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configUI() {
        backView.cornerRadius = 5
        backView.borderWidth = 1
        backView.borderColorTypeAdapter = 9
    }
    
}
