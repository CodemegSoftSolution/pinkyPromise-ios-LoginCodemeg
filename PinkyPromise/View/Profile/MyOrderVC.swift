//
//  MyOrderVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 23/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import Razorpay

class MyOrderVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    private var GetAllProductVM: GetAllProductViewModel = GetAllProductViewModel()
    private var MyOrderListVM: MyOrderListViewModel = MyOrderListViewModel()
    private var GenerateOrderVM: GenerateOrderViewModel = GenerateOrderViewModel()
    var selectedOrder: OrderModel!
    var razorpayObj : RazorpayCheckout? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        registerTableViewXib()
        noDataLbl.isHidden = true
        
        GetAllProductVM.getAllProductList(request: ShopLanguageRequest(language: AppModel.shared.currentUser.userdata?.defaultLanguage ?? "en"))
        
        GetAllProductVM.productList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                if AppModel.shared.currentUser != nil {
                    self.MyOrderListVM.getOrderProductList(request: MyOrderRequest(userId: AppModel.shared.currentUser.userdata?.id, nextIndex: 0, requiredProducts: 1000))
                }
            }
        }
        
        MyOrderListVM.productList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.tblView.reloadData()
                delay(0.1) {
                    self.tblView.reloadData()
                }
                
                self.noDataLbl.isHidden = self.MyOrderListVM.productList.value.count == 0 ? false : true
            }
        }
        
        MyOrderListVM.success.bind { [weak self](_) in
            guard let `self` = self else { return }
            if self.MyOrderListVM.success.value {
                self.tblView.reloadData()
//                if self.selectedOrder != nil {
//                    let index = self.MyOrderListVM.productList.value.firstIndex { (data) -> Bool in
//                        data.orderID == self.selectedOrder.orderID
//                    }
//                    if index != nil {
//                        self.MyOrderListVM.productList.value.remove(at: index!)
//                        self.tblView.reloadData()
//                    }
//                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }

    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK: - TableView DataSource and Delegate Methods
extension MyOrderVC: UITableViewDataSource, UITableViewDelegate {
    
    func registerTableViewXib() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.MyOrderTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.MyOrderTVC.rawValue)
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyOrderListVM.productList.value.count
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.MyOrderTVC.rawValue, for: indexPath) as? MyOrderTVC else { return UITableViewCell() }
        
        cell.orderLbl.text = "Order #\(MyOrderListVM.productList.value[indexPath.row].orderID)"
        cell.paymentStatusLbl.text = getStatus(MyOrderListVM.productList.value[indexPath.row].orderStatus)
        
        if MyOrderListVM.productList.value[indexPath.row].orderStatus == ORDER_STATUS.PENDING.rawValue || MyOrderListVM.productList.value[indexPath.row].orderStatus == ORDER_STATUS.FAILED.rawValue {
            cell.cancelBtn.isHidden = false
            cell.comfirmBtn.isHidden = false
        }
        else if MyOrderListVM.productList.value[indexPath.row].orderStatus == ORDER_STATUS.SUCCESS.rawValue || MyOrderListVM.productList.value[indexPath.row].orderStatus == ORDER_STATUS.CANCELLED.rawValue {
            cell.cancelBtn.isHidden = true
            cell.comfirmBtn.isHidden = true
        }
        else{
            cell.cancelBtn.isHidden = true
            cell.comfirmBtn.isHidden = true
        }
        
        if MyOrderListVM.productList.value[indexPath.row].products.count != 0 {
            if MyOrderListVM.productList.value[indexPath.row].products.count == 1 {
                cell.firstProductBackView.isHidden = false
                cell.secondProductBackView.isHidden = true
                
                if GetAllProductVM.productList.value.count != 0 {
                    let index = GetAllProductVM.productList.value.firstIndex { (data) -> Bool in
                        data.productID == MyOrderListVM.productList.value[indexPath.row].products[0].productID
                    }
                    if index != nil {
                        cell.product1ImgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: GetAllProductVM.productList.value[index!].productImage)
                        
                        cell.productn1NameLbl.text = GetAllProductVM.productList.value[index!].productName
                        cell.product1QuantityLbl.text = "Quantity : \(MyOrderListVM.productList.value[indexPath.row].products[0].qty)"
                        cell.product1AmountLbl.text = "\(MyOrderListVM.productList.value[indexPath.row].products[0].totalPrice)"
                    }
                }
            }
            else if MyOrderListVM.productList.value[indexPath.row].products.count == 2 {
                cell.firstProductBackView.isHidden = false
                cell.secondProductBackView.isHidden = false
                
                if GetAllProductVM.productList.value.count != 0 {
                    let index = GetAllProductVM.productList.value.firstIndex { (data) -> Bool in
                        data.productID == MyOrderListVM.productList.value[indexPath.row].products[0].productID
                    }
                    if index != nil {
                        cell.product1ImgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: GetAllProductVM.productList.value[index!].productImage)
                        
                        cell.productn1NameLbl.text = GetAllProductVM.productList.value[index!].productName
                        cell.product1QuantityLbl.text = "Quantity : \(MyOrderListVM.productList.value[indexPath.row].products[0].qty)"
                        cell.product1AmountLbl.text = "\(MyOrderListVM.productList.value[indexPath.row].products[0].totalPrice)"
                    }
                    
                    
                    let index1 = GetAllProductVM.productList.value.firstIndex { (data) -> Bool in
                        data.productID == MyOrderListVM.productList.value[indexPath.row].products[1].productID
                    }
                    if index != nil {
                        cell.product2ImgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: GetAllProductVM.productList.value[index1!].productImage)
                        
                        cell.product2NameLbl.text = GetAllProductVM.productList.value[index1!].productName
                        cell.product2QuantityLbl.text = "Quantity : \(MyOrderListVM.productList.value[indexPath.row].products[1].qty)"
                        cell.product2AmountLbl.text = "\(MyOrderListVM.productList.value[indexPath.row].products[1].totalPrice)"
                    }
                }
            }
            
            cell.cancelBtn.tag = indexPath.row
            cell.cancelBtn.addTarget(self, action: #selector(self.clickToCancelOrder), for: .touchUpInside)
            
            cell.comfirmBtn.tag = indexPath.row
            cell.comfirmBtn.addTarget(self, action: #selector(self.clickToConfirmPaymentOrder), for: .touchUpInside)
        }
        
        return cell
    }
    
    
    @objc func clickToCancelOrder(_ sender: UIButton) {
        selectedOrder = MyOrderListVM.productList.value[sender.tag]
        var param: [String: Any] = [String: Any]()
        param["UserID"] = AppModel.shared.currentUser.userdata?.id
        param["OrderID"] = MyOrderListVM.productList.value[sender.tag].orderID
        MyOrderListVM.cancelOrder(request: param) { (response) in
            displayToast(response.message)
            self.GetAllProductVM.getAllProductList(request: ShopLanguageRequest(language: AppModel.shared.currentUser.userdata?.defaultLanguage ?? "en"))
        }
    }
    
    @objc func clickToConfirmPaymentOrder(_ sender: UIButton) {
        selectedOrder = MyOrderListVM.productList.value[sender.tag]
        openRazorpayCheckout(orderData: MyOrderListVM.productList.value[sender.tag])
    }

    
    private func openRazorpayCheckout(orderData: OrderModel) {
        if AppModel.shared.currentUser == nil {
            return
        }
        
        // 1. Initialize razorpay object with provided key. Also depending on your requirement you can assign delegate to self. It can be one of the protocol from RazorpayPaymentCompletionProtocolWithData, RazorpayPaymentCompletionProtocol.
        // 2. When we use test id than order_id parameter must be comment
        
        razorpayObj = RazorpayCheckout.initWithKey(RAZORPAY_KEY.keyId, andDelegate: self)
        let options: [AnyHashable:Any] = [
            "prefill": [
                "contact": AppModel.shared.currentUser.userdata?.mobilenumber,
                "email": AppModel.shared.currentUser.userdata?.email
            ],
            "image" : UIImage.init(named: "logo"),
            "currency" : orderData.currency,
      //      "order_id" : orderData.id,
            "amount" : orderData.totalOrderAmount,
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
extension MyOrderVC : RazorpayPaymentCompletionProtocol {
    
    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        displayToast(str)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        
        GenerateOrderVM.paymentConfirmation(request: PaymentOrderRequest(userId: AppModel.shared.currentUser.userdata?.id, orderId: "\(selectedOrder.razorpayOrderID)", paymentId: payment_id)) { (response) in
            displayToastWithDelay("Order Placed Successfully")
            print(response)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}


// RazorpayPaymentCompletionProtocolWithData - This will returns you the data in both error and success case. On payment failure you will get a code and description. In payment success you will get the payment id.
extension MyOrderVC: RazorpayPaymentCompletionProtocolWithData {
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
        displayToast(str)
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        
        
    }
}
