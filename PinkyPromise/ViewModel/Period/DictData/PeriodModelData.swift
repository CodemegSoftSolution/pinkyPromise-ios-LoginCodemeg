//
//  PeriodModelData.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 21/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import Foundation


class GetSymtomsData: NSObject{
    
    var product_id:Any!
    var product_name:Any!
    var product_image:Any!
    var price:Any!
    var discount:Any!
    var food_type:Any!
    var category_id:Any!
    var sub_category_id:Any!
    var product_details:Any!

    init?(profileInfo: [String: Any]) {

        self.product_id = profileInfo["product_id"]!
        self.product_name = profileInfo["product_name"]!
        self.product_image = profileInfo["product_image"]!
        self.price = profileInfo["price"]!
        self.discount = profileInfo["discount"]!
        self.food_type = profileInfo["food_type"]!
        self.category_id = profileInfo["category_id"]!
        self.sub_category_id = profileInfo["sub_category_id"]!
        self.product_details = profileInfo["product_details"]!
    }
}


class GetUserInfoData: NSObject{
    
    var ColorCode:Any!
    var IsSocialMedia:Any!
    var UserLocationInfo: [String : Any]!
    var __v:Any!
    var _id:Any!
    var acceptterms:Any!
    var avgBleedingDuration:Any!
    var avgMenstrualCycle:Any!
    var chatroomperference:[String : Any]!
    var createdAt:Any!
    var defaultLanguage:Any!
    var divicetoken:Any!
    var dob:Any!
    var email:Any!
    var gender: Any!
    var height: [String : Any]
    var isRegisteredForPeriodTracker: Any!
    var lastPeriodDate:Any!
    var lastPeriodsDate:Any!
    var mobilenumberverified:Any!
    var profilecomplete: Any!
    var rememberme: Any!
    var socialmedialogintype:Any!
    var updatedAt:Any!
    var userLoggedDates:[String: Any]!
    var username:Any!
    var weight: [String : Any]!

    init?(profileInfo: [String: Any]) {

        self.ColorCode = profileInfo["ColorCode"]!
        self.IsSocialMedia = profileInfo["IsSocialMedia"]!
        self.UserLocationInfo = profileInfo["UserLocationInfo"]! as? [String : Any]
        self.__v = profileInfo["__v"]!
        self._id = profileInfo["_id"]!
        self.acceptterms = profileInfo["acceptterms"]!
        self.avgBleedingDuration = profileInfo["avgBleedingDuration"]!
        self.avgMenstrualCycle = profileInfo["avgMenstrualCycle"]!
        self.chatroomperference = profileInfo["chatroomperference"]! as? [String : Any]
        self.createdAt = profileInfo["createdAt"]!
        self.defaultLanguage = profileInfo["defaultLanguage"]!
        self.divicetoken = profileInfo["divicetoken"]!
        self.dob = profileInfo["dob"]!
        self.email = profileInfo["email"]!
        self.gender = profileInfo["gender"]!
        self.height = profileInfo["height"]! as! [String : Any]
        self.isRegisteredForPeriodTracker = profileInfo["isRegisteredForPeriodTracker"]!
        self.lastPeriodDate = profileInfo["lastPeriodDate"]!
        self.lastPeriodsDate = profileInfo["lastPeriodsDate"]!
        self.mobilenumberverified = profileInfo["mobilenumberverified"]!
        self.profilecomplete = profileInfo["profilecomplete"]!
        self.rememberme = profileInfo["rememberme"]!
        self.socialmedialogintype = profileInfo["socialmedialogintype"]!
        self.updatedAt = profileInfo["updatedAt"]!
        self.userLoggedDates = profileInfo["userLoggedDates"]! as? [String : Any]
        self.username = profileInfo["username"]!
        self.weight = profileInfo["weight"]! as? [String : Any]
    }
}

