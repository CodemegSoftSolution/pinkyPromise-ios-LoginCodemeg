//
//  YourCartVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 19/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit



class YourCartVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    @IBOutlet weak var totalCoinLbl: UILabel!
    
    @IBOutlet weak var promocodebackView: UIView!
    @IBOutlet weak var promoCodeTxt: TextField!
    @IBOutlet weak var successLbl: UILabel!
    
    var GetAllProductVM: GetAllProductViewModel = GetAllProductViewModel()
    var ProductCartList : [ProductListModel] = [ProductListModel]()
    private var BadgesVM: BadgesViewModel = BadgesViewModel()
    var totalBedgeData: TotalBedgesResponse = TotalBedgesResponse()
    var GenerateOrderVM: GenerateOrderViewModel = GenerateOrderViewModel()
    
    var totalEnterCoin: Int = 0
    var remainingCoin: Int = 0
    var currentIndex = 0
    
    var couponData: ApplyCouponResponse = ApplyCouponResponse()
    var isApplyCoupon: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }

    func configUI() {
        registerTableViewXib()
        getRewadPoint()
        successLbl.isHidden = true
        
        ProductCartList = GetAllProductVM.productList.value.filter( { $0.cartCount != 0 } )
        if ProductCartList.count != 0 {
            tblView.reloadData()
        }
        
        noDataLbl.isHidden = ProductCartList.count != 0 ? true : false
    }
    
    func getRewadPoint() {
        if let userData = AppModel.shared.currentUser.userdata {
            BadgesVM.serviceCallToGetUsersTotalCoin(request: BedgesAppRequest(UserID: userData.id)) { (response) in
                self.totalBedgeData = response
                self.remainingCoin = self.totalBedgeData.TotalCoins ?? 0
                
                if self.totalBedgeData.TotalCoins != 0 {
                    self.totalCoinLbl.text = "\(self.totalBedgeData.TotalCoins!)"
                }
                else {
                    self.totalCoinLbl.text = "0"
                }
                
                if self.ProductCartList.count != 0 {
                    for i in 0...self.ProductCartList.count - 1 {
                        if self.remainingCoin >= self.ProductCartList[i].unitPrice && self.remainingCoin != 0 {
                            self.ProductCartList[i].enterCoin = self.ProductCartList[i].unitPrice
                            self.remainingCoin = self.remainingCoin - self.ProductCartList[i].unitPrice
                        }
                        else{
                            self.ProductCartList[i].enterCoin = self.remainingCoin
                            self.remainingCoin = 0
                        }
                    }
                    self.totalEnterCoin = self.ProductCartList.map( { $0.enterCoin } ).reduce(0, {$0 + $1})
                    self.tblView.reloadData()
                }
            }
        }
    }

    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToCheckOut(_ sender: Any) {
        self.view.endEditing(true)
        if ProductCartList.count == 0 {
            return
        }
        
        let newCoin = self.ProductCartList.map( { $0.enterCoin } ).reduce(0, {$0 + $1})
        if newCoin <= self.totalBedgeData.TotalCoins! {
            
            if isApplyCoupon && couponData.result {
                let totalPaybleAmount = couponData.totalDiscountedAmount - totalEnterCoin
                if totalPaybleAmount < 0 {
                    displayToast("Please decrease the reedem coin")
                }
                else {
                    let vc = STORYBOARD.SHOP.instantiateViewController(withIdentifier: "OrderAllSummaryVC") as! OrderAllSummaryVC
                    vc.ProductCartList = ProductCartList
                    vc.totalBedgeData = totalBedgeData
                    vc.totalEnterCoin = totalEnterCoin
                    vc.isApplyCoupon = isApplyCoupon
                    vc.couponData = couponData
                    
                    if isApplyCoupon {
                        vc.couponCode = promoCodeTxt.text!.trimmed
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                let vc = STORYBOARD.SHOP.instantiateViewController(withIdentifier: "OrderAllSummaryVC") as! OrderAllSummaryVC
                vc.ProductCartList = ProductCartList
                vc.totalBedgeData = totalBedgeData
                vc.totalEnterCoin = totalEnterCoin
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else {
            displayToast("Please check coin you have entered. you have only \(self.totalBedgeData.TotalCoins!) coins.")
        }
    }
    
    func setMessageCode(message: String) -> String {
        if message == "Invalid Coupon Code" {
            return "Invalid code"
        }
        else if message == "1 item free offer applied" {
            return "Free intimate wash redeemed"
        }
        else if message == "50% discount applied" {
            return "50% off order value applied"
        }
        return message
    }
    
    @IBAction func clickToApplyPromoCode(_ sender: Any) {
        self.view.endEditing(true)
        guard let promoCode = promoCodeTxt.text else { return }

        if promoCode == DocumentDefaultValues.Empty.string {
            displayToast("Please enter promocode")
        }
        else{
            
            var purchaseProductArr: [ProductRequest] = [ProductRequest]()
            for item in ProductCartList {
                var product: ProductRequest = ProductRequest()
                product.productId = item.productID
                product.qty = item.cartCount
                product.reedemCoin = item.enterCoin
                purchaseProductArr.append(product)
            }
            
            var request = ApplyCouponRequest(CouponCode: promoCode, Products: purchaseProductArr)
            GenerateOrderVM.applyCoupon(request: request) { (response) in
                self.isApplyCoupon = true
                self.couponData = response
                self.successLbl.isHidden = false
                self.successLbl.text = self.setMessageCode(message: response.message) //response.message
            }
        }
    }
}


//MARK: - TableView DataSource and Delegate Methods
extension YourCartVC: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    func registerTableViewXib() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.CartTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.CartTVC.rawValue)
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductCartList.count
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.CartTVC.rawValue, for: indexPath) as? CartTVC else { return UITableViewCell() }
        
        cell.productImgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: ProductCartList[indexPath.row].imagesPath.first ?? "")
        
        cell.nameLbl.text = ProductCartList[indexPath.row].productName
        cell.subLbl.text = ProductCartList[indexPath.row].productDescriptionShort
        cell.priceLbl.text = "\(ProductCartList[indexPath.row].currency) \(ProductCartList[indexPath.row].unitPrice * ProductCartList[indexPath.row].cartCount)"
        
        cell.countLbl.text = "\(ProductCartList[indexPath.row].cartCount)"
        
        cell.coinCountTxt.text = "\(ProductCartList[indexPath.row].enterCoin)"
        if let txt = cell.viewWithTag(1) as? UITextField {
            txt.delegate = self
        }
        
//        if self.totalBedgeData.TotalCoins != 0 {
//            cell.coinCountTxt.isUserInteractionEnabled = true
//        }
//        else{
//            cell.coinCountTxt.isUserInteractionEnabled = false
//        }
        
        cell.plusBtn.tag = indexPath.row
        cell.plusBtn.addTarget(self, action: #selector(self.clickToAddCardCount), for: .touchUpInside)
        
        cell.minusBtn.tag = indexPath.row
        cell.minusBtn.addTarget(self, action: #selector(self.clickToMinusCard), for: .touchUpInside)
        
        cell.coinPlusBtn.tag = indexPath.row
        cell.coinPlusBtn.addTarget(self, action: #selector(self.clickToAddCoinBtn), for: .touchUpInside)
        
        cell.coinMinusBtn.tag = indexPath.row
        cell.coinMinusBtn.addTarget(self, action: #selector(self.clickToMinusCoinBtn), for: .touchUpInside)
        
        return cell
    }
    
    @objc func clickToAddCardCount(_ sender: UIButton) {
        ProductCartList[sender.tag].cartCount = ProductCartList[sender.tag].cartCount + 1
        ProductCartList[sender.tag].totalAmount = ProductCartList[sender.tag].cartCount * ProductCartList[sender.tag].unitPrice
        
        let index = GetAllProductVM.productList.value.firstIndex { (data) -> Bool in
            data.productID == ProductCartList[sender.tag].productID
        }
        if index != nil {
            GetAllProductVM.productList.value[index!].cartCount = ProductCartList[sender.tag].cartCount
            GetAllProductVM.productList.value[index!].totalAmount = GetAllProductVM.productList.value[index!].cartCount * GetAllProductVM.productList.value[index!].unitPrice
        }
        
        tblView.reloadData()
    }
    
    @objc func clickToMinusCard(_ sender: UIButton) {
        if ProductCartList[sender.tag].cartCount != 0 {
            ProductCartList[sender.tag].cartCount = ProductCartList[sender.tag].cartCount - 1
            ProductCartList[sender.tag].totalAmount = ProductCartList[sender.tag].cartCount * ProductCartList[sender.tag].unitPrice
            
            let index = GetAllProductVM.productList.value.firstIndex { (data) -> Bool in
                data.productID == ProductCartList[sender.tag].productID
            }
            if index != nil {
                GetAllProductVM.productList.value[index!].cartCount = ProductCartList[sender.tag].cartCount
                GetAllProductVM.productList.value[index!].totalAmount = GetAllProductVM.productList.value[index!].cartCount * GetAllProductVM.productList.value[index!].unitPrice
            }
            
            ProductCartList = ProductCartList.filter( { $0.cartCount != 0 } )
            getTotalEnterCoin()
            tblView.reloadData()
            noDataLbl.isHidden = ProductCartList.count != 0 ? true : false
        }
    }
    
    @objc func clickToAddCoinBtn(_ sender: UIButton) {
        if self.totalBedgeData.TotalCoins != 0 {
           
            if totalBedgeData.TotalCoins == totalEnterCoin {
                displayToast("You have no more coins")
                return
            }
            
            ProductCartList[sender.tag].enterCoin = ProductCartList[sender.tag].enterCoin + 1
            
            getTotalEnterCoin()
            tblView.reloadData()
        }
        else {
            displayToast("You have no coins")
        }
    }
    
    @objc func clickToMinusCoinBtn(_ sender: UIButton) {
        if self.totalBedgeData.TotalCoins != 0 {
            if ProductCartList[sender.tag].enterCoin != 0 {
                ProductCartList[sender.tag].enterCoin = ProductCartList[sender.tag].enterCoin - 1
                
                getTotalEnterCoin()
                tblView.reloadData()
            }
        }
        else {
            displayToast("You have no coins")
        }
    }
    
    func getTotalEnterCoin() {
        totalEnterCoin = 0
        
        for item in ProductCartList {
            if item.enterCoin != 0 {
                totalEnterCoin = totalEnterCoin + item.enterCoin
                print("*******\(totalEnterCoin)********")
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let btnPostion = textField.convert(CGPoint.zero, to: tblView)
        let indexPath = self.tblView.indexPathForRow(at: btnPostion)!
           currentIndex = (indexPath as NSIndexPath).row
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(currentIndex)
        print(textField.tag)
        print(textField.text!)
        
        ProductCartList[currentIndex].enterCoin = Int(textField.text!) ?? 0
        getTotalEnterCoin()
        
        return true
    }
    
}
