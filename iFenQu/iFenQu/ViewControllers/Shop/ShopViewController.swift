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
    
//    var slideView: SlideshowView!
    lazy var slideView = { () -> SlideshowView in
        
        let slide = SlideshowView.SlideshowViewWithFrame(CGRect.init(x: 0, y: 0, width: self.view.width, height: 200), imageURLPaths: ["banner","banner","banner","banner","banner"], titles: [], didSelectItemAtIndex: { (index) in
            
        })
        
//        slide.delegate = self
        
        return slide
    }()
    
    lazy var tableView = { () -> UITableView in
        let table = UITableView.init(frame: self.view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        
        table.register(MainShopTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(table)
        table.tableFooterView = UIView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSlideView()
        
        
    }
    
    ///初始化顶部轮播图
    func initSlideView() {
        tableView.tableHeaderView = slideView
    }
    
    func loadData() {
        let param = ["":""]
        Network.dataRequest(url: "", param: param, reqmethod: .GET) { (result) in
            
        }
    }
    
    var cellHeight:CGFloat?
    
}

extension ShopViewController: SlideshowViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    func slideshowViewScrollView(_ slideshowView: SlideshowView, didSelectItemIndex index: NSInteger) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainShopTableViewCell
        cell.setModel(model: "")
        cell.cellHeaderText = "商品详情"
        
        cell.dirction = indexPath.row != 3
        if indexPath.row == 3 && cellHeight == nil {
            cellHeight = cell.cellHeight
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 3 {
            return cellHeight ?? 250
        }
        return 250
    }
    
}
