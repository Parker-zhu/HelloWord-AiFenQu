//
//  OrderDetailViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/26.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///订单详情
import UIKit

class OrderDetailViewController: BaseViewController {
    
    var contentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单详情"
        initTableView()
    }
    
    func initTableView() {
        contentTableView = UITableView.init(frame:self.view.bounds, style: .plain)
        contentTableView.backgroundColor = xlightGray
        contentTableView.register(UINib.init(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.rowHeight = 180
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 800))
        footerView.backgroundColor = UIColor.red
        contentTableView.tableFooterView = footerView
        self.view.addSubview(contentTableView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension OrderDetailViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! OrderTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
