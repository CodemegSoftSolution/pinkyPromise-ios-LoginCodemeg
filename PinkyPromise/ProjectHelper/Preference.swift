//
//  Preference.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

class Preference: NSObject {

    static let sharedInstance = Preference()
    
    let IS_USER_LOGIN_KEY       =   "IS_USER_LOGIN"
    let IS_USER_SOCIAL_LOGIN_KEY  =   "IS_USER_SOCIAL_LOGIN"
    let USER_DATA_KEY           =   "USER_DATA"
    let IS_USER_INFO_SHOW       =   "IS_USER_INFO_SHOW"
    let PUSH_DEVICE_TOKEN       =   "PUSH_DEVICE_TOKEN"
    let ADDRESS_DATA            =   "ADDRESS_DATA"
    let SHARE_APP               =   "SHARE_APP"
    let SAVE_LOGIN_TIME         =   "SAVE_LOGIN_TIME"
    let TOPIC_DATA_ARRAY        =   "TOPIC_DATA_ARRAY"
    let TUTORIAL_INFO           =   "TUTORIAL_INFO"
}


func setDataToPreference(data: AnyObject, forKey key: String)
{
    UserDefaults.standard.set(data, forKey: MD5(key))
    UserDefaults.standard.synchronize()
}

func getDataFromPreference(key: String) -> AnyObject?
{
    return UserDefaults.standard.object(forKey: MD5(key)) as AnyObject?
}

func removeDataFromPreference(key: String)
{
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}

func removeUserDefaultValues()
{
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.synchronize()
}

//MARK: - Push notification device token
func setPushToken(_ token: String)
{
    setDataToPreference(data: token as AnyObject, forKey: Preference.sharedInstance.PUSH_DEVICE_TOKEN)
//    AppModel.shared.fcmToken = token
}

func getPushToken() -> String
{
    if let token : String = getDataFromPreference(key: Preference.sharedInstance.PUSH_DEVICE_TOKEN) as? String
    {
        let refreshToken = AppDelegate().sharedDelegate().getFCMToken()
        if refreshToken == token {
            return token
        }
        else {
            return refreshToken
        }
    }
    return AppDelegate().sharedDelegate().getFCMToken()
}

//MARK: - User login boolean
func setIsUserLogin(isUserLogin: Bool)
{
    setDataToPreference(data: isUserLogin as AnyObject, forKey: Preference.sharedInstance.IS_USER_LOGIN_KEY)
}

func isUserLogin() -> Bool
{
    let isUserLogin = getDataFromPreference(key: Preference.sharedInstance.IS_USER_LOGIN_KEY)
    return isUserLogin == nil ? false:(isUserLogin as! Bool)
}

func setLoginUserData(_ dictData: UserDataModel)
{
    print(dictData)
    UserDefaults.standard.set(encodable: dictData, forKey: Preference.sharedInstance.USER_DATA_KEY)
    setIsUserLogin(isUserLogin: true)
}

func getLoginUserData() -> UserDataModel?
{
    if let data = UserDefaults.standard.get(UserDataModel.self, forKey: Preference.sharedInstance.USER_DATA_KEY)
    {
        return data
    }
    return nil
}

//MARK: - User login boolean
func setIsSocialUser(isUserLogin: Bool)
{
    setDataToPreference(data: isUserLogin as AnyObject, forKey: Preference.sharedInstance.IS_USER_SOCIAL_LOGIN_KEY)
}

func isSocialUser() -> Bool
{
    let isSocialUser = getDataFromPreference(key: Preference.sharedInstance.IS_USER_SOCIAL_LOGIN_KEY)
    return isSocialUser == nil ? false:(isSocialUser as! Bool)
}


//MARK: - Show User Info
func setIsUserShownInfo(isUserLogin: Bool)
{
    UserDefaults.standard.set(encodable: isUserLogin, forKey: Preference.sharedInstance.IS_USER_INFO_SHOW)
}

func isUserShownInfo() -> Bool
{
    let isUserLogin = UserDefaults.standard.get(Bool.self, forKey: Preference.sharedInstance.IS_USER_INFO_SHOW)
    return (isUserLogin == nil ? false:(isUserLogin)) ?? false
}


func setAddressData(_ dictData: AddressRequest)
{
    print(dictData)
    UserDefaults.standard.set(encodable: dictData, forKey: Preference.sharedInstance.ADDRESS_DATA)
}

func getAddressData() -> AddressRequest?
{
    if let data = UserDefaults.standard.get(AddressRequest.self, forKey: Preference.sharedInstance.ADDRESS_DATA)
    {
        return data
    }
    return nil
}

//MARK: - User login boolean
func setIsShareApp(isUserLogin: Bool)
{
    setDataToPreference(data: isUserLogin as AnyObject, forKey: Preference.sharedInstance.SHARE_APP)
}

func isShareApp() -> Bool
{
    let isUserLogin = getDataFromPreference(key: Preference.sharedInstance.SHARE_APP)
    return isUserLogin == nil ? false:(isUserLogin as! Bool)
}

func setLoginTimeData(currentTime: Int)
{
    setDataToPreference(data: currentTime as AnyObject, forKey: Preference.sharedInstance.SAVE_LOGIN_TIME)
}

func getLoginTimeData() -> Int
{
    let currentTime = getDataFromPreference(key: Preference.sharedInstance.SAVE_LOGIN_TIME)
    return currentTime == nil ? 0:(currentTime as! Int)
    
//    if let data = UserDefaults.standard.get(Int.self, forKey: Preference.sharedInstance.SAVE_LOGIN_TIME)
//    {
//        return data
//    }
//    return 0
}



func setTopicDataArrayData(_ dictData: [TopicModel])
{
    print(dictData)
    UserDefaults.standard.set(encodable: dictData, forKey: Preference.sharedInstance.TOPIC_DATA_ARRAY)
}

func getTopicDataArrayData() -> [TopicModel]?
{
    if let data = UserDefaults.standard.get([TopicModel].self, forKey: Preference.sharedInstance.TOPIC_DATA_ARRAY)
    {
        return data
    }
    return nil
}

//MARK: - User login boolean
func setIsShowTutorial(isUserLogin: Bool)
{
    setDataToPreference(data: isUserLogin as AnyObject, forKey: Preference.sharedInstance.TUTORIAL_INFO)
}

func isShowTutorial() -> Bool
{
    let isSocialUser = getDataFromPreference(key: Preference.sharedInstance.TUTORIAL_INFO)
    return isSocialUser == nil ? false:(isSocialUser as! Bool)
}
