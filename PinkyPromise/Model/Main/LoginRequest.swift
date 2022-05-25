//
//  LoginRequest.swift
//  InstantFest
//
//  Created by iMac on 6/17/21.
//

import Foundation

struct LoginRequest: Encodable {
    var email, password: String?
    var acceptterms, rememberme : Bool?
    var IsSocialMedia : Bool?
    var id : String? // social media id
    var logintype : String?
    var name : String?
    
    init(email: String? = nil, name:String? = nil, password:String? = nil, acceptterms:Bool? = nil, IsSocialMedia:Bool? = nil, rememberme:Bool? = nil, referralCode:String? = nil, id:String? = nil, logintype:String? = nil){
        
        self.email = email
        self.name = name
        self.password = password
        self.acceptterms = acceptterms
        self.id = id
        self.logintype = logintype
        self.IsSocialMedia = IsSocialMedia
        self.rememberme = rememberme
    }
}

struct ForgotPasswordRequest: Encodable {
    var email: String
}

struct ResetPasswordRequest: Encodable {
    var email, newpassword, oldpassword: String
}

struct AddLanguageRequest: Encodable {
    var userid, defaultLanguage: String
}

struct VerifyRequest: Encodable {
    var userId, referralCode: String
}

struct VerifyPhoneNumberRequest: Encodable {
    var mobilenumber, userid: String
}

struct VerifyOtpRequest: Encodable {
    var otp, userid: String
}

struct UpdateTokenRequest: Encodable {
    var email, divicetoken: String
}


struct SignupRequest: Encodable {
    var email: String?
    var password: String?
    var acceptterms : Bool?
    var referralCode : String?
    var IsSocialMedia : Bool?
    var id : String? // social media id
    var signuptype : String?
    var name : String?
    var chatroomperference : [String]?
    
    init(email: String? = nil, name:String? = nil, password:String? = nil, acceptterms:Bool? = nil, IsSocialMedia:Bool? = nil, referralCode:String? = nil, id:String? = nil, signuptype:String? = nil, chatroomperference:[String]? = nil){
        
        self.email = email
        self.name = name
        self.password = password
        self.acceptterms = acceptterms
        self.referralCode = referralCode
        self.id = id
        self.signuptype = signuptype
        self.chatroomperference = chatroomperference
        self.IsSocialMedia = IsSocialMedia
    }
}

struct MorePageRequest: Encodable {
    var page: Int
}

struct CreateAccountRequest : Encodable {
    var username:String?
    var height:WeightRequest?
    var weight:WeightRequest?
    var gender: String?
    var healthissue:[String]?
    var dob: String?
    var avgBleedingDuration: String?
    var avgMenstrualCycle: String?
    var lastPeriodsDate: String?
    
    init(username: String? = nil, gender: String? = nil, healthissue: [String]? = nil, dob: String? = nil, height:WeightRequest? = nil, weight:WeightRequest? = nil, avgBleedingDuration: String? = nil, avgMenstrualCycle: String? = nil, lastPeriodsDate: String? = nil){
        
        self.username = username
        self.gender = gender
        self.healthissue = healthissue
        self.dob = dob
        self.height = height
        self.weight = weight
        self.avgBleedingDuration = avgBleedingDuration
        self.avgMenstrualCycle = avgMenstrualCycle
        self.lastPeriodsDate = lastPeriodsDate
    }
}

struct WeightRequest: Encodable {
    var measure: Int
    var unit: String
}

struct LanguageRequest: Encodable {
    var lng: String
}

struct ShopLanguageRequest: Encodable {
    var language: String
}

struct UserDetailRequest: Encodable {
    var userid: String
}
