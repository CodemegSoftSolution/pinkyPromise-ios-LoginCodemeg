//
//  OnboardingVC.swift
//  FootyBar
//
//  Created by iMac on 8/23/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController {
    
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var loginBtn: Button!
    @IBOutlet weak var btnSignUp: Button!
    
    var selectedPage = 0
    
    var yRef:CGFloat = 0
    var btnPrevius:UIButton = UIButton()
    var btnNext:UIButton = UIButton()
    
    var viewScrollView:UIScrollView = UIScrollView()
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var pageControl : UIPageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        self.screenDesigne()
    }
    
    func screenDesigne(){
        let viewBG:UIView = UIView()
        viewBG.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        viewBG.backgroundColor = UIColor.white
        self.view.addSubview(viewBG)
        
        viewScrollView = UIScrollView()
        viewScrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (screenHeight/2)+140)
        viewScrollView.delegate = self
        viewScrollView.backgroundColor = UIColor.clear
        viewScrollView.isPagingEnabled = true
        viewScrollView.showsHorizontalScrollIndicator = false
        viewScrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(viewScrollView)
        
        for index in 0..<3 {
            
            frame.origin.x = self.viewScrollView.frame.size.width * CGFloat(index)
            frame.size = self.viewScrollView.frame.size
            
            let shaplayer:CAShapeLayer = CAShapeLayer()
            
            let subView = UIView(frame: frame)
            subView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
            subView.clipsToBounds = true
            
            if (index == 0){
                
                let imgArrow:UIImageView = UIImageView()
                imgArrow.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
                imgArrow.contentMode = .scaleAspectFill
                imgArrow.backgroundColor = UIColor.clear
                imgArrow.image = UIImage.init(named: "image_1")
                subView.addSubview(imgArrow)
                
                let lblHEader:UILabel = UILabel()
                lblHEader.frame = CGRect(x: (screenWidth-210)/2.0, y: subView.frame.size.height-110, width: 210, height: 50)
                lblHEader.text = "WELCOME TO THE  FALLAH!"
                lblHEader.textAlignment = .center
                lblHEader.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14.0)
                lblHEader.textColor = ColorPink
                lblHEader.clipsToBounds = true
                lblHEader.numberOfLines = 2
                lblHEader.lineBreakMode = .byWordWrapping
                subView.addSubview(lblHEader)
                
                let lblSport:UILabel = UILabel()
                lblSport.frame = CGRect(x: 20, y: subView.frame.size.height-60, width: subView.frame.size.width-40, height: 30)
                lblSport.text = "We are a marketplace where you can find a service or provide it. Fallah is always free for clients."
                lblSport.textAlignment = .center
                lblSport.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14.0)
                lblSport.textColor = ColorGrayText
                lblSport.clipsToBounds = true
                lblSport.numberOfLines = 0
                lblSport.lineBreakMode = .byWordWrapping
                lblSport.sizeToFit()
                subView.addSubview(lblSport)
                
            }
            else if (index == 1){
                
                let imgArrow:UIImageView = UIImageView()
                imgArrow.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
                imgArrow.contentMode = .scaleAspectFit
                imgArrow.backgroundColor = UIColor.clear
                imgArrow.image = UIImage.init(named: "image_2")
                subView.addSubview(imgArrow)
                
                let lblHEader:UILabel = UILabel()
                lblHEader.frame = CGRect(x: (screenWidth-210)/2.0, y: subView.frame.size.height-110, width: 210, height: 50)
                lblHEader.text = "EASY TO USE"
                lblHEader.textAlignment = .center
                lblHEader.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14.0)
                lblHEader.textColor = ColorPink
                lblHEader.clipsToBounds = true
                lblHEader.numberOfLines = 2
                lblHEader.lineBreakMode = .byWordWrapping
                subView.addSubview(lblHEader)
                
                let lblSport:UILabel = UILabel()
                lblSport.frame = CGRect(x: 20, y: subView.frame.size.height-60, width: subView.frame.size.width-40, height: 30)
                lblSport.text = "The client can search for providers or browse them by categories."
                lblSport.textAlignment = .center
                lblSport.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14.0)
                lblSport.textColor = ColorGrayText
                lblSport.clipsToBounds = true
                lblSport.numberOfLines = 0
                lblSport.lineBreakMode = .byWordWrapping
                lblSport.sizeToFit()
                subView.addSubview(lblSport)
                
            }else if (index == 2){
                
                let imgArrow:UIImageView = UIImageView()
                imgArrow.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
                imgArrow.contentMode = .scaleAspectFit
                imgArrow.backgroundColor = UIColor.clear
                imgArrow.image = UIImage.init(named: "image_3")
                subView.addSubview(imgArrow)
                
                let lblHEader:UILabel = UILabel()
                lblHEader.frame = CGRect(x: (screenWidth-210)/2.0, y: subView.frame.size.height-110, width: 210, height: 50)
                lblHEader.text = "FAIR PAYMENT AND EVALUATION"
                lblHEader.textAlignment = .center
                lblHEader.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14.0)
                lblHEader.textColor = ColorPink
                lblHEader.clipsToBounds = true
                lblHEader.numberOfLines = 2
                lblHEader.lineBreakMode = .byWordWrapping
                subView.addSubview(lblHEader)
                
                let lblSport:UILabel = UILabel()
                lblSport.frame = CGRect(x: 20, y: subView.frame.size.height-60, width: subView.frame.size.width-40, height: 30)
                lblSport.text = "When the contract is completed, the money is released to the provider and them both have the option to rate each other."
                lblSport.textAlignment = .center
                lblSport.font = UIFont.init(name: FONT.Kurale.rawValue, size: 14.0)
                lblSport.textColor = ColorGrayText
                lblSport.clipsToBounds = true
                lblSport.numberOfLines = 0
                lblSport.lineBreakMode = .byWordWrapping
                lblSport.sizeToFit()
                subView.addSubview(lblSport)
                
            }
            
            self.viewScrollView .addSubview(subView)
        }
        
        pageControl.frame = CGRect(x: (screenWidth-200)/2.0,y: (screenHeight/2)+140, width:200, height:50)
        pageControl.isHidden = false
        
        self.viewScrollView.contentSize = CGSize(width:self.viewScrollView.frame.size.width * 3,height: self.viewScrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        configurePageControl()
                        
        let btnLogin: UIButton = UIButton()
        btnLogin.frame = CGRect(x: 20, y: (screenHeight/2)+200, width: screenWidth-40, height: 45)
        btnLogin.backgroundColor = ColorPink
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.setTitleColor(UIColor.white, for: .normal)
        btnLogin.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        btnLogin.layer.cornerRadius = 45/2
        btnLogin.clipsToBounds = true
        btnLogin.addTarget(self, action: #selector(self.btnLoginClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnLogin)
        
        let btnSignUp: UIButton = UIButton()
        btnSignUp.frame = CGRect(x: 20, y: (screenHeight/2)+260, width: screenWidth-40, height: 45)
        btnSignUp.backgroundColor = UIColor.white
        btnSignUp.setTitle("Sign Up", for: .normal)
        btnSignUp.setTitleColor(ColorPink, for: .normal)
        btnSignUp.titleLabel?.font = UIFont.init(name: FONT.Kurale.rawValue, size: 16.0)
        btnSignUp.layer.borderWidth = 2
        btnSignUp.layer.borderColor = ColorPink.cgColor
        btnSignUp.layer.cornerRadius = 45/2
        btnSignUp.clipsToBounds = true
        btnSignUp.addTarget(self, action: #selector(self.btnSignUpClicked(_:)), for: .touchUpInside)
        self.view.addSubview(btnSignUp)

    }
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * viewScrollView.frame.size.width
        viewScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray//248, 116, 38
        self.pageControl.currentPageIndicatorTintColor = ColorPink
        self.view.addSubview(pageControl)

    }

    override func viewWillAppear(_ animated: Bool) {
//        pageControll.currentPage = 0
//        infoCollectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
//        btnSignUp.borderColorTypeAdapter = 8
//        btnSignUp.borderWidth = 2
    }
    
    //MARK: - configUI
    private func configUI() {
        infoCollectionView.register(UINib(nibName: COLLECTION_VIEW_CELL.OnboardingCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.OnboardingCVC.rawValue)
        
        infoCollectionView.reloadData()
        delay(0.1) {
            DispatchQueue.main.async { [weak self] in
                self?.infoCollectionView.reloadData()
            }
        }
    }
    
    //MARK: - Button Click
    @objc func btnLoginClicked(_ sender: UIButton) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func btnSignUpClicked(_ sender: UIButton) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func clickToLogin(_ sender: Any) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToSignUp(_ sender: Any) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CollectionView Delegate & Datasource
extension OnboardingVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ONBOARDING.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.OnboardingCVC.rawValue, for: indexPath) as? OnboardingCVC else {
            return UICollectionViewCell()
        }
        
        cell.titleLbl.text = ONBOARDING_TITLE.list[indexPath.row]
        cell.subLbl.text = ONBOARDING.list[indexPath.row]
        cell.imgView.image = UIImage.init(named: ONBOARDING_IMG.list[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = infoCollectionView.bounds.width
        let itemHeight = infoCollectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension OnboardingVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.infoCollectionView.contentOffset, size: self.infoCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.infoCollectionView.indexPathForItem(at: visiblePoint) {
            self.pageControll.currentPage = visibleIndexPath.row
            selectedPage = visibleIndexPath.row
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        print(pageNumber)
    }
}
