//
//  ShopViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///首页

import UIKit

class ShopViewController: BaseViewController {
    @IBOutlet weak var contentTableView: UITableView!
    ///顶部轮播图高度
    var slideHeight:CGFloat = 130
    
    ///存放每个cell的高度
    var cellHeight: [CGFloat] = [250,250,150,CGFloat((6 + 1)/2 * 215 + 35 + 40)]
    
    var dataArr = [(String,TitleType)]()
    
    ///轮播图视图
    lazy var slideView = { () -> SlideshowView in
        
        let slide = SlideshowView.slideshowViewWithFrame(CGRect.init(x: 0, y: 0, width: self.view.width, height: slideHeight), imageURLPaths: ["banner","banner","banner","banner","banner"], titles: [], didSelectItemAtIndex: { (index) in
            let vc = ProductTableViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        })
        slide.setupTimer()
        return slide
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Hud.show()
        cellHeight[2] = 61/375*self.view.height
        if #available(iOS 11.0, *) {
            contentTableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        
        contentTableView.tableHeaderView = slideView
        contentTableView.register(MainShopTableViewCell.self, forCellReuseIdentifier: "cell")
        contentTableView.tableFooterView = UIView()
        dataArr = [("热销榜",TitleType.line),("新品首发",TitleType.cicrl),("品牌专区",TitleType.cicrl),("甄选好物",TitleType.arrows)]
        contentTableView.backgroundColor = xlightGray
        
        loadData()
    }
    var hotShopModels = [ShopModel](){
        didSet{
            shopModels.hot = hotShopModels
//            self.contentTableView.reloadData()
            shopModels.brand = hotShopModels
        }
    }
    var newShopModels = [ShopModel](){
        didSet{
            shopModels.new = newShopModels
//            self.contentTableView.reloadData()
        }
    }
    var goodShopModels = [ShopModel](){
        didSet{
            shopModels.good = goodShopModels
//            self.contentTableView.reloadData()
        }
    }
    var shopModels: (hot:[ShopModel],new:[ShopModel],brand:[ShopModel],good:[ShopModel]) = ([],[],[],[]) {
        didSet{
            if shopModels.brand.count != 0 && shopModels.good.count != 0 && shopModels.new.count != 0 && shopModels.hot.count != 0 {
                self.contentTableView.reloadData()
            }
        }
    }
    
    func loadData() {
        ///加载热销榜数据
//        if CacheManager.manager.dataManger.getDataFromTable(tableName: "hot").count > 0 {
//            self.hotShopModels = CacheManager.manager.dataManger.getDataFromTable(tableName: "hot")
//        }
        
        Network.dataRequest(url: Url.getHotProducts(), param: nil, reqmethod: .GET) { (result) in
            if result?.code == 1 {
                if let data = result?.responseDic["data"] as? [[String:Any]] {
                    
                    var models = [ShopModel]()
                    for model in data {
                        models.append(ShopModel.deserialize(from: model)!)
                    }
                    self.hotShopModels = models
                    CacheManager.storeCache(key: "hot", obj: models)
                }
            }
        }
//        if CacheManager.manager.dataManger.getDataFromTable(tableName: "new").count > 0 {
//            self.newShopModels = CacheManager.manager.dataManger.getDataFromTable(tableName: "new")
//        }
        ///加载新品首发数据
        Network.dataRequest(url: Url.getNewProducts(), param: nil, reqmethod: .GET) { (result) in
            if result?.code == 1 {
                if let data = result?.responseDic["data"] as? [[String:Any]] {
                    var models = [ShopModel]()
                    
                    for model in data {
                        models.append(ShopModel.deserialize(from: model)!)
                    }
                    self.newShopModels = models
                    CacheManager.storeCache(key: "new", obj: models)
                }
            }
        }
//        if CacheManager.manager.dataManger.getDataFromTable(tableName: "good").count > 0 {
//            self.goodShopModels = CacheManager.manager.dataManger.getDataFromTable(tableName: "good")
//        }
        
        Network.dataRequest(url: Url.getProducts(), reqmethod: .GET) { (result) in
            if result?.code == 1 {
                if let data = result?.responseDic["data"] as? [[String:Any]] {
                    var models = [ShopModel]()
                    for model in data {
                        if let m = ShopModel.deserialize(from: model) {
                            models.append(m)
                        }
                    }
                    self.goodShopModels = models
                    CacheManager.storeCache(key: "good", obj: models)
                    CacheManager.manager.shopGoodModels = models
                    
                }
            } else {
                
            }
        }
        
        
    }
}

extension ShopViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainShopTableViewCell
        
        cell.cellHeight = cellHeight[indexPath.row]
        
        let direction: UICollectionViewScrollDirection = indexPath.row == 3 ? .vertical : .horizontal
        var models = [ShopModel]()
        
        switch indexPath.row {
        case 0:
            models = shopModels.hot
        case 1:
            models = shopModels.new
        case 2:
            models = shopModels.hot
        default:
            models = shopModels.good
        }
        
        cell.setModel(model: models, title: dataArr[indexPath.row], scrollDirection: direction) { (result) in
            
            ///返回点击的位置，会有不同跳转
            let vc = ShopDetailViewController()
            vc.shopModel = result
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight[indexPath.row]
    }
    
}
