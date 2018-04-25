//
//  MineViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///我的
import UIKit

class MineViewController: BaseViewController {

    var tableView: UITableView!
    var tableCellData: [(imageName:String,text:String)] = [
        ("Group 629","积分"),
        ("Group 541","我的订单"),
        ("Group 549","优惠券"),
        ("Group 552","权益券")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    func initTableView() {
        tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.view.addSubview(tableView)
        tableView.register(UINib.init(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        let header = MineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 150))
        let headerSuperView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 170))
        headerSuperView.addSubview(header)
        headerSuperView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = headerSuperView
        tableView.tableFooterView = initFooterView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.backgroundColor = xlightGray
        
    }
    func initFooterView() -> UIView {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 00, width: SCREEN_Width, height: 220))
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: SCREEN_Width/2.5, height: 200)
        layout.scrollDirection = .horizontal
        let c = UICollectionView.init(frame: CGRect.init(x: 0, y: 20, width: SCREEN_Width, height: 200), collectionViewLayout: layout)
        c.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        c.dataSource = self
        c.delegate = self
        c.backgroundColor = UIColor.white
        footerView.addSubview(c)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
}

extension MineViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCellData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MineTableViewCell
        cell.setModel(model: tableCellData[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CouponViewController()
        vc.titleSting = tableCellData[indexPath.row].text
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension MineViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShopCollectionViewCell
        cell.setModel(model: nil)
        return cell
    }
}
