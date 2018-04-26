//
//  ShopDetailViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/12.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///商品详情
import UIKit
import WebKit

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
    
    lazy var headerWebView = { () -> UIWebView in
        
        let web = UIWebView.init()
        web.scalesPageToFit = true
        web.delegate = self
        web.backgroundColor = xlightGray
        contentView.addSubview(web)
        return web
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
        contentView.addSubview(v)
        v.backgroundColor = UIColor.white
        return v
    }()
    
    lazy var typeBtn = { () -> XButton in
        let btn = XButton.init()
        typeBtnSuperView.addSubview(btn)
        btn.block = {
            let p = ProductTypesView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 500))
            p.setModel(model: self.productModel)
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
        contentView.addSubview(v)
        v.backgroundColor = UIColor.white
        return v
    }()
    
    ///底部价钱信息视图
    lazy var bottomView = { () -> ConfirmView in
        let v = ConfirmView.initFormNib() as! ConfirmView
        v.frame = CGRect.init(x: 0, y: self.view.height - 80, width: SCREEN_Width, height: 80)
        self.view.addSubview(v)
        v.delegate = self
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingStatus = .loading
        
        self.view.backgroundColor = xlightGray
        
        loadData()
        
    }
    
    var productModel: ProductModel!
    ///进入详情必须传的商品信息模型
    var shopModel: ShopModel!
    ///详情页里加载web的模型数据
    var webModel: [ShopDetailWebModel] = [] {
        didSet{
            for model in webModel {
                if model.contentLocationType == "BANNER" {
                    self.headerWebView.loadHTMLString(model.content, baseURL: nil)
                }
            }
            if describeView != nil {
                describeView.setWebModel(model: webModel)
            }
            
        }
    }
    
    ///加载网络数据
    func loadData() {
        let param = ["productId" : shopModel.productId]
        Network.dataRequest(url: Url.getShopInformation(), param: param, reqmethod: .GET) { (result) in
            if result?.code == 1 {

                if let data = result?.responseDic["data"] as?  [[String:Any]] {
                    ///只有一个元素

                    if let model = ProductModel.deserialize(from: data.last) {
                        self.productModel = model
                        self.reloadAllData()
                        self.loadingStatus = .normal
                    }
                }
                else {
                    self.loadingStatus = .error
                }
            } else {
                self.loadingStatus = .error
            }
        }
        
    }
    var contentView: UIView!
    
    ///刷新界面数据
    func reloadAllData() {
        self.title = productModel.productName
        
        contentScrollView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
        
        contentView = UIView.init()
        contentScrollView.addSubview(contentView)
        contentView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(contentScrollView)
            make?.center.equalTo()(self.view.center)
        }
        
        headerWebView.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.view.mas_right)
            make?.top.equalTo()(self.contentScrollView.mas_top)
            make?.left.equalTo()(self.view.mas_left)
            make?.height.equalTo()(300)
        }
        
        shopNameLable.text = productModel.describe
        bottomView.loadData(models: productModel.goodsList)
        
        shopNameSuperView.mas_makeConstraints { (make) in
            make?.top.equalTo()(headerWebView.mas_bottom)?.offset()(2)
            make?.left.equalTo()(self.view.mas_left)
            make?.right.equalTo()(self.view.mas_right)
            make?.height.equalTo()(shopNameLable.text!.getTextSize(font: 14).height + 40)
            
        }
        
        shopNameLable.mas_makeConstraints { (make) in
            make?.top.equalTo()(headerWebView.mas_bottom)?.offset()(2)
            make?.left.equalTo()(self.view.mas_left)?.offset()(20)
            make?.right.equalTo()(self.view.mas_right)?.offset()(-20)
            make?.bottom.equalTo()(shopNameSuperView.mas_bottom)
            
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
            make?.bottom.equalTo()(typeBtnSuperView.mas_bottom)
            
        }
        
        describeView = ShopDetailDescribeView.init()
        contentView.addSubview(describeView)
        describeView.mas_makeConstraints { (make) in
            make?.top.equalTo()(typeBtn.mas_bottom)?.offset()(15)
            make?.left.equalTo()(self.view.mas_left)
            make?.right.equalTo()(self.view.mas_right)
            make?.height.equalTo()(700)
            
        }
        loadWebModel()
        
    }
    
    var describeView:ShopDetailDescribeView!
    ///加载web信息模型
    func loadWebModel() {
        
        Network.dataRequest(header: nil, url: Url.getProductRelation(), param: nil, reqmethod: .GET, responseSerializerType: .responseHttp) { (result) in
            if result?.code == 1 {
                if let data = result?.responseDic["data"] as? [[String:Any]]  {
                    var models = [ShopDetailWebModel]()
                    for model in data {
                        if let m = ShopDetailWebModel.deserialize(from: model) {
                            models.append(m)
                        }
                    }
                    self.webModel = models
                }
            }
            else {
                
            }
        }
    }
}

extension ShopDetailViewController: ConfirmViewDelegate,UIWebViewDelegate{
    func didConfirm() {
        let vc = PurchaseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        headerWebView.mas_updateConstraints { (make) in
            make?.height.equalTo()(webView.scrollView.contentSize.height)
        }
    }
}
