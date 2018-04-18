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
    
    ///tableView竖直滚动的高度
    var cellHeight: CGFloat?
    var dataArr = [(String,TitleType)]()
    
    ///轮播图视图
    lazy var slideView = { () -> SlideshowView in
        
        let slide = SlideshowView.slideshowViewWithFrame(CGRect.init(x: 0, y: 0, width: self.view.width, height: 130), imageURLPaths: ["banner","banner","banner","banner","banner"], titles: [], didSelectItemAtIndex: { (index) in
            self.tableView.reloadData()
//            let vc = LoginViewController()
//
//            self.navigationController?.pushViewController(vc, animated: true)
            
            
        })
        slide.setupTimer()
        return slide
    }()
    
    ///tableView视图
    lazy var tableView = { () -> UITableView in
        let table = UITableView.init(frame: self.view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        
        table.tableHeaderView = slideView
        table.register(MainShopTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(table)
        table.tableFooterView = UIView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArr = [("热销榜",TitleType.line),("新品首发",TitleType.cicrl),("品牌专区",TitleType.cicrl),("甄选好物",TitleType.arrows)]
        tableView.backgroundColor = xlightGray
        
    }
    
    
    func loadData() {
        let param = ["":""]
        Network.dataRequest(url: "", param: param, reqmethod: .GET) { (result) in
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let param = ["productId":67]
//        Network.dataRequest(url: Url.getShopInformation(), param: nil, reqmethod: .GET) { (result) in
//
//        }
    }
    
}

extension ShopViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainShopTableViewCell
        
        let direction: UICollectionViewScrollDirection = indexPath.row == 3 ? .vertical : .horizontal
        cell.setModel(model: [], title: dataArr[indexPath.row], scrollDirection: direction) { (result) in
            print(result)
            ///返回点击的位置，会有不同跳转
            let vc = ShopDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 3 && self.cellHeight == nil {
            
            self.cellHeight = cell.cellHeight
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 3 {
            return cellHeight ?? 250
        }
        return 250
    }
    
}
