//
//  AppEnums.swift
//  TBC
//
//  Created by MACBOOK on 12/05/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

//MARK: - TABLE_VIEW_CELL
enum TABLE_VIEW_CELL: String {
    case ClubTVC, ChatbotResultTVC, ProfileTVC, AnswerTVC, ChatGroupTVC, SenderMessageTVC, ReceiverMessageTVC, ChatRoomDropDownTVC, ShopHomeTVC, CartTVC, MyOrderTVC, EarnCoinTVC, FaqListTVC, HowItsWorkTVC, OrderSummaryVC
}

//MARK: - TABLE_VIEW_CELL
enum COLLECTION_VIEW_CELL: String {
    case OnboardingCVC, HomeCVC, ImageCVC, HeaderCVC, MyBedgeCVC, ReddemPointCVC, TrackCVC
}

//MARK: USER_DEFAULT_KEYS
enum USER_DEFAULT_KEYS: String {
    case chatCount
}

//MARK: - GENDER_TYPE
enum GENDER_TYPE: Int {
    case male = 1
    case female = 2
    case other = 3
}

//MARK: - LANGUAGE
enum LANGUAGE: String {
    case English = "en"
    case Hindi = "hi"
}

enum FONT: String {
    case Playfair = "Playfair Display"
    case Kurale = "Kurale"
}

//MARK: - STATIC_LABELS
enum STATIC_LABELS: String {
    case cancel = "Cancel"
    case reportPost = "Report this post"
    case image = "image"
    case noDataFound = "No Data Found."
}

//MARK: - ITEM_TYPE
enum ONBOARDING_TITLE:String, CaseIterable {
    case SCREEN1 = "Chat with Pinky"
    case SCREEN2 = "Connect with others"
    case SCREEN3 = "It’s our secret"
    
    static var list: [String] {
      return ONBOARDING_TITLE.allCases.map { $0.rawValue }
    }
}

enum ONBOARDING:String, CaseIterable {
    case SCREEN1 = "Get immediate, confidential answers to all reproductive health questions"
    case SCREEN2 = "Join issue specific chat groups to find support and not go through anything alone"
    case SCREEN3 = "We are against judgement! Access a world of reproductive health just for you, in a highly confidential setting"
    
    static var list: [String] {
      return ONBOARDING.allCases.map { $0.rawValue }
    }
}

enum ONBOARDING_IMG:String, CaseIterable {
    case SCREEN1 = "image_8"
    case SCREEN2 = "image_2"
    case SCREEN3 = "image_3"
    
    static var list: [String] {
      return ONBOARDING_IMG.allCases.map { $0.rawValue }
    }
}

enum HOME_IMG:String, CaseIterable {
    case HOME1 = "Group1"
    case HOME2 = "Group2"
    case HOME3 = "Group3"
    case HOME4 = "Group4"
    case HOME5 = "Group5"
    case HOME6 = "Group6"
    case HOME7 = "Group7"
    
    static var list: [String] {
      return HOME_IMG.allCases.map { $0.rawValue }
    }
}

enum PROFILE:String, CaseIterable {
    case PROFILE1 = "Reward Zone"
    case PROFILE2 = "Refer & Earn"
    case PROFILE3 = "Language"
    case PROFILE4 = "Terms Of Service"
    case PROFILE5 = "Privacy Policy"
    case PROFILE6 = "Orders"
    case PROFILE7 = "Addresses"
    case PROFILE8 = "Contact Us"
    case PROFILE9 = "Log-out"
    
//    case PROFILE1 = "Language"
//    case PROFILE2 = "Terms Of Service"
//    case PROFILE3 = "Privacy Policy"
//    case PROFILE4 = "Orders"
//    case PROFILE5 = "Rewards"
//    case PROFILE6 = "Addresses"
//    case PROFILE7 = "Contact Us"
//    case PROFILE8 = "Refer & Earn"
//    case PROFILE9 = "Log-out"
    
    
    static var list: [String] {
      return PROFILE.allCases.map { $0.rawValue }
    }
}

enum PROFILE_IMG:String, CaseIterable {
    case PROFILE1 = "reward_zone"
    case PROFILE2 = "refer_share"
    case PROFILE3 = "language"
    case PROFILE4 = "terms"
    case PROFILE5 = "privacy"
    case PROFILE6 = "orders"
    case PROFILE7 = "address"
    case PROFILE8 = "contact"
    case PROFILE9 = "logout"
    
//    case PROFILE1 = "language"
//    case PROFILE2 = "terms"
//    case PROFILE3 = "privacy"
//    case PROFILE4 = "orders"
//    case PROFILE5 = "orders1"
//    case PROFILE6 = "address"
//    case PROFILE7 = "contact"
//    case PROFILE8 = "refer"
//    case PROFILE9 = "logout"
    
    
    static var list: [String] {
      return PROFILE_IMG.allCases.map { $0.rawValue }
    }
}

enum CHAT_IMG:String, CaseIterable {
    case CHAT1 = "noun_fetus_3331411"
    case CHAT2 = "noun_wellness_924455"
    case CHAT3 = "noun_ovary_230343"
    case CHAT4 = "noun_Uterus_2549850"
    
    static var list: [String] {
      return CHAT_IMG.allCases.map { $0.rawValue }
    }
}


enum ORDER_STATUS:String, CaseIterable {
    case PENDING = "PAYMENT_PENDING"
    case SUCCESS = "PAYMENT_SUCCESS"
    case FAILED = "PAYMENT_FAILED"
    case CANCELLED = "ORDER_CANCELLED"
    
}


func getStatus(_ status: String) -> String {
    switch status {
    case ORDER_STATUS.PENDING.rawValue:
        return "Payment Pending"
    case ORDER_STATUS.SUCCESS.rawValue:
        return "Payment Succeeded"
    case ORDER_STATUS.FAILED.rawValue:
        return "Payment Failed"
    case ORDER_STATUS.CANCELLED.rawValue:
        return "Order Cancelled"
    default:
        return status
    }
}

//MARK: - ITEM_TYPE
enum BADGES_NAME :String, CaseIterable {
    case BADGE1 = "Hachiko memorial"
    case BADGE2 = "Florence Nightingale"
    case BADGE3 = "Kylie Jenner"
    
    static var list: [String] {
        return BADGES_NAME.allCases.map { $0.rawValue }
    }
}

func getImageFromBadges(_ name: String) -> String {
    if name == "Hachiko memorial" {
        return "reward2"
    }
    else if name == "Florence Nightingale" {
        return "reward4"
    }
    else if name == "Kylie Jenner" {
        return "reward3"
    }
    return ""
}

func getGrayImageFromBadges(_ name: String) -> String {
    if name == "Hachiko memorial" {
        return "reward_gray2"
    }
    else if name == "Florence Nightingale" {
        return "reward_gray4"
    }
    else if name == "Kylie Jenner" {
        return "reward_gray3"
    }
    return ""
}
