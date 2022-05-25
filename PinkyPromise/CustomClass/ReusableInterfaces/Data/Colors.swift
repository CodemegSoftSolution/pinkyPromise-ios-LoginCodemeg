//
//  Colors.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

var ClearColor : UIColor = UIColor.clear //0
var WhiteColor : UIColor = UIColor.white //1
var BlackColor : UIColor = colorFromHex(hex: "000000") //2
var LightGrayColor : UIColor = colorFromHex(hex: "#CCCCCC") //3
var ExtraLightGrayColor : UIColor = colorFromHex(hex: "#C4C4C4") //4  #F4F4F4
var GrayColor : UIColor = colorFromHex(hex: "2B2B2B") //5
var LightPinkColor : UIColor = UIColor.init(named: "LightPink")! //6

var DarkTextColor : UIColor = UIColor.init(named: "DarkText")! //7
var AppColor : UIColor = UIColor.init(named: "Pink")! //9

// Designin New Developer

var PrimeryPink: UIColor = UIColor.init(red: 255/255.0, green: 66/255.0, blue: 76/255.0, alpha: 1)
var ColorPink: UIColor = UIColor.init(red: 255/255.0, green: 142/255.0, blue: 140/255.0, alpha: 1)
var ColorLightGray: UIColor = UIColor.init(red: 244/255.0, green: 245/255.0, blue: 246/255.0, alpha: 1)
var ColorGeen: UIColor = UIColor.init(red: 93/255.0, green: 216/255.0, blue: 208/255.0, alpha: 1)
var ColorGrayText: UIColor = UIColor.init(red: 80/255.0, green: 82/255.0, blue: 85/255.0, alpha: 1)
var ColorRed: UIColor = UIColor.init(red: 255/255.0, green: 66/255.0, blue: 76/255.0, alpha: 1)
var ColorHeaderText: UIColor = UIColor.init(red: 87/255.0, green: 89/255.0, blue: 92/255.0, alpha: 1)
var ColorDarkGray: UIColor = UIColor.init(red: 117/255.0, green: 129/255.0, blue: 143/255.0, alpha: 1)
var LightGrayEdit: UIColor = UIColor.init(red: 161/255.0, green: 161/255.0, blue: 161/255.0, alpha: 1)
//rgba(117, 129, 143, 1) rgba(161, 161, 161, 1)

enum ColorType : Int32 {
    case Clear = 0
    case White = 1
    case Black = 2
    case LightGray = 3
    case ExtraLightGray = 4
    case Gray = 5
    case LightPink = 6
    case PinkColor = 8
    case DarkText = 7
    case App = 9
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
                case .Clear: //0
                    return ClearColor
                case .White: //1
                    return WhiteColor
                case .Black: //2
                    return BlackColor
                case .LightGray: //3
                    return LightGrayColor
                case .ExtraLightGray: //4
                    return ExtraLightGrayColor
                case .Gray: //5
                    return GrayColor
                case .LightPink: //6
                    return LightPinkColor
                case .DarkText: //7
                    return DarkTextColor
                case .App: //9
                    return AppColor
            case .PinkColor:
                return ColorPink
            }
        }
    }
}

enum GradientColorType : Int32 {
    case Clear = 0
    case Login = 1
}

extension GradientColorType {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .Login: //1
                gradient.colors = [
                    colorFromHex(hex: "06BD8C").cgColor,
                    colorFromHex(hex: "05A191").cgColor  //089B97
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
//                gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
//                gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
            }
            
            return gradient
        }
    }
}


enum GradientColorTypeForView : Int32 {
    case Clear = 0
    case App = 1
}


extension GradientColorTypeForView {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .App: //1
                gradient.colors = [
                    colorFromHex(hex: "#00AF80").cgColor,
                    colorFromHex(hex: "#06BD8C").cgColor,
                    colorFromHex(hex: "#08969C").cgColor
                ]
                gradient.locations = [0.0, 0.5, 1.0]
                gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            }
            
            return gradient
        }
    }
}

