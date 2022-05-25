//
//  PdfViewVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 14/11/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import WebKit

class PdfViewVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var fileName: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        if fileName != "" {
            let resourceDocPath = createFolderInDocumentDirectory()
            let pdfNameFromUrl = fileName
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            let request = URLRequest(url: actualPath)
            webView.load(request)
        }
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    

}
