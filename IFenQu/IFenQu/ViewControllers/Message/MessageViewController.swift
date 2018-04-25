//
//  MessageViewController.h
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///消息控制器
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
        table.mj_footer = MJRefreshBackFooter.init(refreshingTarget: self, refreshingAction: #selector(loadData))
        
        self.view.addSubview(table)
        return table
    }()
    
    ///模型数据
    private var dataArr:[[String:Any]] = []
    ///空数据的时候显示
    var nullView:UIView!
    
    @objc private func loadData() {
        dataArr = [["":""],["":""],["":""],["":""],["":""],["":""],["":""],["":""],["":""],["":""]]
        
        tableView.reloadData()
        nullView.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        self.view.backgroundColor = xlightGray
        
        tableView.backgroundColor = xlightGray
        
        initDataNull()
        
    }
    
    ///没有消息时的显示
    private func initDataNull() {
        nullView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 90))
        nullView.backgroundColor = UIColor.clear
        nullView.center = self.view.center
        self.view.addSubview(nullView)
        
        let imageView = UIImageView.init(frame: CGRect.init(x: self.view.center.x - 25, y: 0, width: 50, height: 50))
        imageView.image = UIImage.init(named: "message icon")
        nullView.addSubview(imageView)
        
        let lable = UILabel.init(frame: CGRect.init(x: 0, y: imageView.frame.maxY, width: SCREEN_Width, height: 40))
        lable.text = "暂无消息"
        lable.textAlignment = .center
        lable.textColor = UIColor.darkGray
        nullView.addSubview(lable)
        
        
    }

}

extension MessageViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MessageTableViewCell
        
        cell.setModel(model: nil)
        
        return cell
        
    }
}
