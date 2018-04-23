//
//  ShopDetailViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/12.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///商品详情
import UIKit

class ShopDetailViewController: BaseViewController {

    lazy var contentScrollView = { () -> UIScrollView in
        let scroll = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: self.view.height - 60))
        scroll.contentSize = CGSize.init(width: SCREEN_Width, height: self.view.height)
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        self.view.addSubview(scroll)
        scroll.backgroundColor = UIColor.clear
        return scroll
    }()
    
    lazy var slideView = { () -> SlideshowView in 
        let slide = SlideshowView.slideshowViewWithFrame(CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 300), imageURLPaths: ["MacBook Pro 新款15寸 3 mbl","MacBook Pro 新款15寸 3 mbl","MacBook Pro 新款15寸 3 mbl"], titles: nil, didSelectItemAtIndex: { (index) in
            
        })
        slide.imageViewContentMode = .scaleAspectFit
        slide.pageControlCurrentPageColor = UIColor.black
        slide.pageControlBottom = 40
        slide.autoScrollTimeInterval = 0
        slide.backgroundColor = UIColor.white
        contentScrollView.addSubview(slide)
        return slide
    }()
    
    lazy var shopNameLable = { () -> UILabel in
        let lable = UILabel.init()
        shopNameSuperView.addSubview(lable)
        lable.numberOfLines = 0
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.backgroundColor = UIColor.white
        lable.textColor = UIColor.black
        return lable
    }()
    lazy var shopNameSuperView = { () -> UIView in
        let v = UIView.init()
        contentScrollView.addSubview(v)
        v.backgroundColor = UIColor.white
        return v
    }()
    
    lazy var typeBtn = { () -> XButton in
        let btn = XButton.init()
        typeBtnSuperView.addSubview(btn)
        btn.block = {
            let p = ProductTypesView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 500))
            PopView.show(view: p, isAnmation: true)
        }
        btn.setTitle("选择商品款型", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setImage(UIImage.init(named: "path"), for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.position = .left
        return btn
    }()
    lazy var typeBtnSuperView = { () -> UIView in
        let v = UIView.init()
        contentScrollView.addSubview(v)
        v.backgroundColor = UIColor.white
        return v
    }()
    
    lazy var bottomView = { () -> ConfirmView in
        let v = ConfirmView.initFormNib() as! ConfirmView
        v.frame = CGRect.init(x: 0, y: self.view.height - 80, width: SCREEN_Width, height: 80)
        self.view.addSubview(v)
        v.delegate = self
        v.backgroundColor = UIColor.white
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = xlightGray
        loadData()
        
    }
    var productModel: ProductModel!
    
    ///加载网络数据
    func loadData() {
        let param = ["productId" : "24"]
        Network.dataRequest(url: Url.getShopInformation(), param: param, reqmethod: .GET) { (result) in
            if result?.code == 1 {
                if let data = result?.responseDic["data"] as?  [[String:Any]] {
                    ///只有一个元素
                    
                self.productModel = ProductModel.deserialize(from: data.last)!
                  self.reloadAllData()
                }
            }
        }
    }
    
    ///刷新界面数据
    func reloadAllData() {
        self.title = productModel.productName
        
        shopNameLable.text = productModel.describe
        bottomView.loadData(models: productModel.goodsList!)
        shopNameSuperView.mas_makeConstraints { (make) in
            make?.top.equalTo()(slideView.mas_bottom)?.offset()(2)
            make?.left.equalTo()(self.view.mas_left)
            make?.right.equalTo()(self.view.mas_right)
            make?.height.equalTo()(shopNameLable.text!.getTextSize(font: 14).height + 40)
            
        }
        
        shopNameLable.mas_makeConstraints { (make) in
            make?.top.equalTo()(slideView.mas_bottom)?.offset()(2)
            make?.left.equalTo()(self.view.mas_left)?.offset()(20)
            make?.right.equalTo()(self.view.mas_right)?.offset()(-20)
            make?.height.equalTo()(shopNameLable.text!.getTextSize(font: 14).height + 40)
            
        }
        
        typeBtnSuperView.mas_makeConstraints { (make) in
            make?.top.equalTo()(shopNameSuperView.mas_bottom)?.offset()(2)
            make?.left.equalTo()(self.view.mas_left)
            make?.right.equalTo()(self.view.mas_right)
            make?.height.equalTo()(50)
            
        }
        typeBtn.mas_makeConstraints { (make) in
            make?.top.equalTo()(shopNameSuperView.mas_bottom)?.offset()(2)
            make?.left.equalTo()(self.view.mas_left)?.offset()(20)
            make?.right.equalTo()(self.view.mas_right)?.offset()(-20)
            make?.height.equalTo()(50)
            
        }
        bottomView.backgroundColor = UIColor.white
        
        let describeView = ShopDetailDescribeView.init()
        
        self.contentScrollView.addSubview(describeView)
        describeView.mas_makeConstraints { (make) in
            make?.top.equalTo()(typeBtn.mas_bottom)?.offset()(15)
            make?.left.equalTo()(self.view.mas_left)
            make?.right.equalTo()(self.view.mas_right)
            make?.height.equalTo()(500)
            
        }
        
    }
    
}

extension ShopDetailViewController: ConfirmViewDelegate{
    func didConfirm() {
        let vc = PurchaseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
