//
//  CheckOutVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 21/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import Razorpay

class CheckOutVC: UIViewController {

    @IBOutlet weak var nameTxt: TextField!
    @IBOutlet weak var addressLine1Txt: TextField!
    @IBOutlet weak var addressLine2Txt: TextField!
    @IBOutlet weak var postalCodeTxt: TextField!
    @IBOutlet weak var cityTxt: TextField!
    @IBOutlet weak var stateTxt: TextField!
    @IBOutlet weak var continueBtn: Button!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    private var GenerateOrderVM: GenerateOrderViewModel = GenerateOrderViewModel()
    var ProductCartList : [ProductListModel] = [ProductListModel]()
    var razorpayObj : RazorpayCheckout? = nil
    var orderData: GenerateOrderResponse!
    var isFromProfile: Bool = false
    var redeemData: RedeemModel = RedeemModel()
    private var BadgesVM: BadgesViewModel = BadgesViewModel()
    
    var couponData: ApplyCouponResponse = ApplyCouponResponse()
    var isApplyCoupon: Bool = false
    var couponCode: String = ""
    var totalPurchaseAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    func configUI() {
        if getAddressData() != nil {
            nameTxt.text = getAddressData()?.name
            addressLine1Txt.text = getAddressData()?.addressLine1
            addressLine2Txt.text = getAddressData()?.addressLine2
            postalCodeTxt.text = getAddressData()?.pinCode
            cityTxt.text = getAddressData()?.city
            stateTxt.text = getAddressData()?.state
            
            saveBtn.isSelected = true
        }
        
        if isFromProfile {
            continueBtn.setTitle("Save", for: .normal)
        }
        else{
            continueBtn.setTitle("Countinue to Payment", for: .normal)
        }
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToSaveAddress(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender.isSelected {
            saveBtn.isSelected = false
        }
        else{
            saveBtn.isSelected = true
        }
    }
    
    @IBAction func clickToCountinuePayment(_ sender: Any) {
        self.view.endEditing(true)
        guard let name = nameTxt.text else { return }
        guard let address1 = addressLine1Txt.text else { return }
        guard let address2 = addressLine2Txt.text else { return }
        guard let postalCode = postalCodeTxt.text else { return }
        guard let city = cityTxt.text else { return }
        guard let state = stateTxt.text else { return }
        
        if name == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_name"))
        }
        else if address1 == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_addres_line1"))
        }
        else if postalCode == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_postalcode"))
        }
        else if city == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_city"))
        }
        else if state == DocumentDefaultValues.Empty.string {
            displayToast(getTranslate("enter_state"))
        }
        else{
            if isFromProfile {
                setAddressData(AddressRequest(name: name, addressLine1: address1, addressLine2: address2, city: city, state: state, pinCode: postalCode))
                self.navigationController?.popViewController(animated: true)
            }
            else{
                if ProductCartList.count != 0 {
                    if saveBtn.isSelected {
                        setAddressData(AddressRequest(name: name, addressLine1: address1, addressLine2: address2, city: city, state: state, pinCode: postalCode))
                    }
                    
                    var purchaseProductArr: [ProductRequest] = [ProductRequest]()
                    for item in ProductCartList {
                        var product: ProductRequest = ProductRequest()
                        product.productId = item.productID
                        product.qty = item.cartCount
                        product.totalPrice = (item.totalAmount * 100)
                        product.unitPrice = item.unitPrice
                        
                        purchaseProductArr.append(product)
                    }
                    
//                    let discountAmount = couponData.TotalAmount - couponData.totalDiscountedAmount
//
//                    var totalPaybleAmount = purchaseProductArr.map( {((($0.unitPrice ?? 0) * ($0.qty ?? 0)))} ).reduce(0, +)
//                    totalPaybleAmount = totalPaybleAmount - discountAmount - redeemData.coinsAmount
                    
                    let addressData = AddressModel(Address1: address1, Address2: address2, City: city, Name: name, PostalCode: postalCode, State: state)
                    var request = GenerateOrderRequest(UserID: AppModel.shared.currentUser.userdata?.id, Address: addressData, Products: purchaseProductArr, TotalOrderAmount: totalPurchaseAmount, RedeemedCoins: self.redeemData.coins)
                    
                    if isApplyCoupon {
                        request.CouponCode = couponCode
                        request.isCouponCodeVerified = couponData.isCouponCodeVerified
                    }
                    
                    GenerateOrderVM.getAllProductList(request: request) { (response) in
                        if response.data != nil {
                            self.orderData = response
                            
                            if self.orderData.data?.amount == 0 {
                                if self.orderData != nil {
                                    var requestData = PaymentOrderRequest(userId: AppModel.shared.currentUser.userdata?.id, orderId: self.orderData.orderID, paymentId: "", paymentSignature: "")
                                    
                                    if self.isApplyCoupon {
                                        requestData.CouponCode = self.couponCode
                                        requestData.isCouponCodeVerified = self.couponData.isCouponCodeVerified
                                    }
                                    
                                    self.GenerateOrderVM.paymentConfirmation(request: requestData) { (responseData) in
                                        displayToastWithDelay("Order Placed Successfully")
                                        print(responseData)
                                        self.BadgesVM.serviceCallToGetRedeemCoinUpdate(request: UpdateCoinRequest(UserID: AppModel.shared.currentUser.userdata!.id, RedeemedCoins: self.redeemData.coins)) { (response) in
                                            self.navigationController?.popToRootViewController(animated: true)
                                            NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFERESH_SHOP_LIST), object: nil)
                                            NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFERESH_COIN_COUNT), object: nil)
                                            NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex": 0])
                                            return
                                        }
                                    }
                                }
                            }
                            else{
                                self.openRazorpayCheckout(orderData: self.orderData)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func openRazorpayCheckout(orderData: GenerateOrderResponse) {
        if AppModel.shared.currentUser == nil {
            return
        }
         
        razorpayObj = RazorpayCheckout.initWithKey(RAZORPAY_KEY.keyId, andDelegate: self)
//        razorpayObj = RazorpayCheckout.initWithKey(RAZORPAY_KEY.keyId, andDelegateWithData: self)
        
//        var totalPurchaseAmount: Int = 0
//        if redeemData.coinsAmount != 0 {
//            totalPurchaseAmount = (orderData.data?.amount ?? 0) - (redeemData.coinsAmount * 100)
//        }
//        else {
//            totalPurchaseAmount = (orderData.data?.amount ?? 0)
//        }
        
        let options: [AnyHashable:Any] = [
            "prefill": [
                "contact": AppModel.shared.currentUser.userdata?.mobilenumber,
                "email": AppModel.shared.currentUser.userdata?.email
            ],
            "image" : UIImage.init(named: "logo"),
            "currency" : orderData.data?.currency,
           // "order_id" : orderData.id,
            "amount" : (totalPurchaseAmount * 100), //orderData.amount //
            "name": AppModel.shared.currentUser.userdata!.username,
            "theme": [
                "color": "#FF8E8C"
            ]
        ]
        if let rzp = self.razorpayObj {
            rzp.open(options)
        } else {
            print("Unable to initialize")
        }
    }
}

// RazorpayPaymentCompletionProtocol - This will execute two methods 1.Error and 2. Success case. On payment failure you will get a code and description. In payment success you will get the payment id.
extension CheckOutVC : RazorpayPaymentCompletionProtocol {
    
    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        displayToast(str)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        
        if payment_id != "" && orderData != nil {
            GenerateOrderVM.paymentConfirmation(request: PaymentOrderRequest(userId: AppModel.shared.currentUser.userdata?.id, orderId: orderData.data?.id, paymentId: payment_id, paymentSignature: "null", CouponCode: couponCode, isCouponCodeVerified: couponData.isCouponCodeVerified)) { (response) in
                displayToastWithDelay("Order Placed Successfully")
                print(response)
                
           //     if self.redeemData.coinsAmount != 0 {
                //    let totalcoinEnter: Int = self.ProductCartList.map( { $0.enterCoin } ).reduce(0, {$0 + $1})
                    
                    self.BadgesVM.serviceCallToGetRedeemCoinUpdate(request: UpdateCoinRequest(UserID: AppModel.shared.currentUser.userdata!.id, RedeemedCoins: self.redeemData.coins)) { (response) in
                        self.navigationController?.popToRootViewController(animated: true)
                        NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFERESH_SHOP_LIST), object: nil)
                        NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFERESH_COIN_COUNT), object: nil)
                        NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex": 0])
                        return
                    }
         //       }
                
//                delay(2) {
//                    self.navigationController?.popToRootViewController(animated: true)
//                }
            }
        }
    }
}


//// RazorpayPaymentCompletionProtocolWithData - This will returns you the data in both error and success case. On payment failure you will get a code and description. In payment success you will get the payment id.
//extension CheckOutVC: RazorpayPaymentCompletionProtocolWithData {
//
//    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
//        print("error: ", code)
//        displayToast(str)
//    }
//
//    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
//        print("success: ", payment_id)
//
//        let paymentId = response?["razorpay_payment_id"] as! String
//        let rezorSignature = response?["razorpay_signature"] as! String
//
//        if paymentId != "" && rezorSignature != "" {
//            GenerateOrderVM.paymentConfirmation(request: PaymentOrderRequest(userId: AppModel.shared.currentUser.userdata?.id, orderId: orderData.id, paymentId: paymentId, paymentSignature: rezorSignature)) { (response) in
//                displayToastWithDelay("Order Placed Successfully")
//                print(response)
//                self.BadgesVM.serviceCallToGetRedeemCoinUpdate(request: UpdateCoinRequest(UserID: AppModel.shared.currentUser.userdata!.id, RedeemedCoins: self.redeemData.coins)) { (response) in
//                    self.navigationController?.popToRootViewController(animated: true)
//                    NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFERESH_SHOP_LIST), object: nil)
//                    NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFERESH_COIN_COUNT), object: nil)
//                    NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex": 0])
//                    return
//                }
//            }
//        }
//    }
//}
