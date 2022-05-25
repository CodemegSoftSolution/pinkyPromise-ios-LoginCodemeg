//
//  CategorySymtoms.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 21/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import Foundation

struct CategorySymtoms {
    
    struct Flow {
        static let Light = "FL_LIT"
        static let Medium = "FL_MED"
        static let Heavy = "FL_HVY"
    }
    
    struct Sex {
        static let Unprotected = "SX_UNPR"
        static let Protected = "SX_PR"
    }
    
    struct VaginalDischarge {
        static let Clear = "VD_CLR"
        static let White = "VD_WHT"
        static let Yellow = "VD_YLW"
        static let Green = "VD_GRN"
        static let Sticky = "VD_STK"
        static let Clumpy = "VD_CLM"
        static let Bloody = "VD_BLD"
    }
    
    struct OtherSymptoms {
        static let StomachAche = "OS_SAC"
        static let Headache = "OS_HAC"
        static let Backache = "OS_BAC"
        static let MoodSwings = "OS_MSW"
        static let TenderBrests = "OS_TNBR"
        static let Nausea = "OS_NAU"
    }
}
