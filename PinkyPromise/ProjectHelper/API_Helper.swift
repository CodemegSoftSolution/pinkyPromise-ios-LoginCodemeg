//
//  API_Helper.swift
//  Trouvaille-ios
//
//  Created by MACBOOK on 01/04/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation

struct RAZORPAY_KEY {
    //Dev
    static let keyId = "rzp_test_iCRq80En3JBcoG"//"rzp_test_LRu3leWhtDRBmU"
    static let secretId = "f4jgZ6zJzo4KFOk4Qk0WGkeG"//"VTutPoPFOggUd1yFZjd39HGd"
    
    //Live
//    static let keyId = "rzp_live_gn9X9DdptwOUTJ"
//    static let secretId = "paMc4hIVrTANMenVls9B8d3l"
}

//MARK: - AppImageUrl
struct AppImageUrl {
    
    //Dev
    static let IMAGE_BASE = ""
}

//MARK: - API
struct API {
    
    //Local
//    static let BASE_URL = "http://db49-2405-201-1000-f1ca-5513-44ee-218f-7813.ngrok.io"
//    static let BASE = "/api/v1/user"
//    static let SOCKET_URL = "https://dev.askpinkypromise.com/"
    
    //Development 
    static let BASE_URL = "https://dev.askpinkypromise.com"
    static let BASE = "/api/v1/user"
    static let SOCKET_URL = "https://dev.askpinkypromise.com/"
        
    //Production
//    static let BASE_URL = "https://prod.askpinkypromise.com"
//    static let BASE = "/api/v1/user"
//    static let SOCKET_URL = "https://prod.askpinkypromise.com/"
    
    static let BASEPERIOD = "/api/peroidtracker"
    
    struct USER {
        static let login                  = BASE_URL + BASE + "/login"
        static let signUp                 = BASE_URL + BASE + "/signup"
        static let forgetPassword         = BASE_URL + BASE + "/forgetpassword"
        static let changePassword         = BASE_URL + BASE + "/changepassword"
        static let updateDeviceToken      = BASE_URL + "/notifications/UpdateDeviceToken"
        static let getProfile             = BASE_URL + BASE + "/getprofile"
        
        static let addLanguage            = BASE_URL + BASE + "/updatedefaultlanguage"
        static let verifyNumber           = BASE_URL + BASE + "/verifyphone"
        static let verifyOtp              = BASE_URL + BASE + "/verifyotp"
        static let createAccount          = BASE_URL + BASE + "/createaccount"
        static let VerifyReferalCode      = BASE_URL + "/referral/VerifyReferalCode"
        static let updateAppVersion       = BASE_URL + "/notifications/CheckUpdates"
    }
    
    struct CHATBOT {
        static let getTopicList           = BASE_URL + "/ChatBoat/getListTopics"
        static let getQuestion            = BASE_URL + "/ChatBoat/getQuestion"
        static let getDiagnosticResult    = BASE_URL + "/ChatBoat/getDiagnosticResult"
        static let getQuestion1           = BASE_URL + "/ChatBoat1/getQuestion"
        static let getDiagnosticResult1   = BASE_URL + "/ChatBoat1/getDiagnosis"
        static let getDiagnosticResultToDownload    = BASE_URL + "/ChatBoat/getDiagnosticResultToDownload"
    }
    
    struct CHATROOM {
        static let getListChatRooms       = BASE_URL + "/ChatRooms/getListChatRooms"
        static let getMyChatRooms         = BASE_URL + "/ChatRooms/getMyChatRooms"
        static let UpdateUserChatRoom     = BASE_URL + "/ChatRooms/updateUserChatRooms"
        static let getMessages            = BASE_URL + "/ChatRooms/getMessages"
        static let UpdateChatRoomActivity = BASE_URL + "/ChatRooms/UpdateChatRoomActivity"
        static let ChatroomsLikeUnlikeCapture       = BASE_URL + "/ChatRooms/ChatroomsLikeUnlikeCapture"
        static let getChatRoomsUnreadMsgCount       = BASE_URL + "/ChatRooms/getChatRoomsUnreadMsgCount"
    }
    
    struct SHOP {
        static let GetAllProducts         = BASE_URL + "/ecommerce/GetAllProducts"
        static let GenerateOrder          = BASE_URL + "/ecommerce/GenerateOrder"
        static let GetAllOrders           = BASE_URL + "/ecommerce/GetAllOrders"
        static let CancelOrder            = BASE_URL + "/ecommerce/CancelOrder"
        static let PaymentConfirmation    = BASE_URL + "/ecommerce/PaymentConfirmation"
        static let ApplyPromoCode         = BASE_URL + "/ecommerce/ApplyCouponCode"
    }

    struct BEDGES {
        static let AppOnOpen              = BASE_URL + "/rewards/AppOnOpen"
        static let AppOnClose             = BASE_URL + "/notifications/AppOnClose"
        static let AppInstalledFor30Days  = BASE_URL + "/rewards/AppInstalledFor30Days"
        static let gerUserTotalCoins      = BASE_URL + "/rewards/getUserTotalCoins"
        static let RedeemUserCoins        = BASE_URL + "/rewards/RedeemUserCoins"
        static let RedeemUserCoinsUpdate  = BASE_URL + "/rewards/RedeemUserCoinsUpdate"
        static let getUserBadges          = BASE_URL + "/rewards/getUserBadges"
        static let getListNewBadges       = BASE_URL + "/rewards/getListNewBadges"
        static let updateNewBadges        = BASE_URL + "/rewards/updateNewBadges"
        
        static let GenerateReferralCode   = BASE_URL + "/referral/GenerateReferralCode"
        static let updateRefereeCoinsFlag = BASE_URL + "/rewards/updateReferrerCoinsFlag" //"/rewards/updateRefereeCoinsFlag"
    }
    
    struct PERIODBASE {
        static let GetSymtoms             = BASE_URL + BASEPERIOD + "/get-symptoms-data"
        static let AddSysmptoms           = BASE_URL + BASEPERIOD + "/track-symptoms-data"
        static let GetUserInfo            = BASE_URL + BASEPERIOD + "/get-user-info"
    }
    
}
