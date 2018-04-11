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
    }
    
    func initTableView() {
        tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        
        tableView.register(UINib.init(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        let header = MineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 200))
        header.backgroundColor = UIColor.brown
        tableView.tableHeaderView = header
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        
        self.view.addSubview(tableView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let loginVc = LoginViewController()
        self.present(loginVc, animated: true) {
            
        }
        
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
        let v = AlertView.show(text: "")
        PopView.show(view: v)
    }
}
