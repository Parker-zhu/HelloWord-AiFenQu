//
//  MessageViewController.h
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit
import MJRefresh
class MessageViewController: BaseViewController {
    
    lazy var tableView = { () -> UITableView in
        let table = UITableView.init(frame: self.view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(UINib.init(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 44
        table.rowHeight = UITableViewAutomaticDimension
        table.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadData))
        
        self.view.addSubview(table)
        return table
    }()
    
    @objc func loadData() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 240/250, green: 240/250, blue: 240/250, alpha: 1)
        tableView.backgroundColor = UIColor.init(red: 240/250, green: 240/250, blue: 240/250, alpha: 1)
        self.navigationItem.title = "消息"
//        initDataNull()
        
        
    }

    func initTableView() {
        
    }
    ///没有消息时的显示
    func initDataNull() {
        let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 40))
        lable.text = "暂无消息"
        lable.textAlignment = .center
        lable.textColor = UIColor.darkGray
        lable.center = self.view.center
        self.view.addSubview(lable)
        
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        imageView.center = self.view.center
        imageView.y = lable.frame.minY - imageView.height
        imageView.image = UIImage.init(named: "message icon")
        self.view.addSubview(imageView)
        
    }

}

extension MessageViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
        
    }
}
