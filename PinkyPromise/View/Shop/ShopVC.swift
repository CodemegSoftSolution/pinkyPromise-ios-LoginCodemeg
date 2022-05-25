//
//  ShopVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 18/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

var totalCount : Int = 0

class ShopVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var cartCountBtn: Button!
    
    private var GetAllProductVM: GetAllProductViewModel = GetAllProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
        
        self.tblView.reloadData()
        
        totalCount = 0
        for item in self.GetAllProductVM.productList.value {
            totalCount = totalCount + item.cartCount
        }
        self.cartCountBtn.setTitle("\(totalCount)", for: .normal)
    }
    
    func configUI() {
        registerTableViewXib()
    
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshShopList), name: NSNotification.Name.init(NOTIFICATION.REFERESH_SHOP_LIST), object: nil)
        refreshShopList()
        
        GetAllProductVM.productList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.tblView.reloadData()
                
                totalCount = 0
                for item in self.GetAllProductVM.productList.value {
                    totalCount = totalCount + item.cartCount
                }
                self.cartCountBtn.setTitle("\(totalCount)", for: .normal)
            }
        }
    }

    @objc func refreshShopList() {
        GetAllProductVM.getAllProductList(request: ShopLanguageRequest(language: AppModel.shared.currentUser.userdata?.defaultLanguage ?? "en"))
    }

    //MARK: - Button Click
    @IBAction func clickToCart(_ sender: Any) {
        let vc = STORYBOARD.SHOP.instantiateViewController(withIdentifier: "YourCartVC") as! YourCartVC
        vc.GetAllProductVM = GetAllProductVM
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - TableView DataSource and Delegate Methods
extension ShopVC: UITableViewDataSource, UITableViewDelegate {
    func registerTableViewXib() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.ShopHomeTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.ShopHomeTVC.rawValue)
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GetAllProductVM.productList.value.count
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.ShopHomeTVC.rawValue, for: indexPath) as? ShopHomeTVC else { return UITableViewCell() }
        
        cell.productImgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: GetAllProductVM.productList.value[indexPath.row].productImage)
        
        cell.nameLbl.text = GetAllProductVM.productList.value[indexPath.row].productName
        cell.subLbl.text = GetAllProductVM.productList.value[indexPath.row].productDescriptionShort
        cell.priceLbl.text = "\(GetAllProductVM.productList.value[indexPath.row].currency) \(GetAllProductVM.productList.value[indexPath.row].unitPrice)"
        
        if GetAllProductVM.productList.value[indexPath.row].cartCount == 0 {
            cell.addCartBackView.isHidden = false
            cell.produictAddBackView.isHidden = true
        }
        else {
            cell.addCartBackView.isHidden = true
            cell.produictAddBackView.isHidden = false
        }
        
        cell.countLbl.text = "\(GetAllProductVM.productList.value[indexPath.row].cartCount)"
        
        cell.addToCartBtn.tag = indexPath.row
        cell.addToCartBtn.addTarget(self, action: #selector(self.clickToAddCard), for: .touchUpInside)
        
        cell.plusBtn.tag = indexPath.row
        cell.plusBtn.addTarget(self, action: #selector(self.clickToAddCardCount), for: .touchUpInside)
        
        cell.minusBtn.tag = indexPath.row
        cell.minusBtn.addTarget(self, action: #selector(self.clickToMinusCard), for: .touchUpInside)
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = STORYBOARD.SHOP.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
//        vc.GetAllProductVM = GetAllProductVM
        vc.GetAllListProductVM = GetAllProductVM
        vc.selectedIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickToAddCard(_ sender: UIButton) {
        GetAllProductVM.productList.value[sender.tag].cartCount = GetAllProductVM.productList.value[sender.tag].cartCount + 1
        GetAllProductVM.productList.value[sender.tag].totalAmount = GetAllProductVM.productList.value[sender.tag].cartCount * GetAllProductVM.productList.value[sender.tag].unitPrice
    }
    
    @objc func clickToAddCardCount(_ sender: UIButton) {
        GetAllProductVM.productList.value[sender.tag].cartCount = GetAllProductVM.productList.value[sender.tag].cartCount + 1
        GetAllProductVM.productList.value[sender.tag].totalAmount = GetAllProductVM.productList.value[sender.tag].cartCount * GetAllProductVM.productList.value[sender.tag].unitPrice
    }
    
    @objc func clickToMinusCard(_ sender: UIButton) {
        if GetAllProductVM.productList.value[sender.tag].cartCount != 0 {
            GetAllProductVM.productList.value[sender.tag].cartCount = GetAllProductVM.productList.value[sender.tag].cartCount - 1
            GetAllProductVM.productList.value[sender.tag].totalAmount = GetAllProductVM.productList.value[sender.tag].cartCount * GetAllProductVM.productList.value[sender.tag].unitPrice
        }
    }
}
