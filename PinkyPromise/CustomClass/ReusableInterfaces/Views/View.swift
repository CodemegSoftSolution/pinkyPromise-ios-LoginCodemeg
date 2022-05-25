//
//  View.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

@IBDesignable
class View: UIView {
    
    @IBInspectable var backgroundColorTypeAdapter : Int32 = 0 {
        didSet {
            self.backgroundColorType = ColorType(rawValue: self.backgroundColorTypeAdapter)
        }
    }
    var backgroundColorType : ColorType? {
        didSet {
            setBackgroundColor(backgroundColorType: backgroundColorType)
        }
    }
    
    @IBInspectable var gradientBackgroundTypeAdapter : Int32 = 0 {
        didSet {
            gradientBackgroundType = GradientColorTypeForView(rawValue: gradientBackgroundTypeAdapter) ?? .Clear
        }
    }
    var gradientBackgroundType : GradientColorTypeForView = .Clear {
        didSet {
            setGradientBackground1(gradientBackgroundType: gradientBackgroundType)
        }
    }
    
    @IBInspectable var borderColorTypeAdapter : Int32 = 0 {
        didSet {
            self.borderColorType = ColorType(rawValue: self.borderColorTypeAdapter)
        }
    }
    var borderColorType : ColorType? {
        didSet {
            setBorderColor(borderColorType: borderColorType)
        }
    }
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            setCornerRadius(cornerRadius)
        }
    }
    
    @IBInspectable var applyShadow : Bool = false {
        didSet {
            setShadow(applyShadow: applyShadow)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setGradientBackground1(gradientBackgroundType: gradientBackgroundType)
    }
    
//    @IBInspectable open var cornerEdges : CGFloat = 0
//    @IBInspectable  var topLeft: Bool = false
//    @IBInspectable  var topRight: Bool = false
//    @IBInspectable  var bottomLeft: Bool = false
//    @IBInspectable  var bottomRight: Bool = false
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        var options = UIRectCorner()
//        if topLeft {
//            options =  options.union(.topLeft)
//        }
//        if topRight {
//            options =  options.union(.topRight)
//        }
//        if bottomLeft {
//            options =  options.union(.bottomLeft)
//        }
//        if bottomRight {
//            options =  options.union(.bottomRight)
//        }
//
//        setRoundCorners(options, radius: cornerEdges)
//    }
}

extension UIView {
    func setBackgroundColor(backgroundColorType : ColorType?) {
        backgroundColor = backgroundColorType?.value
    }
    
    func setBorderColor(borderColorType : ColorType?) {
        self.layer.borderColor = borderColorType?.value.cgColor
    }
    
    func setTintColor(tintColorType : ColorType?) {
        self.tintColor = tintColorType?.value
    }
    
    func setCornerRadius(_ cornerRadius : CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func setShadow(applyShadow : Bool) {
        if applyShadow {
            self.layer.masksToBounds = false;
            self.layer.shadowOffset = CGSize(width: 0.5, height: 1.5)
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowRadius = 2
        } else {
            self.layer.shadowRadius = 0
            self.layer.shadowColor = UIColor.clear.cgColor
        }
    }
    
    func setGradientBackground(gradientBackgroundType : GradientColorType) {
        
        if gradientBackgroundType == .Clear {
            return
        }
        
        if let gradient = self.layer.value(forKeyPath: "GradientLayer") as? GradientLayer {
            gradient.frame = self.bounds
            return
        }
        
        let layer = gradientBackgroundType.layer
        layer.frame = self.bounds
        
        self.layer.insertSublayer(layer, at: 0)
        self.layer.setValue(layer, forKey: "GradientLayer")
    }
    
    func setGradientBackground1(gradientBackgroundType : GradientColorTypeForView) {
        
        if gradientBackgroundType == .Clear {
            return
        }
        
        if let gradient = self.layer.value(forKeyPath: "GradientLayer") as? GradientLayer {
            gradient.frame = self.bounds
            return
        }
        
        let layer = gradientBackgroundType.layer
        layer.frame = self.bounds
        
        self.layer.insertSublayer(layer, at: 0)
        self.layer.setValue(layer, forKey: "GradientLayer")
    }
    
    
    func setRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func setCornerRadiusWithShadow(applyShadow : Bool)  {
        self.layer.cornerRadius = 10

        // border
        self.layer.borderWidth = 1.0
        self.layer.borderColor = ClearColor.cgColor

        // shadow
        self.layer.shadowColor = colorFromHex(hex: "E7E7E7").cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 2.0
    }
    func ShaplayerUp(_ shap:CAShapeLayer, corner:CGFloat)
    {
        shap.bounds = self.frame
        shap.position = self.center
        shap.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight , .topLeft], cornerRadii: CGSize(width: corner, height: corner)).cgPath
        self.layer.mask = shap
    }
    func ShaplayerDown(_ shap:CAShapeLayer, corner:CGFloat)
    {
        shap.bounds = self.frame
        shap.position = self.center
        shap.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: corner, height: corner)).cgPath
        self.layer.mask = shap
    }

}

