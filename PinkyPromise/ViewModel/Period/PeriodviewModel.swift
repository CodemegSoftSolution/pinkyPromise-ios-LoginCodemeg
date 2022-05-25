//
//  PeriodviewModel.swift
//  PinkyPromise
//
//  Created by Mithilesh kumar satnami on 21/05/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import Foundation
import Alamofire

struct PeriodtrackerViewModel {
    
    func getPeriodDetail(request: UserDetailRequest,_ completion: @escaping (_ response: UpdateProfileResponse) -> Void) {   //CreateAccountRequest
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.USER.getProfile, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(UpdateProfileResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
                      //  self.delegate?.didRecieveCreateAccountResponse(response: success.self)
                        break
                    default:
                        log.error("\(Log.stats()) \(success.message)")/
                    }
                }
                catch let err {
                    log.error("ERROR OCCURED WHILE DECODING: \(Log.stats()) \(err)")/
                }
            }
        }
    }

}


class AllApis {
    
    class func addSymptomsAPI(vc: UIViewController, url : URL, param: Parameters, completetionBlock: @escaping ([String : Any]?, _ error:NSError?) -> Void){

        CompletionHandler.handlerPostMethodAPI(url, parameter: param) { status, result, error  in
            if status == true{
                completetionBlock((result ),nil)
            }else{
                completetionBlock((nil ), error as NSError?)
            }
        }
    }
    
    class func getSymptomsAPI(vc: UIViewController, url: URL, parameters : Parameters, completetionBlock: @escaping ([String : Any]?, _ error:NSError?) -> Void){

        CompletionHandler.handlerPostMethodAPI(url, parameter: parameters) { status, result, error  in
            if status == true{
                completetionBlock((result ),nil)
            }else{
                completetionBlock((nil ), error as NSError?)
            }
        }
    }

    class func getUserInfoAPI(vc: UIViewController, url: URL, parameters : Parameters, completetionBlock: @escaping ([String : Any]?, _ error:NSError?) -> Void){

        CompletionHandler.handlerPostMethodAPI(url, parameter: parameters) { status, result, error  in
            if status == true{
                completetionBlock((result ),nil)
            }else{
                completetionBlock((nil ), error as NSError?)
            }
        }
    }

}

class CompletionHandler {
   class func handlerGetMethodAPI(_ url: URL, handler: @escaping (Bool, [String : Any]) -> Void) {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result
            {
            case .success(let json):
                if response.response?.statusCode == 200 {
                    handler(true, json as! [String : Any])
                } else {
                    handler(true, json as! [String : Any])
                }
                
                break;
            case .failure(let error):
                handler(false, error as! [String : Any])
                break
            }
        }
    }
    
    class func handlerPostMethodAPI(_ url: URL, parameter: Parameters, handler: @escaping (Bool, [String : Any]?, AFError?) -> Void) {
         AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { response in
             
             switch response.result
             {
             case .success(let json):
                 if response.response?.statusCode == 200 {
                     handler(true, json as? [String : Any], nil)
                 } else {
                     handler(true, json as? [String : Any], nil)
                 }
                 
                 break;
             case .failure(let error):
                 handler(false, nil, error)
                 break
             }
         }
     }
    
}
