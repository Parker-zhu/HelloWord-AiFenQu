//
//  CardViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/10.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///选择银行卡
import UIKit

class CardViewController: UIViewController {

    lazy var tableView = { () -> UITableView in
        let table = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: self.view.height - 50), style: .plain)
        
        table.delegate = self
        table.dataSource = self
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 40))
        let lable = UILabel.init(frame: header.bounds)
        lable.text = "选择发卡行"
        header.addSubview(lable)
        table.tableHeaderView = header
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.tableFooterView = UIView()
        self.view.addSubview(table)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "支付"
        
        let bgView = UIView.init()
        self.view.addSubview(bgView)
        bgView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)
            make?.bottom.equalTo()(self.view)
            make?.right.equalTo()(self.view)
            make?.height.equalTo()(50)
        }
        bgView.addSubview(bottomBtn)
        
    }
    lazy var bottomBtn: UIButton = {
        
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 50))
        btn.setTitle("选择", for: .normal)
        btn.backgroundColor = UIColor.yellow
        self.view.addSubview(btn)
        
        return btn
    }()
    func loadBottomBtn() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

extension CardViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
        
    }
}
