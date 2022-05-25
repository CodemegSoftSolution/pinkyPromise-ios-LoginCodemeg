//
//  OrderAllSummaryVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 30/01/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit

class OrderAllSummaryVC: UIViewController {

    @IBOutlet weak var totalItemLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var product1BackView: UIView!
    @IBOutlet weak var product1ImgView: ImageView!
    @IBOutlet weak var product1NameLbl: UILabel!
    @IBOutlet weak var product1QuantityLbl: UILabel!
    @IBOutlet weak var product1PriceLbl: UILabel!
    
    @IBOutlet weak var product2BackView: UIView!
    @IBOutlet weak var product2ImgView: ImageView!
    @IBOutlet weak var product2NameLbl: UILabel!
    @IBOutlet weak var product2QuantityLbl: UILabel!
    @IBOutlet weak var product2PriceLbl: UILabel!
    
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var totalCoinLbl: UILabel!
    @IBOutlet weak var promoCodeDiscountLbl: UILabel!
    @IBOutlet weak var finalTotalLbl: UILabel!
    
    private var BadgesVM: BadgesViewModel = BadgesViewModel()
    var ProductCartList : [ProductListModel] = [ProductListModel]()
    var totalBedgeData: TotalBedgesResponse = TotalBedgesResponse()
    var redeemData: RedeemModel = RedeemModel()
    var totalEnterCoin: Int = 0
    
    var couponData: ApplyCouponResponse = ApplyCouponResponse()
    var isApplyCoupon: Bool = false
    var couponCode: String = ""
    var totalPurchaseAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        product1BackView.isHidden = true
        product2BackView.isHidden = true
        
        registerTableViewXib()
        
        if let userData = AppModel.shared.currentUser.userdata {
            BadgesVM.serviceCallToGetRedeemUserCoin(request: BedgesAppRequest(UserID: userData.id, RedeemCoins : totalEnterCoin)) { (response) in
                print(response)
                self.redeemData = response
                
                self.dataRender()
            }
        }
    }
    
    func dataRender() {
        if ProductCartList.count != 0 {
//            product1BackView.isHidden = true
//            product2BackView.isHidden = true
            
            
//            product1BackView.isHidden = false
//            product1ImgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: ProductCartList[0].imagesPath.first ?? "")
//            product1NameLbl.text = ProductCartList[0].productName
//            product1QuantityLbl.text = "\(ProductCartList[0].cartCount)"
//            product1PriceLbl.text = "\(ProductCartList[0].currency) \(ProductCartList[0].unitPrice * ProductCartList[0].cartCount)"
//
//            if ProductCartList.count == 2 {
//                product2BackView.isHidden = false
//                product2ImgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: ProductCartList[1].imagesPath.first ?? "")
//                product2NameLbl.text = ProductCartList[1].productName
//                product2QuantityLbl.text = "\(ProductCartList[1].cartCount)"
//                product2PriceLbl.text = "\(ProductCartList[1].currency) \(ProductCartList[1].unitPrice * ProductCartList[1].cartCount)"
//            }
            
            updateTblHeight()
            
            let totalAmout: Int = ProductCartList.map( { $0.totalAmount } ).reduce(0, {$0 + $1})
            subTotalLbl.text = "\(ProductCartList[0].currency) \(totalAmout)"
            
    //        let totalcoinEnter: Int = ProductCartList.map( { $0.enterCoin } ).reduce(0, {$0 + $1})
            totalCoinLbl.text = "\(ProductCartList[0].currency) \(redeemData.coinsAmount)"
            finalTotalLbl.text = "\(ProductCartList[0].currency) \(totalAmout - redeemData.coinsAmount)"
            
            totalPurchaseAmount = totalAmout - redeemData.coinsAmount
            
            if isApplyCoupon {
                let totalPaybleAmount = couponData.TotalAmount - couponData.totalDiscountedAmount
                promoCodeDiscountLbl.text = "\(ProductCartList[0].currency) \(totalPaybleAmount)"
                
                finalTotalLbl.text = "\(ProductCartList[0].currency) \(totalAmout - redeemData.coinsAmount - totalPaybleAmount)"
                totalPurchaseAmount = totalAmout - redeemData.coinsAmount - totalPaybleAmount
            }
        }
    }

    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToEditOrder(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToCheckout(_ sender: Any) {
        let vc = STORYBOARD.SHOP.instantiateViewController(withIdentifier: "CheckOutVC") as! CheckOutVC
        vc.ProductCartList = ProductCartList
        vc.redeemData = redeemData
        vc.isApplyCoupon = isApplyCoupon
        vc.couponData = couponData
        vc.couponCode = couponCode
        vc.totalPurchaseAmount = totalPurchaseAmount
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - TableView DataSource and Delegate Methods
extension OrderAllSummaryVC: UITableViewDataSource, UITableViewDelegate {
    
    func registerTableViewXib() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.OrderSummaryVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.OrderSummaryVC.rawValue)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.OrderSummaryVC.rawValue, for: indexPath) as? OrderSummaryVC else { return UITableViewCell() }
        
        cell.productImgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: ProductCartList[indexPath.row].imagesPath.first ?? "")
        cell.productNameLbl.text = ProductCartList[indexPath.row].productName
        cell.productQuantityLbl.text = "\(ProductCartList[indexPath.row].cartCount)"
        cell.productPriceLbl.text = "\(ProductCartList[indexPath.row].currency) \(ProductCartList[indexPath.row].unitPrice * ProductCartList[indexPath.row].cartCount)"
        
        return cell
    }
    
    func updateTblHeight() {
        tblViewHeightConstraint.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        tblViewHeightConstraint.constant = tblView.contentSize.height
    }
}
