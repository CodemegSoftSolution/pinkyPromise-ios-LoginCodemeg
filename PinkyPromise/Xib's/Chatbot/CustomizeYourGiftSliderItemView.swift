//
//  CustomizeYourGiftsGiftCollectionViewCell.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 1/16/19.
//  Copyright © 2019 Vodafone Egypt. All rights reserved.
//

import UIKit

class CustomizeYourGiftSliderItemView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var giftValueLabel: UILabel!
    var value : String?
    private var color : UIColor?
    var loadFirstTime = false
    var selected:Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    private func nibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(contentView)
    }
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: String(describing: type(of:self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    func setData(value:String) {
        self.value = value
        self.giftValueLabel.text = value
    }
    func setLabelColor(_ color :UIColor,newValue:String?){
        self.color = color
        if giftValueLabel != nil {
            self.giftValueLabel.textColor = color
        }
    }
    override func setSmoothSelected(_ selected: Bool) {
        self.selected = selected
        self.color = selected ? AppColor : LightPinkColor
        loadFirstTime = true
        if giftValueLabel != nil {
            self.giftValueLabel.textColor = color
        }
    }
}


class viewss: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func setSmoothSelected(_ selected: Bool) {
        if selected {
            self.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }else{
            self.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)

        }
        print(selected)
    }

}
