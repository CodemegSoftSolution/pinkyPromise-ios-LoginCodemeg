//
//  DiagnosticResulDownloadViewModel.swift
//  PinkyPromise
//
//  Created by AkshCom on 31/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import Foundation


protocol DiagnosticResulDownloadDelegate {
    func didRecieveDiagnosticResulDownloadResponse(response: DiagnosisFinalPdfResponse)
}

struct DiagnosticResulDownloadViewModel {
    var delegate: DiagnosticResulDownloadDelegate?
    
    func getDiagnosticResult(request: GetDiagnosticPdf) {
        APIManager.sharedInstance.I_AM_COOL(params: request.toJSON(), api: API.CHATBOT.getDiagnosticResultToDownload, Loader: true, isMultipart: false) { (response) in
            if response != nil{                             //if response is not empty
                do {
                    let success = try JSONDecoder().decode(DiagnosisFinalPdfResponse.self, from: response!) // decode the response into model
                    switch success.status {
                    case 200:
                        self.delegate?.didRecieveDiagnosticResulDownloadResponse(response: success.self)
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
