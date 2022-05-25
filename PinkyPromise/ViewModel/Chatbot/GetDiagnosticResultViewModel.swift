//
//  GetDiagnosticResultViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 10/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation

struct GetDiagnosticResultViewModel {
    func getDiagnosticResult(request: GetDiagnosticRequest,_ completion: @escaping (_ response: DiagnosticResultResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATBOT.getDiagnosticResult, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(DiagnosticResultResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
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
    
    func getDiagnosticResultForFinalResult(request: GetDiagnosticRequest,_ completion: @escaping (_ response: FinalResultResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATBOT.getDiagnosticResult, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(FinalResultResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
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
    
    func getDiagnosticResultForCharBot1(request: GetDiagnosticRequest,_ completion: @escaping (_ response: DiagnosticChatRoom1ResultResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATBOT.getDiagnosticResult1, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(DiagnosticChatRoom1ResultResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
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
    
    func getDiagnosticResultForFinalCharBot1(request: GetDiagnosticRequest,_ completion: @escaping (_ response: FinalResultResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATBOT.getDiagnosticResult1, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(FinalResultResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
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
    
    
    func getDiagnosticResultForFinalForDiagnosis2CharBot1(request: GetDiagnosticRequest,_ completion: @escaping (_ response: DiagnosticChatRoom1ResultResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATBOT.getDiagnosticResult1, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(DiagnosticChatRoom1ResultResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
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
    
    
    func getDiagnosticFinalDiagnosis2CharBot1(request: GetDiagnosticRequest,_ completion: @escaping (_ response: FinalResultResponse) -> Void) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATBOT.getDiagnosticResult1, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(FinalResultResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        completion(success.self)
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
