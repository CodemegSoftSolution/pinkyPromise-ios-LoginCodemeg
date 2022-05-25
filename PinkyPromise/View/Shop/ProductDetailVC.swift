//
//  ProductDetailVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 18/10/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import Razorpay

class ProductDetailVC: UIViewController {

    @IBOutlet weak var topCollectionBackView: UIView!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var sliderCollecrtionView: UICollectionView!
     
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var feratureLbl: UILabel!
    @IBOutlet weak var instructionLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var cartCountBtn: Button!
    @IBOutlet weak var bottomBackView: UIView!
    @IBOutlet weak var addCartBtn: UIButton!
    @IBOutlet weak var discountOffLbl: UILabel!
    
    var GetAllProductVM: GetAllProductViewModel = GetAllProductViewModel()
    var GetAllListProductVM: GetAllProductViewModel = GetAllProductViewModel()
    var selectedIndex: Int = 0
    var ImageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        topCollectionView.register(UINib(nibName: COLLECTION_VIEW_CELL.HeaderCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.HeaderCVC.rawValue)
        sliderCollecrtionView.register(UINib(nibName: COLLECTION_VIEW_CELL.ImageCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.ImageCVC.rawValue)
        
        topCollectionView.reloadData()
        sliderCollecrtionView.reloadData()
        
        GetAllProductVM = GetAllListProductVM
        dataRender()
        
        discountOffLbl.text = ""
        
//        GetAllProductVM.productList.bind { [weak self](_) in
//            guard let `self` = self else { return }
//            DispatchQueue.main.async {
//                self.dataRender()
//            }
//        }
    }
    
    override func viewWillLayoutSubviews() {
        topCollectionBackView.setRoundCorners([.bottomLeft, .bottomRight], radius: 50)
        bottomBackView.setRoundCorners([.topLeft, .topRight], radius: 30)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
        
        totalCount = 0
        for item in self.GetAllProductVM.productList.value {
            totalCount = totalCount + item.cartCount
        }
        self.cartCountBtn.setTitle("\(totalCount)", for: .normal)

        countLbl.text = "\(GetAllProductVM.productList.value[selectedIndex].cartCount)"

        if GetAllProductVM.productList.value[selectedIndex].cartCount == 0 {
            addCartBtn.setTitle("Add to cart", for: .normal)
        }
        else{
            addCartBtn.setTitle("View cart", for: .normal)
        }
    }
    
    func dataRender() {
        if GetAllProductVM.productList.value.count != 0 {
            productNameLbl.text = GetAllProductVM.productList.value[selectedIndex].productName
            subLbl.text = GetAllProductVM.productList.value[selectedIndex].productDescriptionShort
            priceLbl.text = "\(GetAllProductVM.productList.value[selectedIndex].currency) \(GetAllProductVM.productList.value[selectedIndex].unitPrice)"
            
            feratureLbl.attributedText = GetAllProductVM.productList.value[selectedIndex].productDescription.html2AttributedString
            feratureLbl.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
            instructionLbl.attributedText = GetAllProductVM.productList.value[selectedIndex].productUsage.html2AttributedString
            instructionLbl.font = UIFont.init(name: FONT.Playfair.rawValue, size: 14.0)
            
            self.cartCountBtn.setTitle("\(totalCount)", for: .normal)
            
            topCollectionView.reloadData()
            sliderCollecrtionView.reloadData()
            delay(0.2) {
                DispatchQueue.main.async { [weak self] in
                    self?.topCollectionView.reloadData()
                    self?.sliderCollecrtionView.reloadData()
                }
            }
            
            countLbl.text = "\(GetAllProductVM.productList.value[selectedIndex].cartCount)"
            self.cartCountBtn.setTitle("\(totalCount)", for: .normal)
            
            if GetAllProductVM.productList.value[selectedIndex].cartCount == 0 {
                addCartBtn.setTitle("Add to cart", for: .normal)
            }
            else{
                addCartBtn.setTitle("View cart", for: .normal)
            }
        }
    }

    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        GetAllListProductVM = GetAllProductVM
    }
    
    @IBAction func clickToCart(_ sender: Any) {
        let vc = STORYBOARD.SHOP.instantiateViewController(withIdentifier: "YourCartVC") as! YourCartVC
        vc.GetAllProductVM = GetAllProductVM
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToAddCart(_ sender: Any) {
        if GetAllProductVM.productList.value[selectedIndex].cartCount == 0 {
        //    addCartBtn.setTitle("Add to cart", for: .normal)
            
            GetAllProductVM.productList.value[selectedIndex].cartCount = GetAllProductVM.productList.value[selectedIndex].cartCount + 1
            countLbl.text = "\(GetAllProductVM.productList.value[selectedIndex].cartCount)"
            GetAllProductVM.productList.value[selectedIndex].totalAmount = GetAllProductVM.productList.value[selectedIndex].cartCount * GetAllProductVM.productList.value[selectedIndex].unitPrice
            
            totalCount = 0
            for item in self.GetAllProductVM.productList.value {
                totalCount = totalCount + item.cartCount
            }
            
            countLbl.text = "\(GetAllProductVM.productList.value[selectedIndex].cartCount)"
            self.cartCountBtn.setTitle("\(totalCount)", for: .normal)
        }
        else{
        //    addCartBtn.setTitle("View cart", for: .normal)
            let vc = STORYBOARD.SHOP.instantiateViewController(withIdentifier: "YourCartVC") as! YourCartVC
            vc.GetAllProductVM = GetAllProductVM
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickToPlusMinus(_ sender: UIButton) {
        if sender.tag == 1 {
            GetAllProductVM.productList.value[selectedIndex].cartCount = GetAllProductVM.productList.value[selectedIndex].cartCount + 1
            GetAllProductVM.productList.value[selectedIndex].totalAmount = GetAllProductVM.productList.value[selectedIndex].cartCount * GetAllProductVM.productList.value[selectedIndex].unitPrice
        }
        else{
            if GetAllProductVM.productList.value[selectedIndex].cartCount != 0 {
                GetAllProductVM.productList.value[selectedIndex].cartCount = GetAllProductVM.productList.value[selectedIndex].cartCount - 1
                GetAllProductVM.productList.value[selectedIndex].totalAmount = GetAllProductVM.productList.value[selectedIndex].cartCount * GetAllProductVM.productList.value[selectedIndex].unitPrice
            }
        }
        
        totalCount = 0
        for item in self.GetAllProductVM.productList.value {
            totalCount = totalCount + item.cartCount
        }
        
        countLbl.text = "\(GetAllProductVM.productList.value[selectedIndex].cartCount)"
        self.cartCountBtn.setTitle("\(totalCount)", for: .normal)
        
        if GetAllProductVM.productList.value[selectedIndex].cartCount == 0 {
            addCartBtn.setTitle("Add to cart", for: .normal)
        }
        else{
            addCartBtn.setTitle("View cart", for: .normal)
        }
    }
}


//MARK: - CollectionView Delegate & Datasource
extension ProductDetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GetAllProductVM.productList.value[selectedIndex].imagesPath.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollectionView {
            guard let cell = topCollectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.HeaderCVC.rawValue, for: indexPath) as? HeaderCVC else {
                return UICollectionViewCell()
            }
            
            cell.imgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: GetAllProductVM.productList.value[selectedIndex].imagesPath[indexPath.row])            
            
            return cell
        }
        else{
            guard let cell = sliderCollecrtionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.ImageCVC.rawValue, for: indexPath) as? ImageCVC else {
                return UICollectionViewCell()
            }
            
            if ImageIndex == indexPath.row {
                cell.backView.applyShadow = true
            }
            else {
                cell.backView.applyShadow = false
            }
            
            cell.imgView.downloadCachedImage(placeholder: PLACEHOLDER.image_place.getValue(), urlString: GetAllProductVM.productList.value[selectedIndex].imagesPath[indexPath.row])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sliderCollecrtionView {
            ImageIndex = indexPath.row
            topCollectionView.scrollToItem(at: IndexPath.init(row: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollectionView {
            let itemWidth = topCollectionView.bounds.width
            let itemHeight = topCollectionView.bounds.height
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else{
//            let itemWidth = sliderCollecrtionView.bounds.width
//            let itemHeight = sliderCollecrtionView.bounds.height
            return CGSize(width: 80, height: 70)
        }
    }
}

extension ProductDetailVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.topCollectionView.contentOffset, size: self.topCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.topCollectionView.indexPathForItem(at: visiblePoint) {
            ImageIndex = visibleIndexPath.row
            sliderCollecrtionView.reloadData()
        }
    }
}

