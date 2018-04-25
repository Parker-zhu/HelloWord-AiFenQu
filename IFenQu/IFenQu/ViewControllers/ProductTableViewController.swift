//
//  ProductTableViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/21.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class ProductTableViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var shopModel = [ShopModel]()
    
    lazy var tableView = { () -> UITableView in
        let table = UITableView.init(frame: self.view.bounds, style: .plain)
        table.rowHeight = 160
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = xlightGray
        table.register(UINib.init(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.view.addSubview(table)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "产品列表"
        self.view.backgroundColor = xlightGray
        loadingStatus = .loading
        loadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loadingStatus = .normal
    }
    
    func loadData() {
        Network.dataRequest(url: Url.getProducts(), reqmethod: .GET) { (result) in
            if result?.code == 1 {
            if let data = result?.responseDic["data"] as? [[String:Any]] {
                self.loadingStatus = .normal
            for model in data {
                if let m = ShopModel.deserialize(from: model) {
                    self.shopModel.append(m)
                }
            }
                self.tableView.reloadData()
            }
            } else {
                self.loadingStatus = .error
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shopModel.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell

        
        cell.setModel(model: shopModel[indexPath.row])
        return cell
    }
}
