//
//  ReceiverInfoViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/18.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///收货人信息

import UIKit
import Masonry

class ReceiverInfoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initBottomBtn()
//        initContentTable()
    }

    
    /// 初始化Table，存放地址信息
    func initContentTable() {
        let tableView = UITableView.init()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "ReceiverInfoViewController", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        
        
        tableView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.view)
            make?.left.equalTo()(self.view)
            make?.bottom.equalTo()(self.view)?.setOffset(50)
            make?.right.equalTo()(self.view)
        }
        
    }
    
    ///初始化底部Btn
    func initBottomBtn() {
        let bottomBtn = XButton.init()
        self.view.addSubview(bottomBtn)
        bottomBtn.setTitle("新增收获地址", for: .normal)
        bottomBtn.setTitleColor(UIColor.white, for: .normal)
        bottomBtn.backgroundColor = xyellow
        bottomBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(0)
            make?.right.equalTo()(self.view)?.setOffset(0)
            make?.height.equalTo()(50)
            make?.bottom.equalTo()(self.view)?.setOffset(0)
        }
        
        weak var weakSelf = self
        bottomBtn.block = {
           //跳转至新增收货地址
            weakSelf?.navigationController?.pushViewController(ShippingAddressViewController(), animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

///Table协议
extension ReceiverInfoViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
}
